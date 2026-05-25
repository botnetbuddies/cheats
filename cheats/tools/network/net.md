# Net

## net - commands

### Local password policy

Dump local password policy with Net.

```sh title:"Net Dump Local Password Policy"
net accounts
```
<!-- cheat -->

### Domain password policy

Dump domain password policy with Net.

```sh title:"Net Dump Domain Password Policy"
net accounts /domain
```
<!-- cheat -->

### Domain groups

List domain groups with Net.

```sh title:"Net List Domain Groups"
net group /domain
```
<!-- cheat -->

### Domain Admins

Execute domain admins with Net.

```sh title:"Net Execute Domain Admins"
net group "Domain Admins" /domain
```
<!-- cheat -->

### Domain Computers

Execute domain computers with Net.

```sh title:"Net Execute Domain Computers"
net group "Domain Computers" /domain
```
<!-- cheat -->

### Domain Controllers

Execute domain controllers with Net.

```sh title:"Net Execute Domain Controllers"
net group "Domain Controllers" /domain
```
<!-- cheat -->

### Members of named group

Execute members of named group with Net.

```sh title:"Net Execute Members of Named Group"
net group $domain_group_name /domain
```
<!-- cheat
var domain_group_name
-->

### Domain groups (alt)

List domain groups (alt) with Net.

```sh title:"Net List Domain Groups (alt)"
net groups /domain
```
<!-- cheat -->

### All local groups

Execute all local groups with Net.

```sh title:"Net Execute All Local Groups"
net localgroup
```
<!-- cheat -->

### Domain admins via local

Execute domain admins via local with Net.

```sh title:"Net Execute Domain Admins Via Local"
net localgroup administrators /domain
```
<!-- cheat -->

### Local Administrators

Execute local administrators with Net.

```sh title:"Net Execute Local Administrators"
net localgroup Administrators
```
<!-- cheat -->

### Add to Administrators

Add Net to administrators.

```sh title:"Net Add to Administrators"
net localgroup administrators $user /add
```
<!-- cheat
var user
-->

### Local shares

List local shares with Net.

```sh title:"Net List Local Shares"
net share
```
<!-- cheat -->

### Domain user info

Show domain user info with Net.

```sh title:"Net Show Domain User Info"
net user $ACCOUNT_NAME /domain
```
<!-- cheat
var ACCOUNT_NAME
-->

### List domain users

List domain users with Net.

```sh title:"Net List Domain Users"
net user /domain
```
<!-- cheat -->

### Current user info

Show current user info with Net.

```sh title:"Net Show Current User Info"
net user %username%
```
<!-- cheat -->

### Mount remote share

Mount remote share with Net.

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

```sh title:"Net List View Browse List"
net view
```
<!-- cheat -->

### Domain shares

Execute domain shares with Net.

```sh title:"Net Execute Domain Shares"
net view /all /domain
```
<!-- cheat -->

### Shares on host

Execute shares on host with Net.

```sh title:"Net Execute Shares on Host"
net view \\$rhost_name /ALL
```
<!-- cheat
var rhost_name
-->

### Domain hosts

Execute domain hosts with Net.

```sh title:"Net Execute Domain Hosts"
net view /domain
```
<!-- cheat -->

