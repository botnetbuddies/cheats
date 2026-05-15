---
technique: LDAP Enumeration
category: directory-services
targets: LDAP
protocols: LDAP, LDAPS
remote_capable: true
tags: network-services ldap directory
---

# LDAP Enumeration

LDAP enumeration checks RootDSE metadata, anonymous reads, naming contexts, users, groups, and authenticated directory visibility.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 389 or 636 | Requires LDAP or LDAPS reachability |
| Base DN | Directory searches need a naming context |
| Credentials | Anonymous and authenticated visibility may differ heavily |

## Linux

### Root DSE

#sh #ldapsearch #ldap

Query the LDAP RootDSE.

```sh title:"Query LDAP RootDSE"
ldapsearch -x -H "ldap://$rhost_name" -s base
```
<!-- cheat
var rhost_name
-->

### Anonymous base search

#sh #ldapsearch #ldap

Run an anonymous LDAP search from a base DN.

```sh title:"Run anonymous LDAP base search"
ldapsearch -x -H "ldap://$rhost_name" -b "$base_dn"
```
<!-- cheat
var rhost_name
var base_dn
-->

### LDAP NSE scripts

#sh #nmap #ldap

Run LDAP nmap scripts except brute force scripts.

```sh title:"Run LDAP nmap enumeration scripts"
nmap -n -sV --script "ldap* and not brute" -p 389 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Authenticated users

#sh #ldapsearch #ldap

List users with simple bind credentials.

```sh title:"List LDAP users with simple bind"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" "(&(objectCategory=person)(objectClass=user))"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->

### Authenticated groups

#sh #ldapsearch #ldap

List groups with simple bind credentials.

```sh title:"List LDAP groups with simple bind"
ldapsearch -x -H "ldap://$rhost_name" -D "$domain\\$user" -w "$pass" -b "$base_dn" "(objectClass=group)"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var base_dn
-->
