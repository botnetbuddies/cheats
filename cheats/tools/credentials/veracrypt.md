# VeraCrypt

## volumes

### Create volume

Create volume with VeraCrypt.

Create a normal VeraCrypt volume with ext4, AES, and SHA512.

```sh title:"VeraCrypt Create Volume"
veracrypt -t --create "$volume_file" --hash sha512 --encryption AES --filesystem ext4 --volume-type normal -k "" --pim 0 --size "$size"
```
<!-- cheat
var volume_file
var size
-->

### Mount volume

Mount volume with VeraCrypt.

Mount a VeraCrypt volume at a mount point.

```sh title:"VeraCrypt Mount Volume"
veracrypt "$volume_file" "$mount_point"
```
<!-- cheat
var volume_file
var mount_point
-->

### Dismount volume

Mount dismount volume with VeraCrypt.

Dismount one VeraCrypt volume.

```sh title:"VeraCrypt Mount Dismount Volume"
veracrypt -d "$volume_file"
```
<!-- cheat
var volume_file
-->

### Dismount all

Mount dismount all with VeraCrypt.

Dismount all mounted VeraCrypt volumes.

```sh title:"VeraCrypt Mount Dismount All"
veracrypt -d
```
<!-- cheat -->
