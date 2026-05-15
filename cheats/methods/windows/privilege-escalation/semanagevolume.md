---
technique: SeManageVolumePrivilege Abuse
category: privilege-escalation
targets: Windows Privileges
protocols: Local
remote_capable: false
tags: windows privilege-escalation semanagevolume volume-maintenance
---

# SeManageVolumePrivilege Abuse

SeManageVolumePrivilege can permit privileged volume maintenance operations that become file write or DLL planting primitives.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SeManageVolumePrivilege | Current token must include the privilege |
| Compatible target | Abuse depends on writable volume metadata or helper tooling |
| Prepared payload | Payload construction belongs in a tool or payload note |

## Windows

### Check privileges

#cmd #token

List current token privileges.

```cmd title:"List token privileges"
whoami /priv
```
<!-- cheat -->

### Check volume info

#cmd #volume

Print filesystem and volume information.

```cmd title:"Print volume information"
fsutil fsinfo volumeinfo C:
```
<!-- cheat -->

### Run SeManageVolume tool

#cmd #semanagevolume

Run a prepared SeManageVolume abuse helper.

```cmd title:"Run SeManageVolume helper"
"$tool_path" "$payload_file"
```
<!-- cheat
var tool_path
var payload_file
-->

## Linux

No Linux operator command is included here. This note covers SeManageVolumePrivilege abuse.
