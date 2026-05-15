---
technique: Windows Local Enumeration
category: recon
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows recon local-enumeration users services processes registry
---

# Windows Local Enumeration

Local Windows enumeration establishes host role, patch level, user context, logged-on sessions, running processes, services, network state, and credential storage policy. Run these commands before choosing a privilege escalation or credential access path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Commands run from a local CMD or PowerShell context |
| User context | Low-privileged users can run most recon commands |
| Output path | Capture output when operating through unstable shells |

## Windows

### System information

#cmd #system

Print OS version, hotfixes, domain role, and hardware details.

```cmd title:"Print Windows system information"
systeminfo
```
<!-- cheat -->

### Hostname

#cmd #system

Print the local hostname.

```cmd title:"Print hostname"
hostname
```
<!-- cheat -->

### Current privileges

#cmd #token

List the current user's token privileges.

```cmd title:"Print current token privileges"
whoami /priv
```
<!-- cheat -->

### Local users

#powershell #users

List local users with enabled state and last logon time.

```powershell title:"List local users with last logon"
Get-LocalUser | ft Name,Enabled,LastLogon
```
<!-- cheat -->

### Administrators group members

#powershell #groups

List members of the local Administrators group.

```powershell title:"List local Administrators group members"
Get-LocalGroupMember Administrators | ft Name, PrincipalSource
```
<!-- cheat -->

### Interactive sessions

#cmd #sessions

List interactive logon sessions.

```cmd title:"List interactive sessions with qwinsta"
qwinsta
```
<!-- cheat -->

### Process list

#cmd #processes

List running processes with verbose metadata.

```cmd title:"List running processes verbosely"
tasklist /V
```
<!-- cheat -->

### Processes with services

#cmd #services

Map processes to hosted services.

```cmd title:"List processes with associated services"
tasklist /SVC
```
<!-- cheat -->

### Services

#cmd #services

List Windows services.

```cmd title:"List Windows services with sc"
sc query
```
<!-- cheat -->

### Scheduled tasks

#cmd #scheduled-tasks

List scheduled tasks with verbose task details.

```cmd title:"List scheduled tasks verbosely"
schtasks /query /fo LIST /v
```
<!-- cheat -->

### Network interfaces

#powershell #network

List local interface IP configuration.

```powershell title:"List interface IP configuration"
Get-NetIPConfiguration
```
<!-- cheat -->

### ARP cache

#cmd #network

Print the ARP cache.

```cmd title:"Print ARP cache"
arp -a
```
<!-- cheat -->

### Hosts file

#cmd #network

Read the Windows hosts file.

```cmd title:"Read Windows hosts file"
type C:\Windows\System32\drivers\etc\hosts
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers local commands from a Windows shell.
