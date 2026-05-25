# Postgres

## connect

### Connect

Run connect with Postgres.

```sh title:"Postgres Run Connect"
psql -h "$rhost_ip" -U "$user"
```
<!-- cheat
var rhost_ip
var user
-->

### Connect database

Run connect database with Postgres.

```sh title:"Postgres Run Connect Database"
psql -h "$rhost_ip" -U "$user" -d "$database"
```
<!-- cheat
var rhost_ip
var user
var database
-->

### Full options

Run full options with Postgres.

```sh title:"Postgres Run Full Options"
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

Enumerate nmap enum with Postgres.

```sh title:"Postgres Enumerate Nmap Enum"
nmap -sV -p "$rport" --script pgsql-brute,pgsql-databases,pgsql-empty-password "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5432
-->
