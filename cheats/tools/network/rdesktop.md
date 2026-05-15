# Rdesktop

## connect

### Password

Connect to RDP with rdesktop.

```sh title:"Connect to RDP with rdesktop"
rdesktop -g 90% "$rhost_ip" -u "$user" -p "$pass" -d "$domain"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
-->

### Share

Connect to RDP with rdesktop and mount a local share.

```sh title:"Connect to RDP with rdesktop and local share"
rdesktop -g 90% "$rhost_ip" -u "$user" -p "$pass" -d "$domain" -r "disk:share=$share"
```
<!-- cheat
var rhost_ip
var user
var pass
var domain
var share
-->
