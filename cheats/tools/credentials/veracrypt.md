# VeraCrypt

## volumes

### Create volume

Create a normal VeraCrypt volume with ext4, AES, and SHA512.

```sh title:"Create VeraCrypt ext4 volume"
veracrypt -t --create "$volume_file" --hash sha512 --encryption AES --filesystem ext4 --volume-type normal -k "" --pim 0 --size "$size"
```
<!-- cheat
var volume_file
var size
-->

### Mount volume

Mount a VeraCrypt volume at a mount point.

```sh title:"Mount VeraCrypt volume"
veracrypt "$volume_file" "$mount_point"
```
<!-- cheat
var volume_file
var mount_point
-->

### Dismount volume

Dismount one VeraCrypt volume.

```sh title:"Dismount VeraCrypt volume"
veracrypt -d "$volume_file"
```
<!-- cheat
var volume_file
-->

### Dismount all

Dismount all mounted VeraCrypt volumes.

```sh title:"Dismount all VeraCrypt volumes"
veracrypt -d
```
<!-- cheat -->
