---
technique: MSSQL Enumeration
category: databases
targets: Microsoft SQL Server
protocols: TDS
remote_capable: true
tags: network-services mssql database
---

# MSSQL Enumeration

MSSQL enumeration checks instance metadata, authentication, database access, linked servers, and dangerous features such as `xp_cmdshell`.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 1433 | Named instances may use dynamic ports |
| Credentials | Windows and SQL authentication may both matter |
| Privileges | Feature checks depend on SQL role membership |

## Linux

### Nmap enum

#sh #nmap #mssql

Run MSSQL nmap enumeration scripts.

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

### sqsh connect

#sh #mssql #sqsh

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

### Metasploit enum

#sh #metasploit #mssql

Enumerate MSSQL configuration with Metasploit.

```sh title:"Enumerate MSSQL configuration"
msfconsole -x "use auxiliary/admin/mssql/mssql_enum; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; set PASSWORD $pass; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user
var pass
-->

### Linked servers

#sh #metasploit #mssql

Run the MSSQL link crawler.

```sh title:"Run MSSQL link crawler"
msfconsole -x "use exploit/windows/mssql/mssql_linkcrawler; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; set PASSWORD $pass; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 1433
var user
var pass
-->
