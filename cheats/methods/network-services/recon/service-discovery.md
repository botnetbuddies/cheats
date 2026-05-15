---
technique: Network Service Discovery
category: recon
targets: Network Services
protocols: TCP, UDP
remote_capable: true
tags: network-services recon nmap masscan
---

# Network Service Discovery

Network service discovery identifies exposed TCP and UDP services before protocol-specific enumeration.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Scope | Requires authorized target hosts or ranges |
| Network path | Firewalls and routing affect results |
| Tooling | Commands assume nmap or masscan is available |

## Linux

### Fast TCP top ports

#sh #nmap #recon

Scan common TCP ports quickly.

```sh title:"Scan common TCP ports"
nmap -Pn --top-ports 1000 --open "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Full TCP port scan

#sh #nmap #recon

Scan all TCP ports.

```sh title:"Scan all TCP ports"
nmap -Pn -p- --open "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Service detection

#sh #nmap #recon

Run version detection on known ports.

```sh title:"Run service detection"
nmap -Pn -sV -sC -p "$ports" "$rhost_ip"
```
<!-- cheat
var ports
var rhost_ip
-->

### UDP top ports

#sh #nmap #udp

Scan common UDP ports.

```sh title:"Scan common UDP ports"
nmap -Pn -sU --top-ports 100 --open "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Masscan TCP range

#sh #masscan #recon

Scan a range with masscan.

```sh title:"Scan TCP range with masscan"
masscan "$cidr" -p "$ports" --rate "$rate"
```
<!-- cheat
var cidr
var ports
var rate := 1000
-->
