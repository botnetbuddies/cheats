---
technique: Sudo Abuse
category: privilege-escalation
targets: sudoers Policy
protocols: Local
remote_capable: false
tags: linux lpe sudo gtfobins env
---

# Sudo Abuse

Sudo abuse uses allowed commands, environment handling, or preserved variables to execute commands as another user, usually root.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| sudo rights | Current user needs sudo permissions for a useful command |
| Password | Some sudo rules require the user's password |

## Linux

### List sudo rights

#sh #sudo

List commands allowed by sudo.

```sh title:"List sudo rights"
sudo -l
```
<!-- cheat -->

### Run allowed command

#sh #sudo

Run an allowed command with sudo.

```sh title:"Run allowed sudo command"
sudo "$allowed_command"
```
<!-- cheat
var allowed_command
-->

### sudo as target user

#sh #sudo

Run a command as a specific user through sudo.

```sh title:"Run command as target user"
sudo -u "$target_user" "$allowed_command"
```
<!-- cheat
var target_user
var allowed_command
-->

### Preserve environment

#sh #sudo #env

Run sudo while preserving environment variables when policy allows it.

```sh title:"Run sudo with preserved environment"
sudo -E "$allowed_command"
```
<!-- cheat
var allowed_command
-->

### LD_PRELOAD

#sh #sudo #ld-preload

Run an allowed sudo command with a prepared preload library when sudoers permits it.

```sh title:"Run sudo with LD_PRELOAD"
sudo LD_PRELOAD="$payload_so" "$allowed_command"
```
<!-- cheat
var payload_so
var allowed_command
-->

### sudoedit file

#sh #sudo #file-write

Edit a sudoers-approved file through sudoedit.

```sh title:"Edit allowed file with sudoedit"
sudoedit "$target_file"
```
<!-- cheat
var target_file
-->

## Detection

Monitor sudo logs for unusual allowed command use, preserved environment variables, and `LD_PRELOAD` in command lines.
