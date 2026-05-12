# WinRM

## enable

### Enable locally

Enable PowerShell remoting on the local host.

```powershell title:"Enable PowerShell remoting locally"
Enable-PSRemoting -Force
```
<!-- cheat -->

### Trust all hosts

Allow the local WinRM client to connect to any host.

```powershell title:"Trust all WinRM hosts"
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
```
<!-- cheat -->

### Enable over WMIC

Enable PowerShell remoting remotely through WMIC.

```cmd title:"Enable PowerShell remoting over WMIC"
wmic /node:"$rhost_name" process call create "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command Enable-PSRemoting -Force"
```
<!-- cheat
var rhost_name
-->

### Enable over PsExec

Enable PowerShell remoting remotely through PsExec.

```cmd title:"Enable PowerShell remoting over PsExec"
PsExec.exe "\\$rhost_name" -u "$domain\$user" -p "$pass" -h -d powershell.exe "Enable-PSRemoting -Force"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
-->

## powershell

### Test WSMan

Test whether a host responds to WinRM.

```powershell title:"Test WinRM with Test-WSMan"
Test-WSMan -ComputerName "$rhost_name"
```
<!-- cheat
var rhost_name
-->

### Invoke command

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

### Invoke script

Execute a local script file on a remote host.

```powershell title:"Run script over WinRM"
Invoke-Command -ComputerName "$rhost_name" -FilePath "$script_path" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var script_path
var domain
var user
-->

### Enter session

Open an interactive PowerShell remoting session.

```powershell title:"Open interactive WinRM session"
Enter-PSSession -ComputerName "$rhost_name" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var domain
var user
-->
