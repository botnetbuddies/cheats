---
technique: BloodHound Collection
category: recon
targets: Active Directory
protocols: LDAP, SMB, RPC
remote_capable: true
tags: bloodhound sharphound bloodhound-python rusthound graph recon ad
---

# BloodHound Collection

BloodHound collectors gather AD users, groups, computers, sessions, ACLs, trusts, GPOs, and certificate services into JSON for graph analysis. Use SharpHound from Windows when possible; use BloodHound.py or BloodHound CE Python when collecting from Linux.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain user | Most collection paths require valid domain credentials |
| DNS resolution | Collectors need reliable domain and DC name resolution |
| Upload path | The resulting ZIP or JSON files must be imported into BloodHound |

## Windows

### SharpHound full collection

#sharphound #collection

Collect all standard BloodHound data from a Windows domain context.

```cmd title:"Collect BloodHound data with SharpHound"
.\SharpHound.exe --collectionmethods All
```
<!-- cheat -->

### SharpHound stealth collection

#sharphound #stealth

Collect using SharpHound's stealth mode when session enumeration noise matters.

```cmd title:"Collect BloodHound data with SharpHound stealth mode"
.\SharpHound.exe --collectionmethods All --Stealth
```
<!-- cheat -->

### SharpHound session loop

#sharphound #sessions

Loop session collection to catch transient privileged logons.

```cmd title:"Loop SharpHound session collection"
.\SharpHound.exe --collectionmethods Session --Loop --loopduration 03:00:00 --loopinterval 00:10:00
```
<!-- cheat -->

### SharpHound LDAPS

#sharphound #ldaps

Force SharpHound to use LDAPS.

```cmd title:"Collect BloodHound data over LDAPS"
.\SharpHound.exe --secureldap
```
<!-- cheat -->

## Linux

### BloodHound.py full collection

#bloodhound-python #collection

Collect legacy BloodHound-compatible data from Linux with BloodHound.py.

```sh title:"Collect BloodHound data with BloodHound.py"
bloodhound.py --zip -c All -d "$domain" -u "$user" -p "$pass" -dc "$dc_host" -ns "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_host
var dc_ip
-->

### BloodHound CE Python full collection

#bloodhound-ce-python #collection

Collect BloodHound Community Edition-compatible data from Linux.

```sh title:"Collect BloodHound CE data with bloodhound-ce-python"
bloodhound-ce-python -d "$domain" -u "$user" -p "$pass" -c all -ns "$rhost_ip" --zip
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### RustHound CE full collection

#rusthound #collection

Collect BloodHound CE data with RustHound on large domains.

```sh title:"Collect BloodHound CE data with RustHound"
rusthound-ce -d "$domain" -u "$user" -p "$pass" -z
```
<!-- cheat
import domain_ip
import users
import passwords
-->
