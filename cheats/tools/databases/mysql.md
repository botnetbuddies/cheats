# Mysql

## mysql LOCAL (CLI)

### Show databases

Show databases with Mysql.

List every MySQL database visible to the authenticated user. First triage step before picking a target DB.

```sh title:"Mysql Show Databases"
mysql -u $user -p$pass -h localhost -e "show databases;"
```
<!-- cheat
import users
var pass
-->

### Show tables

Show tables with Mysql.

List tables in a specific database.

```sh title:"Mysql Show Tables"
mysql -u $user -p$pass -h localhost -D $database -e "show tables;"
```
<!-- cheat
import users
var pass
var database
-->

### Dump table

Dump table with Mysql.

Read every row from a table. Watch for size before running on large tables.

```sh title:"Mysql Dump Table"
mysql -u $user -p$pass -h localhost -D $database -e "select * from $table;"
```
<!-- cheat
import users
var pass
var database
var table
-->

### Interactive shell

Spawn interactive shell with Mysql.

Drop into the interactive `mysql>` shell against the chosen database.

```sh title:"Mysql Spawn Interactive Shell"
mysql -u $user -h localhost -D $database -p
```
<!-- cheat
import users
var database
-->

## mysql REMOTE (CLI)

### Remote connect

Run remote connect with Mysql.

Connect to a remote MySQL server and database.

```sh title:"Mysql Run Remote Connect"
mysql -u "$user" -p"$pass" -h "$rhost_ip" "$database"
```
<!-- cheat
var user
var pass
var rhost_ip
var database
-->

### Remote show databases

Show remote show databases with Mysql.

List databases visible to the authenticated remote user.

```sh title:"Mysql Show Remote Show Databases"
mysql -u "$user" -p"$pass" -h "$rhost_ip" -e "show databases;"
```
<!-- cheat
var user
var pass
var rhost_ip
-->

### Remote show tables

Show remote show tables with Mysql.

List tables in a remote database.

```sh title:"Mysql Show Remote Show Tables"
mysql -u "$user" -p"$pass" -h "$rhost_ip" -D "$database" -e "show tables;"
```
<!-- cheat
var user
var pass
var rhost_ip
var database
-->

### Create database

Create database with Mysql.

Create a UTF8MB4 database.

```sh title:"Mysql Create Database"
mysql -u "$user" -p -e "CREATE DATABASE $database CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
```
<!-- cheat
var user
var database
-->

### Export database

Dump export database with Mysql.

Dump a database to a SQL file.

```sh title:"Mysql Dump Export Database"
mysqldump -u "$user" -p "$database" > "$dump_file"
```
<!-- cheat
var user
var database
var dump_file
-->

### Import database

Dump import database with Mysql.

Import a SQL dump into a database.

```sh title:"Mysql Dump Import Database"
mysql -u "$user" -p "$database" < "$dump_file"
```
<!-- cheat
var user
var database
var dump_file
-->

## mysql RECON

### Nmap enum

Enumerate nmap enum with Mysql.

Run MySQL-focused nmap scripts.

```sh title:"Mysql Enumerate Nmap Enum"
nmap -sV -p 3306 --script mysql-audit,mysql-databases,mysql-dump-hashes,mysql-empty-password,mysql-enum,mysql-info,mysql-query,mysql-users,mysql-variables,mysql-vuln-cve2012-2122 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
