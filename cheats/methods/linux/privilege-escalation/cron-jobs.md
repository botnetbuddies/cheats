---
technique: Cron Job Abuse
category: privilege-escalation
targets: Linux cron daemon
protocols: Local
remote_capable: false
tags: linux lpe cron writable-script path-hijack wildcard
---

# Cron Job Abuse

Cron jobs running as root can be abused when scripts are writable, command paths are unsafe, or working directories allow option injection.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Cron visibility | Operator must identify a root-run cron job |
| Write primitive | Script, directory, or command path must be writable |

## Linux

### User crontab

#sh #cron

List the current user's cron jobs.

```sh title:"List user crontab"
crontab -l
```
<!-- cheat -->

### System crontab

#sh #cron

Read the system crontab.

```sh title:"Read system crontab"
cat /etc/crontab
```
<!-- cheat -->

### Cron directories

#sh #cron

List system cron directories.

```sh title:"List system cron directories"
ls -la /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly /etc/cron.monthly
```
<!-- cheat -->

### Cron spool

#sh #cron

List cron spool directories.

```sh title:"List cron spool directories"
ls -la /var/spool/cron /var/spool/cron/crontabs 2>/dev/null
```
<!-- cheat -->

### Step 1: Check cron script permissions

#sh #cron

Check permissions on a script called by cron.

```sh title:"Check cron script permissions"
ls -la "$cron_script"
```
<!-- cheat
var cron_script
-->

### Step 2: Replace writable cron script

#sh #cron

Copy a prepared payload over a writable cron script.

```sh title:"Replace writable cron script"
cp "$payload_file" "$cron_script"
```
<!-- cheat
var payload_file
var cron_script
-->

### Step 3: Make cron payload executable

#sh #cron

Make the cron payload executable.

```sh title:"Make cron payload executable"
chmod +x "$cron_script"
```
<!-- cheat
var cron_script
-->

### pspy monitor

#sh #pspy

Monitor scheduled process execution without root.

```sh title:"Monitor cron execution with pspy"
./pspy64
```
<!-- cheat -->

## Detection

Monitor writes to cron-executed files, new executable files in cron working directories, and unexpected processes spawned by cron.
