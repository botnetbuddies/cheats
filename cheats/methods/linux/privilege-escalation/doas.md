---
technique: doas Abuse
category: privilege-escalation
targets: Linux doas
protocols: Local
remote_capable: false
tags: linux privilege-escalation doas openbsd
---

# doas Abuse

doas abuse uses permissive `/etc/doas.conf` rules to run approved commands as root or another target user.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| doas installed | Target must use OpenBSD doas or a Linux port |
| Matching rule | Current user or group must match an allowed rule |
| Useful command | The allowed command must read, write, or execute something useful |

## Linux

### Read doas config

#sh #doas #recon

Read doas policy rules.

```sh title:"Read doas config"
cat /etc/doas.conf
```
<!-- cheat -->

### Validate doas config

#sh #doas #recon

Validate doas policy syntax.

```sh title:"Validate doas config"
doas -C /etc/doas.conf
```
<!-- cheat -->

### Run allowed command

#sh #doas

Run a command through doas.

```sh title:"Run command with doas"
doas "$allowed_command"
```
<!-- cheat
var allowed_command
-->

### Run as target user

#sh #doas

Run a command as a specific user through doas.

```sh title:"Run command as target user with doas"
doas -u "$target_user" "$allowed_command"
```
<!-- cheat
var target_user
var allowed_command
-->

## Detection

Monitor `/etc/doas.conf` changes and doas executions of shells, editors, interpreters, and file-copy tools.
