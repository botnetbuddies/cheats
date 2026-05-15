---
technique: Shell Startup Persistence
category: persistence
targets: Linux
tags: linux persistence shell bash ssh
---

# Shell Startup Persistence

Shell startup persistence runs commands when an interactive shell or SSH session starts for a target user.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| Writable startup file | Required for the target user or service account |
| User logon path | Interactive shell or SSH startup must read the modified file |
| Prepared command | Store payload logic outside the technique note |

## Discovery

### Bashrc

#sh #bash #recon

Review commands loaded by interactive Bash shells.

```sh title:"Print user bashrc"
cat "$home_dir/.bashrc"
```
<!-- cheat
var home_dir
-->

### Profile

#sh #shell #recon

Review commands loaded by login shells.

```sh title:"Print user profile"
cat "$home_dir/.profile"
```
<!-- cheat
var home_dir
-->

### SSH rc

#sh #ssh #recon

Review commands that run during SSH session startup.

```sh title:"Print SSH rc file"
cat "$home_dir/.ssh/rc"
```
<!-- cheat
var home_dir
-->

## Abuse

### Bashrc persistence

#sh #bash #persistence

Append a prepared command to the target user's interactive Bash startup file.

```sh title:"Append bashrc command"
printf '%s\n' "$command" >> "$home_dir/.bashrc"
```
<!-- cheat
var command
var home_dir
-->

### Profile persistence

#sh #shell #persistence

Append a prepared command to the target user's login shell profile.

```sh title:"Append profile command"
printf '%s\n' "$command" >> "$home_dir/.profile"
```
<!-- cheat
var command
var home_dir
-->

### SSH rc persistence

#sh #ssh #persistence

Append a prepared command to the target user's SSH startup file.

```sh title:"Append SSH rc command"
printf '%s\n' "$command" >> "$home_dir/.ssh/rc"
```
<!-- cheat
var command
var home_dir
-->

## Detection

Monitor user shell startup files for network commands, hidden file execution, and writes outside normal profile management.
