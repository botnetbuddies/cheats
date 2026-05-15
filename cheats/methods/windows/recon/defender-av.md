---
technique: Windows Defender and AV Recon
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon defender av tamper-protection exclusions
---

# Windows Defender and AV Recon

Defender and AV recon identifies real-time protection, exclusions, signatures, tamper protection, and third-party security tooling before staging payloads.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run locally from CMD or PowerShell |
| PowerShell access | Defender cmdlets require PowerShell and Defender components |

## Windows

### Defender status

#powershell #defender

Print Defender protection status.

```powershell title:"Print Defender status"
Get-MpComputerStatus
```
<!-- cheat -->

### Defender preferences

#powershell #defender

Print Defender preferences and exclusions.

```powershell title:"Print Defender preferences"
Get-MpPreference
```
<!-- cheat -->

### Defender exclusions

#powershell #defender #exclusions

List Defender exclusion paths, processes, and extensions.

```powershell title:"List Defender exclusions"
Get-MpPreference | Select-Object ExclusionPath,ExclusionProcess,ExclusionExtension
```
<!-- cheat -->

### Security products

#powershell #av

List registered endpoint security products from Security Center.

```powershell title:"List registered security products"
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct
```
<!-- cheat -->

### Defender service

#cmd #services #defender

Query the Defender service state.

```cmd title:"Query Defender service"
sc query WinDefend
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows security product recon.
