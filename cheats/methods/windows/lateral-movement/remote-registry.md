---
technique: Remote Registry
category: lateral-movement
targets: Windows Hosts
protocols: SMB, RPC, Remote Registry
remote_capable: true
tags: windows lateral-movement registry remote-registry
---

# Remote Registry

Remote Registry enables registry reads and writes on remote hosts when the service is running and the operator has sufficient rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative rights | Remote registry writes typically require admin rights |
| Service running | RemoteRegistry service must be running or startable |
| RPC and SMB access | Remote registry uses Windows remote management protocols |

## Windows

### Query service

#cmd #remote-registry #services

Query the Remote Registry service on a host.

```cmd title:"Query Remote Registry service"
sc "\\$rhost_name" query RemoteRegistry
```
<!-- cheat
var rhost_name
-->

### Start service

#cmd #remote-registry #services

Start the Remote Registry service on a host.

```cmd title:"Start Remote Registry service"
sc "\\$rhost_name" start RemoteRegistry
```
<!-- cheat
var rhost_name
-->

### Query remote key

#cmd #remote-registry

Query a registry key on a remote host.

```cmd title:"Query remote registry key"
reg query "\\$rhost_name\$registry_key"
```
<!-- cheat
var rhost_name
var registry_key
-->

### Add remote value

#cmd #remote-registry

Add a registry value on a remote host.

```cmd title:"Add remote registry value"
reg add "\\$rhost_name\$registry_key" /v "$value_name" /t REG_SZ /d "$value_data" /f
```
<!-- cheat
var rhost_name
var registry_key
var value_name
var value_data
-->

## Linux

No Linux operator command is included here. This note covers Windows Remote Registry.
