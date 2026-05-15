---
technique: Scheduled Task Persistence
category: persistence
targets: Windows Task Scheduler
protocols: Local, RPC
remote_capable: true
tags: windows persistence scheduled-tasks schtasks lateral-movement
---

# Scheduled Task Persistence

Scheduled tasks can run commands at logon, on a timer, or on another trigger. They also support remote creation when the operator has administrative rights on the target.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Task rights | Local creation usually requires the current user's context. Privileged task creation requires admin |
| Command path | The task action must point to a reachable executable or command |
| Remote admin | Remote task creation requires administrative rights on the remote host |

## Windows

### List scheduled tasks

#cmd #scheduled-tasks

List scheduled tasks verbosely.

```cmd title:"List scheduled tasks"
schtasks /query /fo LIST /v
```
<!-- cheat -->

### Find scheduled task

#cmd #scheduled-tasks

Find a scheduled task by name.

```cmd title:"Find scheduled task by name"
schtasks /query /fo LIST 2>nul | findstr "$task_name"
```
<!-- cheat
var task_name
-->

### Create minute task

#cmd #scheduled-tasks

Create a scheduled task that runs every minute.

```cmd title:"Create scheduled task that runs every minute"
schtasks /create /sc minute /mo 1 /tn "$task_name" /tr "$command"
```
<!-- cheat
var task_name
var command
-->

### Create daily remote task

#cmd #scheduled-tasks

Create a scheduled task on a remote computer.

```cmd title:"Create remote scheduled task"
schtasks /create /s "$rhost_name" /tn "$task_name" /tr "$command" /sc daily
```
<!-- cheat
var rhost_name
var task_name
var command
-->

### Run task

#cmd #scheduled-tasks

Run a scheduled task immediately.

```cmd title:"Run scheduled task immediately"
schtasks /run /tn "$task_name"
```
<!-- cheat
var task_name
-->

### Delete task

#cmd #scheduled-tasks #cleanup

Delete a scheduled task.

```cmd title:"Delete scheduled task"
schtasks /delete /tn "$task_name" /f
```
<!-- cheat
var task_name
-->

## Linux

No Linux operator command is included here. This note covers Windows-native scheduled task commands.
