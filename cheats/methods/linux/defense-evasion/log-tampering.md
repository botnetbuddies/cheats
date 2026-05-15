---
technique: Log Tampering
category: defense-evasion
targets: Linux
tags: linux defense-evasion logs journal history
---

# Log Tampering

Linux log tampering targets shell history, journal entries, and plaintext logs that record operator activity.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| File access | Log removal requires write access to the target file |
| Service awareness | Journald, syslog, auditd, and application logs store separate evidence |
| Retention awareness | Centralized logging may retain events after local cleanup |

## Discovery

### Login history

#sh #logs #recon

Show recent login sessions from wtmp.

```sh title:"Show recent logins"
last
```
<!-- cheat -->

### Failed login history

#sh #logs #recon

Show failed login records from btmp.

```sh title:"Show failed logins"
lastb
```
<!-- cheat -->

### Journal entries

#sh #journald #recon

Read recent systemd journal entries for a unit.

```sh title:"Read unit journal"
journalctl -u "$unit_name"
```
<!-- cheat
var unit_name
-->

### Auth log

#sh #logs #recon

Read authentication log entries on Debian-family systems.

```sh title:"Read auth log"
tail -n 200 /var/log/auth.log
```
<!-- cheat -->

## Abuse

### Disable shell history

#sh #history

Disable Bash history writes for the current shell.

```sh title:"Disable bash history file"
unset HISTFILE
```
<!-- cheat -->

### Clear current shell history

#sh #history

Clear in-memory Bash history for the current session.

```sh title:"Clear bash history"
history -c
```
<!-- cheat -->

### Truncate target log

#sh #logs

Truncate a writable log file.

```sh title:"Truncate log file"
truncate -s 0 "$log_file"
```
<!-- cheat
var log_file
-->

### Vacuum journal by time

#sh #journald

Remove journal entries older than a selected retention window.

```sh title:"Vacuum old journal entries"
journalctl --vacuum-time="$retention_window"
```
<!-- cheat
var retention_window
-->

## Detection

Look for gaps in log timelines, journal vacuum events, cleared shell history, and endpoint telemetry that survived local file cleanup.
