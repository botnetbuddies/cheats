---
technique: SCCMAdminServiceAPI
category: sccm-mecm
targets: SCCM AdminService, SCCM Clients
protocols: HTTPS, WMI
remote_capable: true
tags: sccm mecm adminservice cmpivot sharpsccm sccmhunter ad
---

# SCCMAdminServiceAPI

The SCCM AdminService API exposes CMPivot-backed administrative actions to SCCM administrators. Use it to enumerate devices and run post-exploitation queries when SCCM rights are available and the AdminService endpoint accepts the chosen authentication path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SCCM admin rights | AdminService actions require SCCM privileges |
| Resource ID | SharpSCCM AdminService calls target a device or collection resource ID |
| Endpoint access | AdminService is commonly exposed over HTTPS on the site server |

## Windows

### SharpSCCM resource ID

#powershell #sharpsccm #adminservice

Retrieve the SCCM resource ID for a target computer.

```powershell title:"Get SCCM resource ID with SharpSCCM"
.\SharpSCCM.exe get resource-id -d "$computer_name"
```
<!-- cheat
var computer_name
-->

### SharpSCCM local administrators

#powershell #sharpsccm #adminservice

Use CMPivot through AdminService to enumerate local administrators on a target resource.

```powershell title:"Enumerate local administrators through SCCM AdminService"
.\SharpSCCM.exe invoke admin-service -r $resource_id -q "Administrators" -j
```
<!-- cheat
var resource_id
-->

### SharpSCCM installed software

#powershell #sharpsccm #adminservice

Use CMPivot through AdminService to enumerate installed software on a target resource.

```powershell title:"Enumerate installed software through SCCM AdminService"
.\SharpSCCM.exe invoke admin-service -r $resource_id -q "InstalledSoftware" -j
```
<!-- cheat
var resource_id
-->

## Linux

### sccmhunter AdminService

#python #sccmhunter #adminservice

Open an SCCM AdminService shell with sccmhunter.

```sh title:"Open SCCM AdminService shell with sccmhunter"
python3 sccmhunter.py admin -u "$user" -p "$pass" -ip "$site_server_ip"
```
<!-- cheat
import users
import passwords
var site_server_ip
-->
