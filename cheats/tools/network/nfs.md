# Nfs

## nfs

### List NFS exports

List NFS exports with Nfs.

```sh title:"Nfs List NFS Exports"
showmount -e $rhost_ip
```
<!-- cheat
var rhost_ip
-->

### Mount NFS share

Mount NFS share with Nfs.

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

```sh title:"Nfs Show Nmap Showmount"
nmap -sV --script nfs-showmount "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mount NFSv2 share

Mount NFSv2 share with Nfs.

```sh title:"Nfs Mount NFSv2 Share"
mkdir -p "$mount_point" && sudo mount -t nfs -o vers=2,nolock "$rhost_ip:$shared_folder" "$mount_point"
```
<!-- cheat
var mount_point
var rhost_ip
var shared_folder
-->
