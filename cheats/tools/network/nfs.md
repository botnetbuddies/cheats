# Nfs

## nfs

### List NFS exports

List exported NFS shares on the target. First step before mounting anything.

```sh title:"List exported NFS shares via showmount -e"
showmount -e $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Mount NFS share

Mount the named export locally with `nolock`. NFS often trusts UID, so pair with `id` from a target user before mounting if files have restrictive ownership.

```sh title:"Mount NFS export locally with nolock"
mkdir -p "$mount_point" && sudo mount -t nfs "$rhost_ip:$shared_folder" "$mount_point" -o nolock
```
<!-- cheat
var mount_point
var rhost_ip
var shared_folder
-->

### Nmap showmount

List exported NFS shares with nmap.

```sh title:"List NFS exports with nmap"
nmap -sV --script nfs-showmount "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mount NFSv2 share

Mount the named export with NFSv2 and `nolock`.

```sh title:"Mount NFSv2 export with nolock"
mkdir -p "$mount_point" && sudo mount -t nfs -o vers=2,nolock "$rhost_ip:$shared_folder" "$mount_point"
```
<!-- cheat
var mount_point
var rhost_ip
var shared_folder
-->
