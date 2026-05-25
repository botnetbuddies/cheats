# Evilwinrm

## evil-winrm

### password

Read password with Evilwinrm.

```sh title:"Evilwinrm Read Password"
evil-winrm -i $rhost_ip -u $user -p $pass
```
<!-- cheat
import users
import passwords
var rhost_ip
-->

### ntlm hash

Dump NTLM hash with Evilwinrm.

```sh title:"Evilwinrm Dump NTLM Hash"
evil-winrm -i $rhost_ip -u $user -H $hash
```
<!-- cheat
import users
import passwords
var rhost_ip
var hash
-->

### kerberos

Read kerberos with Evilwinrm.

```sh title:"Evilwinrm Read Kerberos"
evil-winrm -i $rhost_ip -u $user -r $realm
```
<!-- cheat
import users
import passwords
var rhost_ip
var realm
-->

