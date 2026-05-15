---
technique: NFS Movement
category: lateral-movement
targets: Linux
protocols: NFS
remote_capable: true
tags: linux lateral-movement nfs file-share
---

# NFS Movement

NFS movement uses exported filesystems to stage tools, read shared data, or pivot through weak host trust and export permissions.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| NFS exposure | Usually TCP or UDP 2049 |
| Export access | Client IP and export options control access |
| Local mount point | Required before interacting with the export like a filesystem |

## Discovery

### Show exports

#sh #nfs #recon

List NFS exports exposed by a target host.

```sh title:"List NFS exports"
showmount -e "$rhost"
```
<!-- cheat
var rhost
-->

### RPC services

#sh #rpc #recon

List RPC services and NFS versions exposed by a target host.

```sh title:"List target RPC services"
rpcinfo -p "$rhost"
```
<!-- cheat
var rhost
-->

## Access

### Step 1: Create mount point

#sh #nfs

Create a local directory for the NFS mount.

```sh title:"Create NFS mount point"
mkdir -p "$mount_point"
```
<!-- cheat
var mount_point
-->

### Step 2: Mount export

#sh #nfs

Mount an NFS export from the target host.

```sh title:"Mount NFS export"
mount -t nfs "$rhost:$export_path" "$mount_point"
```
<!-- cheat
var rhost
var export_path
var mount_point
-->

### List mounted export

#sh #nfs

List files on the mounted export.

```sh title:"List mounted NFS export"
ls -la "$mount_point"
```
<!-- cheat
var mount_point
-->

## Detection

Monitor mountd logs, new client IPs, unexpected export reads, and writes to shared directories from nonstandard hosts.
