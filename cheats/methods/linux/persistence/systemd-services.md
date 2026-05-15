---
technique: systemd Service Persistence
category: persistence
targets: Linux systemd
protocols: Local
remote_capable: false
tags: linux persistence systemd service
---

# systemd Service Persistence

systemd persistence registers a service unit that starts a prepared command or payload. System units require root, while user units run in the target user's context.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Unit file | A prepared `.service` file must exist |
| Write access | System units require root write access to systemd unit paths |

## Linux

### Step 1: Copy system unit

#sh #systemd

Copy a prepared service unit into the system unit directory.

```sh title:"Copy systemd service unit"
cp "$unit_file" "/etc/systemd/system/$service_name.service"
```
<!-- cheat
var unit_file
var service_name
-->

### Step 2: Reload systemd

#sh #systemd

Reload systemd unit metadata.

```sh title:"Reload systemd units"
systemctl daemon-reload
```
<!-- cheat -->

### Step 3: Enable service

#sh #systemd

Enable the service to start at boot.

```sh title:"Enable systemd service"
systemctl enable "$service_name.service"
```
<!-- cheat
var service_name
-->

### Step 4: Start service

#sh #systemd

Start the service immediately.

```sh title:"Start systemd service"
systemctl start "$service_name.service"
```
<!-- cheat
var service_name
-->

### Check service

#sh #systemd

Check service status.

```sh title:"Check systemd service status"
systemctl status "$service_name.service"
```
<!-- cheat
var service_name
-->

### Disable service

#sh #systemd #cleanup

Disable the service at boot.

```sh title:"Disable systemd service"
systemctl disable "$service_name.service"
```
<!-- cheat
var service_name
-->

## Detection

Monitor new unit files, daemon reloads, service enables, and services executing from temporary or user-writable paths.
