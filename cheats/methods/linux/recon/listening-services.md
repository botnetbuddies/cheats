---
technique: Linux Listening Services
category: recon
targets: Linux Workstation, Linux Server
protocols: Local
remote_capable: false
tags: linux recon services sockets ports processes
---

# Linux Listening Services

Listening service enumeration maps local sockets, owning processes, service units, and firewall posture before movement or privilege escalation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | Commands run from the target host |
| Process visibility | Some process ownership details require elevated privileges |

## Linux

### Listening TCP and UDP sockets

#sh #network #sockets

List listening TCP and UDP sockets with process details.

```sh title:"List listening sockets"
ss -lntup
```
<!-- cheat -->

### Listening TCP sockets

#sh #network #sockets

List listening TCP sockets.

```sh title:"List listening TCP sockets"
ss -lntp
```
<!-- cheat -->

### Listening UDP sockets

#sh #network #sockets

List listening UDP sockets.

```sh title:"List listening UDP sockets"
ss -lnup
```
<!-- cheat -->

### Open files on port

#sh #lsof #processes

Show processes using a local port.

```sh title:"Show processes on port"
lsof -i ":$rport"
```
<!-- cheat
var rport
-->

### Service for process

#sh #systemd #processes

Show the systemd unit associated with a process ID.

```sh title:"Show systemd unit for PID"
systemctl status "$pid"
```
<!-- cheat
var pid
-->

### Firewall status

#sh #firewall

Show uncomplicated firewall status when available.

```sh title:"Show UFW status"
ufw status verbose
```
<!-- cheat -->

## Detection

Local service enumeration often appears as socket inventory, process owner lookups, and firewall state checks from an interactive shell.
