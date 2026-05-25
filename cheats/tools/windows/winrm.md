# WinRM

## enable

### Enable locally

Enable locally with WinRM.

Enable PowerShell remoting on the local host.

```powershell title:"WinRM Enable Locally"
Enable-PSRemoting -Force
```
<!-- cheat -->

### Trust all hosts

Enable trust all hosts with WinRM.

Allow the local WinRM client to connect to any host.

```powershell title:"WinRM Enable Trust All Hosts"
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
```
<!-- cheat -->

### Enable over WMIC

Enable over WMIC with WinRM.

Enable PowerShell remoting remotely through WMIC.

```cmd title:"WinRM Enable Over WMIC"
wmic /node:"$rhost_name" process call create "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command Enable-PSRemoting -Force"
```
<!-- cheat
var rhost_name
-->

### Enable over PsExec

Enable over PsExec with WinRM.

Enable PowerShell remoting remotely through PsExec.

```cmd title:"WinRM Enable Over PsExec"
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

Spawn test WSMan with WinRM.

Test whether a host responds to WinRM.

```powershell title:"WinRM Spawn Test WSMan"
Test-WSMan -ComputerName "$rhost_name"
```
<!-- cheat
var rhost_name
-->

### Invoke command

Spawn invoke command with WinRM.

Execute a PowerShell command on a remote host.

```powershell title:"WinRM Spawn Invoke Command"
Invoke-Command -ComputerName "$rhost_name" -ScriptBlock { $command } -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var command
var domain
var user
-->

### Invoke script

Spawn invoke script with WinRM.

Execute a local script file on a remote host.

```powershell title:"WinRM Spawn Invoke Script"
Invoke-Command -ComputerName "$rhost_name" -FilePath "$script_path" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var script_path
var domain
var user
-->

### Enter session

Spawn enter session with WinRM.

Open an interactive PowerShell remoting session.

```powershell title:"WinRM Spawn Enter Session"
Enter-PSSession -ComputerName "$rhost_name" -Credential "$domain\$user"
```
<!-- cheat
var rhost_name
var domain
var user
-->
