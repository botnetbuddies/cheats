---
technique: SCCMEnumeration
category: sccm-mecm
targets: SCCM Management Point, SMS Provider
protocols: WMI, SMB, HTTP
remote_capable: true
tags: sccm mecm enumeration sharpsccm sms-provider ad
---

# SCCMEnumeration

SCCM enumeration identifies administrators, special accounts, management points, distribution points, and client configuration. Administrative privileges over the SMS Provider expose high-value classes such as `SMS_ADMIN` and `SMS_SCI_Reserved`.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SCCM access | Some WMI classes require SCCM administrative rights |
| SMS Provider | Query the provider or management point hosting the SCCM WMI namespace |
| Domain context | Domain credentials help enumerate SCCM hosts and shares |

## Windows

### SharpSCCM admin users

#powershell #sharpsccm #wmi

Enumerate SCCM administrative users through the SMS Provider.

```powershell title:"Enumerate SCCM administrators with SharpSCCM"
.\SharpSCCM.exe get class-instances SMS_ADMIN
```
<!-- cheat -->

### SharpSCCM special accounts

#powershell #sharpsccm #wmi

Enumerate SCCM reserved and special accounts through the SMS Provider.

```powershell title:"Enumerate SCCM special accounts with SharpSCCM"
.\SharpSCCM.exe get class-instances SMS_SCI_Reserved
```
<!-- cheat -->

## Linux

### cmloot find SCCM servers

#python #sccm #smb

Enumerate SCCM servers and build a host inventory for content library looting.

```sh title:"Find SCCM servers with cmloot"
python3 cmloot.py "$domain/$user@$target" -findsccmservers -target-file sccmhosts.txt
```
<!-- cheat
import domain_ip
import users
var target
-->
