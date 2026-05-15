---
tool: pspy
category: linux-tool
tags: linux tool pspy process-monitoring cron
---

# pspy

pspy monitors process execution without root and is useful for cron, systemd, backup, and script-trigger discovery.

## Linux

### Default monitor

#sh #pspy #processes

Monitor process starts with default settings.

```sh title:"Monitor process starts with pspy"
./pspy64
```
<!-- cheat -->

### File-system events

#sh #pspy #filesystem

Monitor process starts and file-system events.

```sh title:"Monitor processes and file events with pspy"
./pspy64 -f
```
<!-- cheat -->

### Poll interval

#sh #pspy #processes

Monitor process starts with a custom polling interval.

```sh title:"Monitor pspy with custom interval"
./pspy64 -i "$interval_ms"
```
<!-- cheat
var interval_ms
-->

### Print commands only

#sh #pspy #processes

Run pspy with process monitoring and no file events.

```sh title:"Monitor pspy process events only"
./pspy64 -p
```
<!-- cheat -->
