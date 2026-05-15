---
technique: Named Pipe Impersonation
category: privilege-escalation
targets: Windows Named Pipes
protocols: SMB, RPC, Named Pipe
remote_capable: false
tags: windows privilege-escalation named-pipe seimpersonate potato
---

# Named Pipe Impersonation

Named pipe impersonation abuses privileged clients connecting to an operator-controlled pipe when the current token has impersonation rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SeImpersonatePrivilege | Current token must usually hold impersonation rights |
| Coercible privileged client | A privileged service must connect to the pipe |
| Suitable exploit tool | Potato-style tooling belongs in tool notes |

## Windows

### Check impersonation privilege

#cmd #token

Check whether the current token has SeImpersonatePrivilege.

```cmd title:"Check SeImpersonatePrivilege"
whoami /priv
```
<!-- cheat -->

### List named pipes

#powershell #named-pipe

List named pipe filesystem entries.

```powershell title:"List named pipes"
Get-ChildItem \\.\pipe\
```
<!-- cheat -->

### Print current identity

#cmd #token

Print the current user after impersonation or token theft.

```cmd title:"Print current identity"
whoami /all
```
<!-- cheat -->

### Run prepared potato tool

#cmd #potato #named-pipe

Run a prepared named-pipe impersonation tool with a command.

```cmd title:"Run named-pipe impersonation tool"
"$tool_path" "$command"
```
<!-- cheat
var tool_path
var command
-->

## Linux

No Linux operator command is included here. This note covers Windows named pipe impersonation.
