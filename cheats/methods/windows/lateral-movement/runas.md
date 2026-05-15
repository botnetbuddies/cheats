---
technique: Runas and RunasCs
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows runas runascs credentials logon-types
---

# Runas and RunasCs

`runas` and RunasCs start processes under alternate credentials from a local Windows shell. RunasCs provides more control over logon type and credential handling than native `runas`.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Credentials | A valid username and password are required |
| Local execution | Commands start from the current host |
| Logon rights | The account must be allowed to use the selected logon type |

## Windows

### Native runas

#cmd #runas

Start a process under another user's credentials with native `runas`.

```cmd title:"Run command as another user with runas"
runas /env /noprofile /user:$user "$command"
```
<!-- cheat
var user
var command
-->

### Native runas with saved credentials

#cmd #runas #savecred

Use saved Credential Manager credentials with native `runas`.

```cmd title:"Run command with saved runas credentials"
runas /savecred /user:$user "$command"
```
<!-- cheat
var user
var command
-->

### RunasCs basic command

#powershell #runascs

Run a command as another local or domain user with RunasCs.

```powershell title:"Run command as another user with RunasCs"
.\RunasCs.exe $user $pass "$command"
```
<!-- cheat
var user
var pass
var command
-->

### RunasCs domain command

#powershell #runascs

Run a command as a domain user with RunasCs.

```powershell title:"Run command as domain user with RunasCs"
.\RunasCs.exe $user $pass "$command" -d $domain
```
<!-- cheat
var user
var pass
var command
var domain
-->

### RunasCs interactive logon

#powershell #runascs

Use RunasCs logon type 2 for an interactive logon token.

```powershell title:"Run command with RunasCs interactive logon"
.\RunasCs.exe $user $pass "$command" -l 2
```
<!-- cheat
var user
var pass
var command
-->

### RunasCs NewCredentials logon

#powershell #runascs

Use RunasCs logon type 9 for NewCredentials network-only behavior.

```powershell title:"Run command with RunasCs NewCredentials logon"
.\RunasCs.exe $user $pass "$command" -l 9
```
<!-- cheat
var user
var pass
var command
-->

## Linux

No Linux operator command is included here. This note covers local Windows alternate-credential process creation.
