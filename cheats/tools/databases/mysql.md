# Mysql

## mysql LOCAL (CLI)

### Show databases

List every MySQL database visible to the authenticated user. First triage step before picking a target DB.

```sh title:"List MySQL databases visible to authed user"
mysql -u $user -p$pass -h localhost -e "show databases;"
```
<!-- cheat
import users
var pass
-->

### Show tables

List tables in a specific database.

```sh title:"List tables in named MySQL database"
mysql -u $user -p$pass -h localhost -D $database -e "show tables;"
```
<!-- cheat
import users
var pass
var database
-->

### Dump table

Read every row from a table. Watch for size before running on large tables.

```sh title:"SELECT * dump of named table, watch size"
mysql -u $user -p$pass -h localhost -D $database -e "select * from $table;"
```
<!-- cheat
import users
var pass
var database
var table
-->

### Interactive shell

Drop into the interactive `mysql>` shell against the chosen database.

```sh title:"Interactive mysql> shell against chosen database"
mysql -u $user -h localhost -D $database -p
```
<!-- cheat
import users
var database
-->

## mysql REMOTE (CLI)

### Remote connect

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

### Create database

Create a UTF8MB4 database.

```sh title:"Create UTF8MB4 MySQL database"
mysql -u "$user" -p -e "CREATE DATABASE $database CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
```
<!-- cheat
var user
var database
-->

### Export database

Dump a database to a SQL file.

```sh title:"Dump MySQL database to file"
mysqldump -u "$user" -p "$database" > "$dump_file"
```
<!-- cheat
var user
var database
var dump_file
-->

### Import database

Import a SQL dump into a database.

```sh title:"Import SQL dump into MySQL database"
mysql -u "$user" -p "$database" < "$dump_file"
```
<!-- cheat
var user
var database
var dump_file
-->

## mysql RECON

### Nmap enum

Run MySQL-focused nmap scripts.

```sh title:"Run MySQL nmap enumeration scripts"
nmap -sV -p 3306 --script mysql-audit,mysql-databases,mysql-dump-hashes,mysql-empty-password,mysql-enum,mysql-info,mysql-query,mysql-users,mysql-variables,mysql-vuln-cve2012-2122 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
