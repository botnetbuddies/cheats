---
technique: WinRM
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: WinRM, HTTP, HTTPS
remote_capable: true
tags: windows winrm powershell-remoting lateral-movement
---

# WinRM

WinRM provides PowerShell remoting for command execution, script execution, and interactive sessions. It is commonly available on servers and sometimes disabled on workstations unless explicitly configured.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | TCP 5985 or 5986 must be reachable |
| Credentials | The user needs remote logon rights and PowerShell remoting access |
| Trusted hosts | Workgroup or cross-domain clients may need TrustedHosts configuration |

## Windows

### Enable PowerShell remoting locally

#powershell #winrm

Enable PowerShell remoting on the local host.

```powershell title:"Enable PowerShell remoting locally"
Enable-PSRemoting -Force
```
<!-- cheat -->

### Trust all WinRM hosts

#powershell #winrm

Allow the local WinRM client to connect to any host.

```powershell title:"Trust all WinRM hosts"
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
```
<!-- cheat -->

### Enable remoting over WMIC

#cmd #wmic #winrm

Enable PowerShell remoting remotely through WMIC.

```cmd title:"Enable PowerShell remoting over WMIC"
wmic /node:"$rhost_name" process call create "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command Enable-PSRemoting -Force"
```
<!-- cheat
var rhost_name
-->

### Test WinRM

#powershell #winrm

Test whether a host responds to WinRM.

```powershell title:"Test WinRM with Test-WSMan"
Test-WSMan -ComputerName "$rhost_name"
```
<!-- cheat
var rhost_name
-->

### Invoke remote command

#powershell #winrm

Execute a PowerShell command on a remote host.

```powershell title:"Run command over WinRM"
Invoke-Command -ComputerName "$rhost_name" -ScriptBlock { $command } -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var command
var domain
var user
-->

### Invoke remote script

#powershell #winrm

Execute a local PowerShell script file on a remote host.

```powershell title:"Run script over WinRM"
Invoke-Command -ComputerName "$rhost_name" -FilePath "$script_path" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var script_path
var domain
var user
-->

### Enter remote session

#powershell #winrm

Open an interactive PowerShell remoting session.

```powershell title:"Open interactive WinRM session"
Enter-PSSession -ComputerName "$rhost_name" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var domain
var user
-->

## Linux

No Linux operator command is included here. This note covers Windows-native WinRM commands.
