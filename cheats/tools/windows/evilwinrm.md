# Evilwinrm

## evil-winrm

### password

Read password with Evilwinrm.

WinRM shell on the target with cleartext password auth. Default port 5985 (HTTP), use `-S` for 5986 (HTTPS).

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

WinRM shell using pass-the-hash with the user's NT hash. Drop the `:` prefix; evil-winrm wants the bare 32 hex chars.

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

WinRM shell using a Kerberos ticket. Requires a valid ccache (`KRB5CCNAME`) and `/etc/krb5.conf` pointed at the realm KDC.

```sh title:"Evilwinrm Read Kerberos"
evil-winrm -i $rhost_ip -u $user -r $realm
```
<!-- cheat
import users
import passwords
var rhost_ip
var realm
-->

