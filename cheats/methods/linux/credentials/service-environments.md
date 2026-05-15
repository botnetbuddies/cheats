---
technique: Service Environment Secrets
category: credentials
targets: Linux Services
protocols: Local
remote_capable: false
tags: linux credentials environment systemd proc
---

# Service Environment Secrets

Service environment hunting targets inherited variables, systemd `Environment=` values, and environment files that expose tokens or passwords.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Process visibility | Reading other process environments may require root or same UID |
| Service inventory | Unit files and process IDs identify candidate services |

## Linux

### Process environment

#sh #env #proc

Read environment variables from a process.

```sh title:"Read process environment variables"
tr '\0' '\n' < "/proc/$pid/environ"
```
<!-- cheat
var pid
-->

### Service environment entries

#sh #systemd #env

Search systemd units for inline environment variables.

```sh title:"Search systemd Environment entries"
grep -R "^Environment=" /etc/systemd/system /lib/systemd/system 2>/dev/null
```
<!-- cheat -->

### Service environment files

#sh #systemd #env

Search systemd units for environment file references.

```sh title:"Search systemd EnvironmentFile entries"
grep -R "^EnvironmentFile=" /etc/systemd/system /lib/systemd/system 2>/dev/null
```
<!-- cheat -->

### Print unit environment

#sh #systemd #env

Print environment values configured for a service.

```sh title:"Print service environment property"
systemctl show -p Environment "$unit_name"
```
<!-- cheat
var unit_name
-->

### Read environment file

#sh #env #files

Read a discovered environment file.

```sh title:"Read service environment file"
cat "$env_file"
```
<!-- cheat
var env_file
-->

## Detection

Monitor reads of `/proc/*/environ`, service environment files, and recursive searches through systemd unit directories.
