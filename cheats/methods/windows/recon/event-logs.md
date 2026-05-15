---
technique: Windows Event Log Recon
category: recon
targets: Windows Event Logs
protocols: Local
remote_capable: false
tags: windows recon event-logs powershell security
---

# Windows Event Log Recon

Event log recon identifies log availability, PowerShell logging, authentication events, and operational telemetry before choosing noisier actions.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run locally from CMD or PowerShell |
| Log rights | Security log access may require elevated rights |

## Windows

### List logs

#cmd #event-logs

List event logs visible to the current context.

```cmd title:"List Windows event logs"
wevtutil el
```
<!-- cheat -->

### Security log status

#cmd #event-logs

Show Security log configuration.

```cmd title:"Show Security log configuration"
wevtutil gl Security
```
<!-- cheat -->

### Recent logons

#powershell #event-logs #logon

Read recent successful logon events.

```powershell title:"Read recent successful logons"
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624} -MaxEvents 20
```
<!-- cheat -->

### Recent failed logons

#powershell #event-logs #logon

Read recent failed logon events.

```powershell title:"Read recent failed logons"
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 20
```
<!-- cheat -->

### PowerShell operational log

#powershell #powershell #event-logs

Read recent PowerShell operational events.

```powershell title:"Read PowerShell operational events"
Get-WinEvent -LogName Microsoft-Windows-PowerShell/Operational -MaxEvents 20
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows event log recon.
