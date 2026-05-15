---
technique: polkit and pkexec
category: privilege-escalation
targets: Linux polkit
protocols: Local, D-Bus
remote_capable: false
tags: linux privilege-escalation polkit pkexec dbus
---

# polkit and pkexec

polkit controls privileged desktop and service actions through D-Bus policy, and weak action rules can expose local privilege escalation paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| polkit present | Target must run polkit or expose pkexec |
| Allowed action | Current identity must satisfy a useful action policy |
| Local session | Many policies depend on active or local session state |

## Linux

### List polkit actions

#sh #polkit #recon

List registered polkit actions.

```sh title:"List polkit actions"
pkaction
```
<!-- cheat -->

### Describe action

#sh #polkit #recon

Print details for a specific polkit action.

```sh title:"Describe polkit action"
pkaction --action-id "$action_id" --verbose
```
<!-- cheat
var action_id
-->

### List temporary authorizations

#sh #polkit #recon

List temporary polkit authorizations for the current session.

```sh title:"List temporary polkit authorizations"
pkcheck --list-temp
```
<!-- cheat -->

### Check action authorization

#sh #polkit #recon

Check whether the current process is authorized for an action.

```sh title:"Check polkit action authorization"
pkcheck --action-id "$action_id" --process "$pid"
```
<!-- cheat
var action_id
var pid
-->

### Run pkexec command

#sh #pkexec

Run an allowed command through pkexec.

```sh title:"Run command with pkexec"
pkexec "$allowed_command"
```
<!-- cheat
var allowed_command
-->

## Detection

Monitor pkexec invocations, polkit rule changes, and D-Bus requests that trigger privileged actions from unusual sessions.
