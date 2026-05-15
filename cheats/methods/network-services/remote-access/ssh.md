---
technique: SSH Access and Tunneling
category: remote-access
targets: SSH
protocols: SSH
remote_capable: true
tags: network-services ssh tunneling remote-access
---

# SSH Access and Tunneling

SSH supports remote shell access, file transfer, local forwards, remote forwards, and dynamic SOCKS pivots.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 22 | Requires SSH reachability |
| Credentials | Password, key, agent, or certificate authentication may apply |
| Forwarding policy | Server configuration controls tunnel behavior |

## Linux

### Host key

#sh #ssh

Fetch a server public SSH host key.

```sh title:"Fetch SSH host public key"
ssh-keyscan -t rsa -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 22
-->

### Password login

#sh #ssh

Connect to SSH with interactive authentication.

```sh title:"Connect to SSH"
ssh "$user@$rhost_ip"
```
<!-- cheat
var user
var rhost_ip
-->

### Key login

#sh #ssh

Connect to SSH with a private key.

```sh title:"Connect to SSH with key"
ssh -i "$key_file" "$user@$rhost_ip"
```
<!-- cheat
var key_file
var user
var rhost_ip
-->

### Local forward

#sh #ssh #tunnel

Bind a local port through SSH to a remote host and port.

```sh title:"Create SSH local port forward"
ssh -L "$lport:$remote_host:$rport" "$user@$rhost_ip"
```
<!-- cheat
var lport
var remote_host
var rport
var user
var rhost_ip
-->

### Remote forward

#sh #ssh #tunnel

Open a remote port that forwards back to a local host and port.

```sh title:"Create SSH remote port forward"
ssh -R "$remote_bind:$rport:$local_host:$lport" "$user@$rhost_ip"
```
<!-- cheat
var remote_bind
var rport
var local_host
var lport
var user
var rhost_ip
-->

### Dynamic SOCKS

#sh #ssh #socks

Start a dynamic SOCKS proxy through SSH.

```sh title:"Start SSH dynamic SOCKS proxy"
ssh -D "$socks_port" "$user@$rhost_ip"
```
<!-- cheat
var socks_port
var user
var rhost_ip
-->
