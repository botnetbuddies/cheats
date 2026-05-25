# Net

## net - commands

### Local password policy

Dump local password policy with Net.

Show local password requirements (min length, age, lockout) for the current host.

```sh title:"Net Dump Local Password Policy"
net accounts
```
<!-- cheat -->

### Domain password policy

Dump domain password policy with Net.

Show domain-wide password and lockout policy. Read this before spraying so you don't trip lockout.

```sh title:"Net Dump Domain Password Policy"
net accounts /domain
```
<!-- cheat -->

### Domain groups

List domain groups with Net.

List every domain group from a domain-joined host.

```sh title:"Net List Domain Groups"
net group /domain
```
<!-- cheat -->

### Domain Admins

Execute domain admins with Net.

Members of the Domain Admins group. Top of the privilege chain.

```sh title:"Net Execute Domain Admins"
net group "Domain Admins" /domain
```
<!-- cheat -->

### Domain Computers

Execute domain computers with Net.

Every machine account joined to the domain.

```sh title:"Net Execute Domain Computers"
net group "Domain Computers" /domain
```
<!-- cheat -->

### Domain Controllers

Execute domain controllers with Net.

DC machine accounts.

```sh title:"Net Execute Domain Controllers"
net group "Domain Controllers" /domain
```
<!-- cheat -->

### Members of named group

Execute members of named group with Net.

Members of an arbitrary domain group.

```sh title:"Net Execute Members of Named Group"
net group $domain_group_name /domain
```
<!-- cheat
var domain_group_name
-->

### Domain groups (alt)

List domain groups (alt) with Net.

Alternate spelling that returns the full group list.

```sh title:"Net List Domain Groups (alt)"
net groups /domain
```
<!-- cheat -->

### All local groups

Execute all local groups with Net.

Local groups on the current host (including custom ones).

```sh title:"Net Execute All Local Groups"
net localgroup
```
<!-- cheat -->

### Domain admins via local

Execute domain admins via local with Net.

Members of the local Administrators group queried from the domain. Often returns the cross-domain admin list.

```sh title:"Net Execute Domain Admins Via Local"
net localgroup administrators /domain
```
<!-- cheat -->

### Local Administrators

Execute local administrators with Net.

Members of the local Administrators group on this host.

```sh title:"Net Execute Local Administrators"
net localgroup Administrators
```
<!-- cheat -->

### Add to Administrators

Add Net to administrators.

Promote a user to local Administrators. Requires existing admin.

```sh title:"Net Add to Administrators"
net localgroup administrators $user /add
```
<!-- cheat
var user
-->

### Local shares

List local shares with Net.

List shares published by the current host.

```sh title:"Net List Local Shares"
net share
```
<!-- cheat -->

### Domain user info

Show domain user info with Net.

Detail page for a single domain user (group membership, last logon, password changes).

```sh title:"Net Show Domain User Info"
net user $ACCOUNT_NAME /domain
```
<!-- cheat
var ACCOUNT_NAME
-->

### List domain users

List domain users with Net.

List every domain user (no detail).

```sh title:"Net List Domain Users"
net user /domain
```
<!-- cheat -->

### Current user info

Show current user info with Net.

Local detail page for the user whose context we are currently in.

```sh title:"Net Show Current User Info"
net user %username%
```
<!-- cheat -->

### Mount remote share

Mount remote share with Net.

Mount a remote SMB share to drive `x:` with explicit credentials.

```sh title:"Net Mount Remote Share"
net use x: \\$rhost_name\$share /user:$user $pass
```
<!-- cheat
var rhost_name
var share
var user
var pass
-->

### View browse list

List view browse list with Net.

Show the legacy NetBIOS browse list (computers visible on the local segment).

```sh title:"Net List View Browse List"
net view
```
<!-- cheat -->

### Domain shares

Execute domain shares with Net.

Browse domain-wide for shares (includes hidden shares with `/all`).

```sh title:"Net Execute Domain Shares"
net view /all /domain
```
<!-- cheat -->

### Shares on host

Execute shares on host with Net.

Shares published by a specific host, including admin/hidden ($) shares.

```sh title:"Net Execute Shares on Host"
net view \\$rhost_name /ALL
```
<!-- cheat
var rhost_name
-->

### Domain hosts

Execute domain hosts with Net.

Computers in the domain via the legacy browser service.

```sh title:"Net Execute Domain Hosts"
net view /domain
```
<!-- cheat -->

