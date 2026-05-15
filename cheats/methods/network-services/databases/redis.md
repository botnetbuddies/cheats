---
technique: Redis Enumeration
category: databases
targets: Redis
protocols: Redis
remote_capable: true
tags: network-services redis database
---

# Redis Enumeration

Redis enumeration checks unauthenticated access, authentication, TLS posture, key exposure, and dangerous write capabilities.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 6379 | Requires Redis reachability |
| Credentials | Redis may require AUTH, ACL user, or TLS client certificate |
| Scope | Avoid destructive key operations during enumeration |

## Linux

### Connect remote

#sh #redis

Connect to Redis on the default port.

```sh title:"Connect to Redis"
redis-cli -h "$rhost_ip" -a "$pass"
```
<!-- cheat
var rhost_ip
var pass
-->

### Connect custom port

#sh #redis

Connect to Redis on a custom port.

```sh title:"Connect to Redis on custom port"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass"
```
<!-- cheat
var rhost_ip
var rport := 6379
var pass
-->

### Server info

#sh #redis

Read Redis server information.

```sh title:"Read Redis server info"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass" INFO
```
<!-- cheat
var rhost_ip
var rport := 6379
var pass
-->

### Key count

#sh #redis

List database key counts.

```sh title:"List Redis key counts"
redis-cli -h "$rhost_ip" -p "$rport" -a "$pass" DBSIZE
```
<!-- cheat
var rhost_ip
var rport := 6379
var pass
-->

### TLS connection

#sh #redis

Connect to Redis over TLS with a CA certificate.

```sh title:"Connect to Redis over TLS"
redis-cli -h "$rhost_ip" -p "$rport" --tls --cacert "$ca_cert"
```
<!-- cheat
var rhost_ip
var rport := 6379
var ca_cert
-->
