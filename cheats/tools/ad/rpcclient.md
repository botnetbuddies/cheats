# Rpcclient

Samba's MS-RPC client. Most enumeration commands work over a null session (no creds) against unhardened targets, and authenticated sessions unlock the full MS-SAMR / MS-LSAT command surface. Run `rpcclient $rhost_ip -U "" -N` for an interactive shell, or use `-c "cmd;quit"` for one-shot calls.

<!-- cheat
export rpcclient_auth
var auth_method = printf 'null\tNull session (no creds)\npassword\tUse password\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode" --map "cut -f1"

if $auth_method == null
var auth_flags := -U "" -N
fi

if $auth_method == password
var credential --- --header "Credential"
var auth_flags := -U "$user%$credential"
fi
-->

## rpcclient - interactive

### Null session shell

Enumerate null session shell with Rpcclient.

Drop into rpcclient with no creds. Test target tolerance for null sessions before scripting.

```sh title:"Rpcclient Enumerate Null Session Shell"
rpcclient -U "" -N $rhost_ip
```
<!-- cheat
import domain_ip
-->

### Authenticated shell

Read authenticated shell with Rpcclient.

Drop into an interactive rpcclient with valid creds. Use this for ad-hoc poking; the entries below are one-shot equivalents.

```sh title:"Rpcclient Read Authenticated Shell"
rpcclient $rhost_ip $auth_flags
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

## rpcclient - server info

### srvinfo

Show srvinfo with Rpcclient.

Show the target's basic server info (OS, server type flags, comment).

```sh title:"Rpcclient Show Srvinfo"
rpcclient $rhost_ip $auth_flags -c "srvinfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### querydominfo

Download querydominfo with Rpcclient.

Pull domain info (name, server count, role).

```sh title:"Rpcclient Download Querydominfo"
rpcclient $rhost_ip $auth_flags -c "querydominfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### getdompwinfo

Download getdompwinfo with Rpcclient.

Pull the domain password policy - run before spraying so you don't lock accounts.

```sh title:"Rpcclient Download Getdompwinfo"
rpcclient $rhost_ip $auth_flags -c "getdompwinfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### netshareenum

Show netshareenum with Rpcclient.

List shares on the target via MS-SRVS.

```sh title:"Rpcclient Show Netshareenum"
rpcclient $rhost_ip $auth_flags -c "netshareenum;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

## rpcclient - users & groups

### enumdomusers

Enumerate enumdomusers with Rpcclient.

Enumerate all domain users with their RIDs.

```sh title:"Rpcclient Enumerate Enumdomusers"
rpcclient $rhost_ip $auth_flags -c "enumdomusers;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### enumdomgroups

Enumerate enumdomgroups with Rpcclient.

Enumerate domain groups with their RIDs.

```sh title:"Rpcclient Enumerate Enumdomgroups"
rpcclient $rhost_ip $auth_flags -c "enumdomgroups;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### querygroup

Show querygroup with Rpcclient.

Show group info (name, description) for a specific RID.

```sh title:"Rpcclient Show Querygroup"
rpcclient $rhost_ip $auth_flags -c "querygroup $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### querygroupmem

List querygroupmem with Rpcclient.

List members of a group by RID.

```sh title:"Rpcclient List Querygroupmem"
rpcclient $rhost_ip $auth_flags -c "querygroupmem $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### queryuser

Show queryuser with Rpcclient.

Show detailed user info by RID (last logon, bad password count, UAC flags).

```sh title:"Rpcclient Show Queryuser"
rpcclient $rhost_ip $auth_flags -c "queryuser $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### getusrdompwinfo

Dump getusrdompwinfo with Rpcclient.

Per-user password policy (PSO-aware - returns the policy that actually applies to this account).

```sh title:"Rpcclient Dump Getusrdompwinfo"
rpcclient $rhost_ip $auth_flags -c "getusrdompwinfo $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

## rpcclient - LSA

### lsaenumsid

Enumerate lsaenumsid with Rpcclient.

Enumerate every SID known to the local LSA - reveals well-known principals and SID-history values.

```sh title:"Rpcclient Enumerate Lsaenumsid"
rpcclient $rhost_ip $auth_flags -c "lsaenumsid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### lookupsid

Run lookupsid with Rpcclient.

Translate a single SID to its principal name.

```sh title:"Rpcclient Run Lookupsid"
rpcclient $rhost_ip $auth_flags -c "lookupsid $sid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var sid
-->

### lookupnames

Run lookupnames with Rpcclient.

Translate a principal name to its SID.

```sh title:"Rpcclient Run Lookupnames"
rpcclient $rhost_ip $auth_flags -c "lookupnames $name;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var name
-->

## rpcclient - attack

### Reset user password (setuserinfo2)

Dump reset user password (setuserinfo2) with Rpcclient.

Set a target user's password via MS-SAMR. Requires `User-Force-Change-Password` extended right (or higher) on the target.

```sh title:"Rpcclient Dump Reset User Password (setuserinfo2)"
rpcclient $rhost_ip $auth_flags -c "setuserinfo2 $target_user 23 '$new_pass';quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var target_user
var new_pass
-->

### Username=password spray

Dump username=password spray with Rpcclient.

Spray a userlist trying each username as its own password. Fast first check on most engagements.

```sh title:"Rpcclient Dump Username=password Spray"
for u in $(cat $users_file); do echo -n "user: $u "; rpcclient -U "$u%$u" -c "getusername;quit" $rhost_ip; done
```
<!-- cheat
import domain_ip
var users_file
-->
