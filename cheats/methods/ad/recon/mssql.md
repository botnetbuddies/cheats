---
technique: MSSQL Recon
category: recon
targets: Microsoft SQL Server
protocols: TDS, MSSQL, SMB
remote_capable: true
tags: mssql sql-server netexec mssqlclient recon coercion ad
---

# MSSQL Recon

SQL Server instances are common in AD environments and often run under domain principals. Enumerate logins, linked servers, impersonation rights, and relay posture before attempting SQL-side execution or lateral movement.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SQL reachable | TCP 1433 or the configured instance port must be reachable |
| Credentials | Windows or SQL credentials are needed for authenticated enumeration |
| Privilege context | Linked server, impersonation, and xp_cmdshell paths depend on SQL role membership |

## Windows

No Windows operator command is included here. The local confirmed commands for this pass use NetExec and Impacket from Linux.

## Linux

### Run arbitrary query

#netexec #mssql #query

Run a T-SQL query against an MSSQL instance with the authenticated principal.

```sh title:"Run MSSQL query with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -q "$query"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var query
-->

### List sysadmin members

#netexec #mssql #sysadmin

List SQL logins that belong to the `sysadmin` server role.

```sh title:"List MSSQL sysadmin role members with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -q "EXEC sp_helpsrvrolemember 'sysadmin';"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Enumerate SQL logins

#netexec #mssql #logins

Enumerate SQL logins through the netexec module.

```sh title:"Enumerate MSSQL logins with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -M enum_logins
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Enumerate impersonation

#netexec #mssql #impersonation

List MSSQL users with impersonation privileges.

```sh title:"Enumerate MSSQL impersonation rights with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -M enum_impersonate
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Enumerate linked servers

#netexec #mssql #linked-servers

Enumerate linked SQL servers and their login configuration.

```sh title:"Enumerate linked MSSQL servers with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -M enum_links
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Check MSSQL channel binding

#netexec #mssql #relay

Check whether Channel Binding or Extended Protection is enforced for an MSSQL relay path.

```sh title:"Check MSSQL channel binding with netexec"
nxc mssql "$domain" -u "$user" $auth_flags -M mssql_cbt
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Open Impacket MSSQL shell

#impacket #mssql #windows-auth

Open an interactive MSSQL shell with Windows authentication.

```sh title:"Open MSSQL shell with Impacket mssqlclient"
mssqlclient.py -windows-auth "$auth_target" $auth_flags
```
<!-- cheat
import domain_ip
import users
import impacket_auth
-->
