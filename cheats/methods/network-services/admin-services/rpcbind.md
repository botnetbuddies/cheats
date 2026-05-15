---
technique: rpcbind Enumeration
category: admin-services
targets: rpcbind
protocols: RPC
remote_capable: true
tags: network-services rpc rpcbind
---

# rpcbind Enumeration

rpcbind enumeration identifies registered RPC services such as NFS, mountd, NIS, and other UNIX network services.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP or UDP 111 | Requires rpcbind reachability |
| RPC clients | Commands use rpcinfo and nmap |
| Follow-on enum | Registered services need service-specific checks |

## Linux

### RPC services

#sh #rpcinfo #rpc

List RPC services on a host.

```sh title:"List RPC services"
rpcinfo -p "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Nmap RPC scan

#sh #nmap #rpc

Run RPC-focused nmap service detection.

```sh title:"Run RPC service detection"
nmap -sV -p 111 --script rpc-grind,rpcinfo "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### UDP RPC scan

#sh #nmap #rpc

Run UDP RPC service detection.

```sh title:"Run UDP RPC service detection"
nmap -sU -sV -p 111 --script rpcinfo "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
