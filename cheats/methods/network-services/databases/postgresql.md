---
technique: PostgreSQL Enumeration
category: databases
targets: PostgreSQL
protocols: PostgreSQL
remote_capable: true
tags: network-services postgresql database
---

# PostgreSQL Enumeration

PostgreSQL enumeration checks access, visible databases, roles, extensions, and weak authentication.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 5432 | Requires PostgreSQL reachability |
| Credentials | Password, trust, peer, or certificate auth may apply |
| Privileges | Catalog visibility depends on grants |

## Linux

### Nmap enum

#sh #nmap #postgresql

Run PostgreSQL nmap scripts.

```sh title:"Run PostgreSQL nmap scripts"
nmap -sV -p "$rport" --script pgsql-brute,pgsql-databases,pgsql-empty-password "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5432
-->

### Connect

#sh #psql

Connect to PostgreSQL and prompt for a password.

```sh title:"Connect to PostgreSQL"
psql -h "$rhost_ip" -U "$user"
```
<!-- cheat
var rhost_ip
var user
-->

### Connect database

#sh #psql

Connect to a specific PostgreSQL database.

```sh title:"Connect to PostgreSQL database"
psql -h "$rhost_ip" -U "$user" -d "$database"
```
<!-- cheat
var rhost_ip
var user
var database
-->

### List databases

#sh #psql

List PostgreSQL databases.

```sh title:"List PostgreSQL databases"
psql -h "$rhost_ip" -U "$user" -c "\\l"
```
<!-- cheat
var rhost_ip
var user
-->

### List roles

#sh #psql

List PostgreSQL roles.

```sh title:"List PostgreSQL roles"
psql -h "$rhost_ip" -U "$user" -c "\\du"
```
<!-- cheat
var rhost_ip
var user
-->
