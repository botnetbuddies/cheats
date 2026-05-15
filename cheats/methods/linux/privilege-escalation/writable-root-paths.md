---
technique: Writable Root Path Abuse
category: privilege-escalation
targets: Linux Filesystem
protocols: Local
remote_capable: false
tags: linux privilege-escalation writable-files root-owned symlink
---

# Writable Root Path Abuse

Writable root-owned paths become privilege escalation primitives when privileged services read, source, execute, or preserve attacker-controlled files.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Write access | Current user must modify a privileged path or parent directory |
| Privileged consumer | A root process must read, execute, or copy the path |
| Trigger | Service restart, cron run, package action, or login may be required |

## Linux

### User-writable root paths

#sh #filesystem #recon

Find files and directories owned by root but writable by others.

```sh title:"Find writable root-owned paths"
find / -user root -writable 2>/dev/null
```
<!-- cheat -->

### World-writable files

#sh #filesystem #recon

Find world-writable files outside procfs.

```sh title:"Find world-writable files"
find / -type f -perm -0002 ! -path "/proc/*" 2>/dev/null
```
<!-- cheat -->

### Group-writable files

#sh #filesystem #recon

Find files writable by a group.

```sh title:"Find group-writable files"
find / -type f -group "$group_name" -perm -g=w 2>/dev/null
```
<!-- cheat
var group_name
-->

### Path component permissions

#sh #filesystem #recon

Show permissions for every component in a path.

```sh title:"Show path component permissions"
namei -l "$target_path"
```
<!-- cheat
var target_path
-->

### Resolve symlink

#sh #filesystem #symlink

Resolve a candidate symlink to its final path.

```sh title:"Resolve candidate symlink"
readlink -f "$target_path"
```
<!-- cheat
var target_path
-->

## Detection

Monitor permission drift on root-owned files, writes through group-writable paths, and symlinks created in directories consumed by privileged jobs.
