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

Probe a host with empty creds - some older / misconfigured boxes still allow anonymous SMB enumeration.

```sh title:"NetExec Auth Probe SMB with empty creds (null session test)"
nxc smb $rhost_ip -u '' -p ''
```
<!-- cheat
import domain_ip
-->

### Anonymous login

Same as null session but with a dummy username - some hosts require a non-empty user but accept any creds.

```sh title:"NetExec Auth Probe SMB with bogus username + empty password (anonymous)"
nxc smb $rhost_ip -u 'a' -p ''
```
<!-- cheat
import domain_ip
-->

### Active SMB sessions

List sessions currently established to the target's IPC$. Pre-2016 hosts allow this anonymously; modern hosts need creds.

```sh title:"NetExec Auth List established SMB sessions on target"
nxc smb $domain -u $user $auth_flags --sessions
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

## nxc password spray

### Spray (one user per password)

Spray each user-line against the matching password-line (no full cartesian product). Use after generating a wordlist where line N is the password for user N.

```sh title:"NetExec Auth Spray user-N vs password-N (no cartesian product)"
nxc smb $rhost_ip -u $users_file -p $passwords_file --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var passwords_file
-->

### Spray (all users vs single password)

Try every user against one common password - safest spray pattern for avoiding lockouts.

```sh title:"NetExec Auth Try every user with one password (cleanest spray)"
nxc smb $rhost_ip -u $users_file -p $single_password --continue-on-success
```
<!-- cheat
import domain_ip
var users_file
var single_password
-->
