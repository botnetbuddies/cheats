# Net

## net - commands

### Local password policy

Show local password requirements (min length, age, lockout) for the current host.

```sh title:"Show local password / lockout policy"
net accounts
```
<!-- cheat -->

### Domain password policy

Show domain-wide password and lockout policy. Read this before spraying so you don't trip lockout.

```sh title:"Show domain password / lockout policy before spraying"
net accounts /domain
```
<!-- cheat -->

### Domain groups

List every domain group from a domain-joined host.

```sh title:"List every domain group from a domain-joined host"
net group /domain
```
<!-- cheat -->

### Domain Admins

Members of the Domain Admins group. Top of the privilege chain.

```sh title:"Members of Domain Admins (top privilege)"
net group "Domain Admins" /domain
```
<!-- cheat -->

### Domain Computers

Every machine account joined to the domain.

```sh title:"Every machine account joined to the domain"
net group "Domain Computers" /domain
```
<!-- cheat -->

### Domain Controllers

DC machine accounts.

```sh title:"DC machine accounts"
net group "Domain Controllers" /domain
```
<!-- cheat -->

### Members of named group

Members of an arbitrary domain group.

```sh title:"Members of an arbitrary domain group by name"
net group $domain_group_name /domain
```
<!-- cheat
var domain_group_name
-->

### Domain groups (alt)

Alternate spelling that returns the full group list.

```sh title:"Alternate spelling that returns full group list"
net groups /domain
```
<!-- cheat -->

### All local groups

Local groups on the current host (including custom ones).

```sh title:"Local groups on current host (incl. custom)"
net localgroup
```
<!-- cheat -->

### Domain admins via local

Members of the local Administrators group queried from the domain. Often returns the cross-domain admin list.

```sh title:"local Administrators queried at domain scope"
net localgroup administrators /domain
```
<!-- cheat -->

### Local Administrators

Members of the local Administrators group on this host.

```sh title:"Members of local Administrators group on this host"
net localgroup Administrators
```
<!-- cheat -->

### Add to Administrators

Promote a user to local Administrators. Requires existing admin.

```sh title:"Promote user to local Administrators (needs admin)"
net localgroup administrators $user /add
```
<!-- cheat
var user
-->

### Local shares

List shares published by the current host.

```sh title:"List shares published by current host"
net share
```
<!-- cheat -->

### Domain user info

Detail page for a single domain user (group membership, last logon, password changes).

```sh title:"Detail page for one domain user"
net user $ACCOUNT_NAME /domain
```
<!-- cheat
var ACCOUNT_NAME
-->

### List domain users

List every domain user (no detail).

```sh title:"List every domain user (names only)"
net user /domain
```
<!-- cheat -->

### Current user info

Local detail page for the user whose context we are currently in.

```sh title:"Detail page for current logged-on user"
net user %username%
```
<!-- cheat -->

### Mount remote share

Mount a remote SMB share to drive `x:` with explicit credentials.

```sh title:"Mount remote SMB share to drive x: with credentials"
net use x: \\$rhost_name\$share /user:$user $pass
```
<!-- cheat
var rhost_name
var share
var user
var pass
-->

### View browse list

Show the legacy NetBIOS browse list (computers visible on the local segment).

```sh title:"Legacy NetBIOS browse list of visible computers"
net view
```
<!-- cheat -->

### Domain shares

Browse domain-wide for shares (includes hidden shares with `/all`).

```sh title:"Domain-wide share browse including hidden shares"
net view /all /domain
```
<!-- cheat -->

### Shares on host

Shares published by a specific host, including admin/hidden ($) shares.

```sh title:"Shares on a host including admin/hidden ($) shares"
net view \\$rhost_name /ALL
```
<!-- cheat
var rhost_name
-->

### Domain hosts

Computers in the domain via the legacy browser service.

```sh title:"Domain computers via legacy browser service"
net view /domain
```
<!-- cheat -->

