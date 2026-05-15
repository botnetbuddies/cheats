---
technique: PowerShell History Hunting
category: credentials
targets: Windows PowerShell
protocols: Local
remote_capable: false
tags: windows credentials powershell history psreadline
---

# PowerShell History Hunting

PowerShell history hunting searches PSReadLine and transcript artifacts for typed passwords, tokens, commands, and paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile access | PSReadLine history is stored per user |
| PowerShell history enabled | History may be absent on older hosts or locked-down shells |

## Windows

### PSReadLine history path

#powershell #powershell #history

Print the active PSReadLine history path.

```powershell title:"Print PSReadLine history path"
(Get-PSReadLineOption).HistorySavePath
```
<!-- cheat -->

### Read PSReadLine history

#powershell #powershell #history

Read current user PowerShell history.

```powershell title:"Read PSReadLine history"
Get-Content (Get-PSReadLineOption).HistorySavePath
```
<!-- cheat -->

### Search history for secrets

#powershell #powershell #credentials

Search PowerShell history for credential strings.

```powershell title:"Search PowerShell history for secrets"
Select-String -Path (Get-PSReadLineOption).HistorySavePath -Pattern "pass","password","token","secret","key"
```
<!-- cheat -->

### Default history file

#cmd #powershell #history

Read the default Windows PowerShell history file.

```cmd title:"Read default PowerShell history file"
type "%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
```
<!-- cheat -->

### Transcript policy

#cmd #powershell #transcript

Check machine-wide PowerShell transcription policy.

```cmd title:"Check PowerShell transcription policy"
reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\Transcription
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows PowerShell history artifacts.
