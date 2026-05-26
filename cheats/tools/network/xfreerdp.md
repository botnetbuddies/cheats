# Xfreerdp

## rdp - exec - xfreerdp - remote

### RDP w/share

RDP into the target with cwd mapped as a drive (`tsclient`), dynamic resolution, and self-signed cert ignore. Drag-drop file transfer through the share.

```sh title:"Xfreerdp RDP with cwd shared, dynamic resolution, ignore cert"
xfreerdp3 /drive:./ /dynamic-resolution /cert:ignore /v:$rhost_ip /u:"$user" /p:'$pass'
```
<!-- cheat
import users
import passwords
var rhost_ip
-->

### RDP classic

RDP into the target with domain credentials.

```sh title:"Xfreerdp RDP with domain credentials"
xfreerdp3 /dynamic-resolution /cert:ignore /u:"$user" /p:'$pass' /d:"$domain" /v:"$rhost_ip"
```
<!-- cheat
var user
var pass
var domain
var rhost_ip
-->

### RDP pass the hash

RDP into the target using the NT hash.

```sh title:"RDP pass-the-hash with xfreerdp"
xfreerdp3 /cert:ignore /u:"$user" /pth:"$hash" /d:"$domain" /v:"$rhost_ip"
```
<!-- cheat
var user
var hash
var domain
var rhost_ip
-->
