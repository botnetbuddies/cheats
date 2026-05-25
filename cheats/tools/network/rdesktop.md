# Rdesktop

## connect

### Password

Dump password with Rdesktop.

```sh title:"Rdesktop Dump Password"
rdesktop -g 90% "$rhost_ip" -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Share

Run share with Rdesktop.

```sh title:"Rdesktop Run Share"
rdesktop -g 90% "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -r "disk:share=$share"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
var share
-->
