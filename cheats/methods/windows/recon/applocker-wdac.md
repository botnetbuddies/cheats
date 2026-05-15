---
technique: AppLocker and WDAC Recon
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon applocker wdac application-control
---

# AppLocker and WDAC Recon

Application control recon identifies AppLocker, WDAC, and Code Integrity policy that can block payload execution or constrain script interpreters.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | Commands run on the target host |
| Policy visibility | Some policy details require admin or local policy access |

## Windows

### AppLocker effective policy

#powershell #applocker

Print effective AppLocker policy as XML.

```powershell title:"Print effective AppLocker policy"
Get-AppLockerPolicy -Effective -Xml
```
<!-- cheat -->

### AppLocker service

#cmd #applocker #services

Query the Application Identity service.

```cmd title:"Query AppLocker service"
sc query AppIDSvc
```
<!-- cheat -->

### Code Integrity policy directory

#cmd #wdac

List Code Integrity policy files.

```cmd title:"List Code Integrity policy files"
dir C:\Windows\System32\CodeIntegrity
```
<!-- cheat -->

### Code Integrity event log

#powershell #wdac #logs

Read recent Code Integrity operational events.

```powershell title:"Read Code Integrity events"
Get-WinEvent -LogName Microsoft-Windows-CodeIntegrity/Operational -MaxEvents 20
```
<!-- cheat -->

### AppLocker logs

#powershell #applocker #logs

Read recent AppLocker EXE and DLL events.

```powershell title:"Read AppLocker EXE DLL events"
Get-WinEvent -LogName Microsoft-Windows-AppLocker/EXE and DLL -MaxEvents 20
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows application control recon.
