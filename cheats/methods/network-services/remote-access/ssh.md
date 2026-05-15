---
technique: SSH Enumeration
category: remote-access
targets: SSH
protocols: SSH
remote_capable: true
tags: network-services ssh remote-access enumeration
---

# SSH Enumeration

SSH enumeration identifies reachable SSH services, host keys, authentication posture, and user exposure before access or tunneling attempts.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 22 | Requires SSH reachability |
| Tooling | Service checks use ssh-keyscan, nmap, or scanner modules |

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

### User enumeration

#sh #metasploit #ssh

Enumerate SSH usernames with Metasploit.

```sh title:"Enumerate SSH usernames with Metasploit"
msfconsole -x "use scanner/ssh/ssh_enumusers; set RHOSTS $rhost_ip; set USER_FILE $user_file; set CHECK_FALSE true; run; exit"
```
<!-- cheat
var rhost_ip
var user_file
-->
