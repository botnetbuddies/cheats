---
technique: NFS Enumeration
category: file-services
targets: NFS
protocols: NFS, RPC
remote_capable: true
tags: network-services nfs rpc exports
---

# NFS Enumeration

NFS enumeration identifies exported paths, mount options, and UID-trust issues.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| RPC access | NFS commonly depends on rpcbind and mountd |
| Local mount point | Mount commands assume the mount point already exists |
| UID context | File access may depend on local numeric UID and GID |

## Linux

### Export list

#sh #nfs #rpc

List exported NFS shares.

```sh title:"List NFS exports"
showmount -e "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Nmap exports

#sh #nmap #nfs

List NFS exports with nmap.

```sh title:"List NFS exports with nmap"
nmap -sV --script nfs-showmount "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mount export

#sh #nfs #mount

Mount an NFS export locally.

```sh title:"Mount NFS export"
sudo mount -t nfs "$rhost_ip:$shared_folder" "$mount_point" -o nolock
```
<!-- cheat
var rhost_ip
var shared_folder
var mount_point
-->

### Mount NFSv2 export

#sh #nfs #mount

Mount an export with NFSv2.

```sh title:"Mount NFSv2 export"
sudo mount -t nfs -o vers=2,nolock "$rhost_ip:$shared_folder" "$mount_point"
```
<!-- cheat
var rhost_ip
var shared_folder
var mount_point
-->

### RPC services

#sh #rpcinfo #nfs

List RPC services on a host.

```sh title:"List RPC services"
rpcinfo -p "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->
