---
technique: SSH
category: lateral-movement
targets: Linux SSH Servers
protocols: SSH
remote_capable: true
tags: linux ssh lateral-movement tunneling keys port-forward
---

# SSH

SSH provides interactive access, file transfer, and port forwarding. Key-based access, agent forwarding, and tunneling are common movement and pivoting paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | TCP 22 or the configured SSH port must be reachable |
| Credentials | Password, private key, or forwarded agent access is required |

## Linux

### Password login

#sh #ssh

Connect to a host with SSH.

```sh title:"Connect with SSH"
ssh "$user@$rhost_ip"
```
<!-- cheat
var user
var rhost_ip
-->

### Key login

#sh #ssh #key

Connect with a private key.

```sh title:"Connect with SSH key"
ssh -i "$key_file" "$user@$rhost_ip"
```
<!-- cheat
var key_file
var user
var rhost_ip
-->

### Custom port

#sh #ssh

Connect to a non-default SSH port.

```sh title:"Connect to custom SSH port"
ssh -p "$rport" "$user@$rhost_ip"
```
<!-- cheat
var rport
var user
var rhost_ip
-->

### Local port forward

#sh #ssh #tunnel

Bind a local port that forwards through the SSH host to a remote service.

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

### Remote port forward

#sh #ssh #tunnel

Expose a local service on the remote SSH host.

```sh title:"Create SSH remote port forward"
ssh -R "$rport:127.0.0.1:$lport" "$user@$rhost_ip"
```
<!-- cheat
var rport
var lport
var user
var rhost_ip
-->

### Dynamic SOCKS proxy

#sh #ssh #socks

Start a SOCKS proxy through the SSH host.

```sh title:"Start SSH SOCKS proxy"
ssh -D "$socks_port" "$user@$rhost_ip"
```
<!-- cheat
var socks_port
var user
var rhost_ip
-->

### Agent forwarding

#sh #ssh #agent

Connect with agent forwarding enabled.

```sh title:"Connect with SSH agent forwarding"
ssh -A "$user@$rhost_ip"
```
<!-- cheat
var user
var rhost_ip
-->

### Host key scan

#sh #ssh

Fetch the SSH host public key.

```sh title:"Fetch SSH host key"
ssh-keyscan -p "$rport" "$rhost_ip"
```
<!-- cheat
var rport
var rhost_ip
-->

## Detection

Watch for unusual SSH logins, agent forwarding, long-lived port forwards, and new dynamic SOCKS listeners.
