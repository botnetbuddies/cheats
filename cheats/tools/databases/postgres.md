# Postgres

## connect

### Connect

Connect to a PostgreSQL server and prompt for a password.

```sh title:"Connect to PostgreSQL"
psql -h "$rhost_ip" -U "$user"
```
<!-- cheat
var rhost_ip
var user
-->

### Connect database

Connect to a specific PostgreSQL database.

```sh title:"Connect to PostgreSQL database"
psql -h "$rhost_ip" -U "$user" -d "$database"
```
<!-- cheat
var rhost_ip
var user
var database
-->

### Full options

Connect to PostgreSQL with host, port, user, password, and database.

```sh title:"Connect to PostgreSQL with full options"
PGPASSWORD="$pass" psql -h "$rhost_ip" -p "$rport" -U "$user" -d "$database"
```
<!-- cheat
var pass
var rhost_ip
var rport := 5432
var user
var database
-->

## recon

### Nmap enum

Run PostgreSQL nmap scripts.

```sh title:"Run PostgreSQL nmap scripts"
nmap -sV -p "$rport" --script pgsql-brute,pgsql-databases,pgsql-empty-password "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5432
-->
