---
technique: UNIX Socket Command Injection
category: privilege-escalation
targets: Linux UNIX Sockets
protocols: UNIX Socket
remote_capable: false
tags: linux privilege-escalation unix-socket command-injection
---

# UNIX Socket Command Injection

UNIX socket command injection abuses privileged local services that trust data received over filesystem sockets.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Writable socket | Current user must connect to the socket |
| Unsafe service parser | Service must pass socket data into a dangerous command path |
| Privileged service | Impact depends on the daemon's user context |

## Linux

### List UNIX sockets

#sh #socket #recon

List listening UNIX sockets.

```sh title:"List UNIX sockets"
ss -lx
```
<!-- cheat -->

### Check socket permissions

#sh #socket #filesystem

Check permissions on a candidate UNIX socket.

```sh title:"Check UNIX socket permissions"
ls -la "$socket_path"
```
<!-- cheat
var socket_path
-->

### Identify socket owner process

#sh #socket #processes

Show processes using a UNIX socket path.

```sh title:"Show UNIX socket owner"
lsof -U "$socket_path"
```
<!-- cheat
var socket_path
-->

### Send socket payload

#sh #socket #socat

Send a prepared payload string to a UNIX socket.

```sh title:"Send payload to UNIX socket"
socat - "UNIX-CONNECT:$socket_path"
```
<!-- cheat
var socket_path
-->

### Send file to socket

#sh #socket #socat

Send a prepared payload file to a UNIX socket.

```sh title:"Send payload file to UNIX socket"
socat "FILE:$payload_file" "UNIX-CONNECT:$socket_path"
```
<!-- cheat
var payload_file
var socket_path
-->

## Detection

Monitor connections to privileged UNIX sockets, world-writable socket files, and daemon command execution immediately after socket messages.
