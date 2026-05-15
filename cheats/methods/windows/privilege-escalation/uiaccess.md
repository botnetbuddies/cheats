---
technique: UIAccess Abuse
category: privilege-escalation
targets: Windows Desktop
protocols: Local
remote_capable: false
tags: windows privilege-escalation uiaccess uipi desktop
---

# UIAccess Abuse

UIAccess abuse targets trusted UIAccess applications that can interact with higher-integrity desktop windows.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Interactive desktop | UIAccess requires an interactive user session |
| Trusted location | UIAccess binaries must run from trusted paths |
| Signed binary | Windows requires UIAccess binaries to be signed |

## Windows

### Query UIAccess policy

#cmd #registry #uiaccess

Check whether UIAccess apps require secure locations.

```cmd title:"Query UIAccess secure location policy"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableSecureUIAPaths
```
<!-- cheat -->

### Trusted accessibility path

#cmd #filesystem #uiaccess

List common trusted accessibility program paths.

```cmd title:"List accessibility program path"
dir "C:\Program Files\Windows NT\Accessories"
```
<!-- cheat -->

### Process integrity levels

#powershell #uipi #processes

List process integrity labels through access tokens.

```powershell title:"List process integrity with whoami"
whoami /groups
```
<!-- cheat -->

### Run UIAccess helper

#cmd #uiaccess

Run a prepared UIAccess helper.

```cmd title:"Run UIAccess helper"
"$helper_path" "$command"
```
<!-- cheat
var helper_path
var command
-->

## Linux

No Linux operator command is included here. This note covers Windows UIAccess abuse.
