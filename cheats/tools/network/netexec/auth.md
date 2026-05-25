# NetExec Auth

<!-- cheat
export nxc_auth
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
var auth_flags := -k --use-kcache
fi
-->

## nxc auth checks

### Null session

Probe null session with NetExec Auth.

```sh title:"NetExec Auth Probe Null Session"
nxc smb $rhost_ip -u '' -p ''
```
<!-- cheat
import domain_ip
-->

### Anonymous login

Dump anonymous login with NetExec Auth.

```sh title:"NetExec Auth Dump Anonymous Login"
nxc smb $rhost_ip -u 'a' -p ''
```
<!-- cheat
import domain_ip
-->

### Active SMB sessions

Check active SMB sessions with NetExec Auth.

```sh title:"NetExec Auth Check Active SMB Sessions"
nxc smb $domain -u $user $auth_flags --sessions
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

## nxc password spray

### Spray (one user per password)

Dump spray (one user per password) with NetExec Auth.

```sh title:"NetExec Auth Dump Spray (one User Per Password)"
nxc smb $rhost_ip -u $users_file -p $passwords_file --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var passwords_file
-->

### Spray (all users vs single password)

Dump spray (all users vs single password) with NetExec Auth.

```sh title:"NetExec Auth Dump Spray (all Users Vs Single Password)"
nxc smb $rhost_ip -u $users_file -p $single_password --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var single_password
-->
