# RDP

## windows config

### Enable RDP

Enable Remote Desktop connections through the registry.

```cmd title:"RDP Enable Remote Desktop connections"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
```
<!-- cheat -->

### Allow firewall

Add a Windows Firewall rule for inbound RDP.

```cmd title:"Allow inbound RDP through Windows Firewall"
netsh.exe advfirewall firewall add rule name="Remote Desktop - User Mode (TCP-In)" dir=in action=allow program="%SystemRoot%\system32\svchost.exe" service="TermService" enable=yes profile=private,domain localport=3389 protocol=tcp
```
<!-- cheat -->

### Enable restricted admin

Enable Restricted Admin mode for pass-the-hash RDP.

```powershell title:"Enable RDP Restricted Admin mode"
New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name DisableRestrictedAdmin -Value 0 -PropertyType DWord -Force
```
<!-- cheat -->

### Disable restricted admin

Disable Restricted Admin mode.

```powershell title:"Disable RDP Restricted Admin mode"
Remove-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name DisableRestrictedAdmin
```
<!-- cheat -->

## command exec

### SharpRDP

Execute a command over RDP with SharpRDP.

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
