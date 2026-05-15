---
technique: Windows Run Keys
category: persistence
targets: Windows Registry
protocols: Local
remote_capable: false
tags: windows persistence registry run-key runonce startup
---

# Windows Run Keys

Run and RunOnce registry keys start commands during user logon. HKCU keys persist for the current user. HKLM keys affect all users and require administrative rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Registry write | HKCU needs current-user write access. HKLM usually requires admin |
| Logon trigger | Payload runs when the target user logs on |
| Command path | The configured command must remain available at logon |

## Windows

### Query HKCU Run

#cmd #registry

List current-user Run key values.

```cmd title:"Query HKCU Run key"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
```
<!-- cheat -->

### Add HKCU Run value

#cmd #registry

Add a current-user Run key value.

```cmd title:"Add HKCU Run persistence value"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "$value_name" /t REG_SZ /d "$command" /f
```
<!-- cheat
var value_name
var command
-->

### Delete HKCU Run value

#cmd #registry #cleanup

Delete a current-user Run key value.

```cmd title:"Delete HKCU Run persistence value"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "$value_name" /f
```
<!-- cheat
var value_name
-->

### Query HKLM Run

#cmd #registry

List machine-wide Run key values.

```cmd title:"Query HKLM Run key"
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
```
<!-- cheat -->

### Add HKLM Run value

#cmd #registry

Add a machine-wide Run key value.

```cmd title:"Add HKLM Run persistence value"
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "$value_name" /t REG_SZ /d "$command" /f
```
<!-- cheat
var value_name
var command
-->

### RunOnce alternate startup

#cmd #lolbin

Trigger RunOnce alternate shell startup processing.

```cmd title:"Trigger RunOnce alternate shell startup"
Runonce.exe /AlternateShellStartup
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows registry persistence commands.
