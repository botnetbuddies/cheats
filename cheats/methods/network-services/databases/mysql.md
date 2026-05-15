---
technique: MySQL Enumeration
category: databases
targets: MySQL, MariaDB
protocols: MySQL
remote_capable: true
tags: network-services mysql database
---

# MySQL Enumeration

MySQL enumeration checks server metadata, empty passwords, visible databases, users, and application data access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 3306 | Requires MySQL reachability |
| Credentials | Local and remote authentication behavior may differ |
| Privileges | Query output depends on database grants |

## Linux

### Nmap enum

#sh #nmap #mysql

Run MySQL-focused nmap scripts.

```sh title:"Run MySQL nmap enumeration scripts"
nmap -sV -p 3306 --script mysql-audit,mysql-databases,mysql-dump-hashes,mysql-empty-password,mysql-enum,mysql-info,mysql-query,mysql-users,mysql-variables,mysql-vuln-cve2012-2122 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Remote connect

#sh #mysql

Connect to a remote MySQL server and database.

```sh title:"Connect to remote MySQL database"
mysql -u "$user" -p"$pass" -h "$rhost_ip" "$database"
```
<!-- cheat
var user
var pass
var rhost_ip
var database
-->

### Show databases

#sh #mysql

List databases visible to the authenticated user.

```sh title:"List MySQL databases"
mysql -u "$user" -p"$pass" -h "$rhost_ip" -e "show databases;"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Show tables

#sh #mysql

List tables in a database.

```sh title:"List MySQL tables"
mysql -u "$user" -p"$pass" -h "$rhost_ip" -D "$database" -e "show tables;"
```
<!-- cheat
var user
var pass
var rhost_ip
var database
-->
