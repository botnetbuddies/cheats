---
technique: Telnet Enumeration
category: remote-access
targets: Telnet
protocols: Telnet
remote_capable: true
tags: network-services telnet remote-access
---

# Telnet Enumeration

Telnet exposes plaintext interactive access and is common on legacy network gear, embedded systems, and appliances.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 23 | Requires Telnet reachability |
| Credentials | Authentication is usually plaintext |
| Terminal | Some devices require line discipline adjustments |

## Linux

### Safe scripts

#sh #nmap #telnet

Run safe Telnet NSE scripts.

```sh title:"Run safe Telnet NSE scripts"
nmap -n -sV -Pn --script "*telnet* and safe" -p 23 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Connect

#sh #telnet

Connect to a Telnet service.

```sh title:"Connect to Telnet"
telnet "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 23
-->
