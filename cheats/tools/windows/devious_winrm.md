# Devious-WinRM

## devious-winrm - winrm - remote

### password

Read password with Devious-WinRM.

```sh title:"Devious WinRM Read Password"
devious-winrm -u $user -p $pass $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_name
-->

### ntlm or lm:ntlm hash

Dump NTLM or lm:ntlm hash with Devious-WinRM.

```sh title:"Devious WinRM Dump NTLM or Lm:ntlm Hash"
devious-winrm -u $user -H $hash $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
var hash
var rhost_name
-->

### kerberos

Read kerberos with Devious-WinRM.

```sh title:"Devious WinRM Read Kerberos"
devious-winrm -u $user -k --dc $rhost_name $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_name
-->
