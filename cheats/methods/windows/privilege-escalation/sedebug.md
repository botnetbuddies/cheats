---
technique: SeDebugPrivilege Abuse
category: privilege-escalation
targets: Windows Privileges
protocols: Local
remote_capable: false
tags: windows privilege-escalation sedebug token process
---

# SeDebugPrivilege Abuse

SeDebugPrivilege grants access to inspect or manipulate protected processes when enabled in the current token.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SeDebugPrivilege | Current token must include SeDebugPrivilege |
| High-integrity context | Enabling the privilege usually requires elevation |
| Target process | Impact depends on a privileged process to inspect or dump |

## Windows

### Check privileges

#cmd #token

List current token privileges.

```cmd title:"List current token privileges"
whoami /priv
```
<!-- cheat -->

### List SYSTEM processes

#powershell #processes #token

List processes running as SYSTEM.

```powershell title:"List SYSTEM processes"
Get-CimInstance Win32_Process | Where-Object {$_.GetOwner().User -eq 'SYSTEM'} | Select-Object ProcessId,Name,CommandLine
```
<!-- cheat -->

### Dump target process

#cmd #procdump #sedebug

Dump a target process after enabling debug rights.

```cmd title:"Dump process with ProcDump"
procdump.exe -accepteula -ma "$pid" "$dump_file"
```
<!-- cheat
var pid
var dump_file
-->

### Open SYSTEM shell with tool

#cmd #sedebug #token

Run a prepared token or debug privilege tool with a command.

```cmd title:"Run SeDebug abuse tool"
"$tool_path" "$command"
```
<!-- cheat
var tool_path
var command
-->

## Linux

No Linux operator command is included here. This note covers SeDebugPrivilege abuse.
