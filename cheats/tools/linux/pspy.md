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

Start default monitor with pspy.

```sh title:"Pspy Start Default Monitor"
./pspy64
```
<!-- cheat -->

### File-system events

#sh #pspy #filesystem

Run file system events with pspy.

```sh title:"Pspy Run File System Events"
./pspy64 -f
```
<!-- cheat -->

### Poll interval

#sh #pspy #processes

Run poll interval with pspy.

```sh title:"Pspy Run Poll Interval"
./pspy64 -i "$interval_ms"
```
<!-- cheat
var interval_ms
-->

### Print commands only

#sh #pspy #processes

Show commands only with pspy.

```sh title:"Pspy Show Commands Only"
./pspy64 -p
```
<!-- cheat -->
