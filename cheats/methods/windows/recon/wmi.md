---
technique: WMI Enumeration
category: recon
targets: Windows Workstation, Windows Server
protocols: WMI, DCOM
remote_capable: false
tags: windows wmi recon patch-level processes users groups
---

# WMI Enumeration

WMI exposes operating system, patch, process, account, and domain metadata. It is useful when PowerShell is constrained or when command output must stay within native Windows tooling.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run from CMD or a compatible shell |
| WMI service | The Windows Management Instrumentation service must be available |

## Windows

### Hotfixes

#cmd #patches

List installed hotfixes and install dates.

```cmd title:"List installed hotfixes with WMIC"
wmic qfe get Caption,Description,HotFixID,InstalledOn
```
<!-- cheat -->

### Computer system

#cmd #host-info

List hostname, domain, model, current user, and role information.

```cmd title:"List computer system details with WMIC"
wmic computersystem get Name,Domain,Manufacturer,Model,Username,Roles /format:List
```
<!-- cheat -->

### Processes

#cmd #processes

List running processes.

```cmd title:"List processes with WMIC"
wmic process list /format:list
```
<!-- cheat -->

### Domain information

#cmd #domain

Display domain and domain controller information from the host perspective.

```cmd title:"List domain information with WMIC"
wmic ntdomain list /format:list
```
<!-- cheat -->

### User accounts

#cmd #users

List local and cached domain user accounts known to the host.

```cmd title:"List user accounts with WMIC"
wmic useraccount list /format:list
```
<!-- cheat -->

### Local groups

#cmd #groups

List local groups.

```cmd title:"List local groups with WMIC"
wmic group list /format:list
```
<!-- cheat -->

### System accounts

#cmd #accounts

List system and service accounts.

```cmd title:"List system accounts with WMIC"
wmic sysaccount list /format:list
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers local Windows WMI commands.
