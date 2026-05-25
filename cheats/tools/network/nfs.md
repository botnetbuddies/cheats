# Nfs

## nfs

### List NFS exports

List NFS exports with Nfs.

List exported NFS shares on the target. First step before mounting anything.

```sh title:"Nfs List NFS Exports"
showmount -e $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Mount NFS share

Mount NFS share with Nfs.

Mount the named export locally with `nolock`. NFS often trusts UID, so pair with `id` from a target user before mounting if files have restrictive ownership.

```sh title:"Nfs Mount NFS Share"
mkdir -p "$mount_point" && sudo mount -t nfs "$rhost_ip:$shared_folder" "$mount_point" -o nolock
```
<!-- cheat
var mount_point
var rhost_ip
var shared_folder
-->

### Nmap showmount

Show nmap showmount with Nfs.

List exported NFS shares with nmap.

```sh title:"Nfs Show Nmap Showmount"
nmap -sV --script nfs-showmount "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mount NFSv2 share

Mount NFSv2 share with Nfs.

Mount the named export with NFSv2 and `nolock`.

```sh title:"Nfs Mount NFSv2 Share"
mkdir -p "$mount_point" && sudo mount -t nfs -o vers=2,nolock "$rhost_ip:$shared_folder" "$mount_point"
```
<!-- cheat
var mount_point
var rhost_ip
var shared_folder
-->
