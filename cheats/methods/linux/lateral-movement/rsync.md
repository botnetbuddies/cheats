---
technique: rsync Movement
category: lateral-movement
targets: Linux rsync Servers
protocols: rsync, SSH
remote_capable: true
tags: linux lateral-movement rsync file-transfer
---

# rsync Movement

rsync movement copies files through SSH or rsync daemons and can expose writable modules, backups, and staged tooling paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | SSH or rsync daemon port must be reachable |
| Credentials or open module | Access depends on SSH credentials or daemon module policy |
| Destination write access | Uploads require write permission on the target path |

## Linux

### List daemon modules

#sh #rsync #recon

List modules exposed by an rsync daemon.

```sh title:"List rsync modules"
rsync "$rhost::"
```
<!-- cheat
var rhost
-->

### List module files

#sh #rsync #recon

List files exposed by an rsync module.

```sh title:"List rsync module files"
rsync "$rhost::$module_name"
```
<!-- cheat
var rhost
var module_name
-->

### Download module path

#sh #rsync #download

Download a path from an rsync module.

```sh title:"Download rsync module path"
rsync -av "$rhost::$module_name/$remote_path" "$local_path"
```
<!-- cheat
var rhost
var module_name
var remote_path
var local_path
-->

### Upload module path

#sh #rsync #upload

Upload a file or directory to a writable rsync module path.

```sh title:"Upload rsync module path"
rsync -av "$local_path" "$rhost::$module_name/$remote_path"
```
<!-- cheat
var local_path
var rhost
var module_name
var remote_path
-->

### SSH rsync upload

#sh #rsync #ssh

Upload a file or directory through rsync over SSH.

```sh title:"Upload with rsync over SSH"
rsync -av -e ssh "$local_path" "$user@$rhost:$remote_path"
```
<!-- cheat
var local_path
var user
var rhost
var remote_path
-->

## Detection

Monitor rsync daemon module access, large file transfers, and writes to shared backup or deployment paths.
