---
technique: Linux Network Recon
category: recon
targets: Linux Network Stack
protocols: TCP, UDP, DNS
remote_capable: false
tags: linux recon network ports routes firewall dns
---

# Linux Network Recon

Linux network recon maps listeners, routes, name resolution, firewall state, and outbound connectivity before pivoting or staging payloads.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Local shell access on the host |
| Root access | Some firewall and process owner fields require root |

## Linux

### Interfaces

#sh #network

Show interface addresses and link state.

```sh title:"Show network interfaces"
ip addr
```
<!-- cheat -->

### Routes

#sh #routes

Print the kernel routing table.

```sh title:"Print routes"
ip route
```
<!-- cheat -->

### Listeners

#sh #ports

List listening TCP and UDP sockets with process information.

```sh title:"List listening sockets"
ss -tulpn
```
<!-- cheat -->

### Connections

#sh #ports

List established TCP connections.

```sh title:"List established TCP connections"
ss -tan state established
```
<!-- cheat -->

### DNS resolver

#sh #dns

Read resolver configuration.

```sh title:"Read resolver configuration"
cat /etc/resolv.conf
```
<!-- cheat -->

### Hosts file

#sh #dns

Read static host mappings.

```sh title:"Read hosts file"
cat /etc/hosts
```
<!-- cheat -->

### iptables rules

#sh #firewall

List iptables filter rules.

```sh title:"List iptables rules"
iptables -L -n -v
```
<!-- cheat -->

### nftables rules

#sh #firewall

Print nftables rules.

```sh title:"Print nftables rules"
nft list ruleset
```
<!-- cheat -->

### Outbound TCP test

#sh #egress

Test outbound TCP connectivity to a target host and port.

```sh title:"Test outbound TCP connectivity"
nc -vz -w2 "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport
-->

### DNS query

#sh #dns

Test DNS resolution through a chosen resolver.

```sh title:"Query DNS resolver"
dig +time=2 +tries=1 "@$dns_server" "$dns_name" A
```
<!-- cheat
var dns_server
var dns_name
-->

## Detection

Watch for sudden socket inventory, firewall listing, and repeated outbound connection tests from interactive shells.
