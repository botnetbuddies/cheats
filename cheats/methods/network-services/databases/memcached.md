---
technique: Memcached Enumeration
category: databases
targets: Memcached
protocols: Memcached
remote_capable: true
tags: network-services memcached cache database
---

# Memcached Enumeration

Memcached enumeration checks unauthenticated cache exposure, server stats, slab metadata, and key visibility.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 11211 | Requires Memcached reachability |
| Tooling | Commands use nmap and libmemcached tools |
| Cache state | Keys and values may expire quickly |

## Linux

### Nmap info

#sh #nmap #memcached

Gather Memcached service information.

```sh title:"Gather Memcached info"
nmap -n -sV --script memcached-info -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 11211
-->

### Server stats

#sh #memcached

Read Memcached server stats.

```sh title:"Read Memcached stats"
memcstat --servers "$rhost_ip:$rport"
```
<!-- cheat
var rhost_ip
var rport := 11211
-->

### Dump keys

#sh #memcached

Dump visible Memcached keys.

```sh title:"Dump Memcached keys"
memcdump --servers "$rhost_ip:$rport"
```
<!-- cheat
var rhost_ip
var rport := 11211
-->

### Read key

#sh #memcached

Read a Memcached value by key.

```sh title:"Read Memcached key"
memccat --servers "$rhost_ip:$rport" "$key_name"
```
<!-- cheat
var rhost_ip
var rport := 11211
var key_name
-->
