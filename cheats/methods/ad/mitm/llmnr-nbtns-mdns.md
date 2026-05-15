---
technique: LLMNR/NBT-NS/mDNS Spoofing
category: mitm
targets: Network Broadcast/Multicast
protocols: LLMNR, NBT-NS, mDNS
remote_capable: false
tags: mitm poisoning llmnr nbtns mdns ntlm-capture responder inveigh
---

# LLMNR / NBT-NS / mDNS Spoofing

When standard DNS resolution fails, Windows falls back to LLMNR (Link-Local Multicast Name Resolution), NBT-NS (NetBIOS Name Service), and mDNS (multicast DNS). Attackers on the same network segment can answer these broadcast/multicast queries, redirecting victims to a rogue server and capturing or relaying their NTLM authentication.

## Windows

Inveigh is a PowerShell-native tool that handles poisoning and capture in a single process.

### Inveigh

#powershell #capture #poison

Poison LLMNR, NBT-NS, and mDNS and capture NTLM hashes from all responding machines including machine accounts.

```powershell title:"Poison LLMNR/NBT-NS/mDNS and capture NTLM hashes with Inveigh"
Invoke-Inveigh -ConsoleOutput Y -LLMNR Y -NBNS Y -mDNS Y -Challenge 1122334455667788 -MachineAccounts Y
```
<!-- cheat -->

## Linux

Responder handles the full poisoning and capture workflow from a single interface flag.

### responder (analyze)

#python #passive #recon

Run Responder in analyze mode to observe LLMNR/NBT-NS/mDNS traffic without actively responding.

```sh title:"Analyze multicast name resolution traffic with Responder"
responder --interface "$iface" --analyze
```
<!-- cheat
var iface
-->

### responder (poison)

#python #active #capture

Actively answer LLMNR/NBT-NS/mDNS queries and serve fake auth servers to capture NTLM hashes.

```sh title:"Poison multicast name resolution and capture NTLM hashes with Responder"
responder --interface "$iface"
```
<!-- cheat
var iface
-->
