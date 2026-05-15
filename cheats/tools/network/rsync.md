# Rsync

## recon

### List modules

List modules exposed by an rsync daemon.

```sh title:"List rsync modules"
rsync "$rhost_ip::"
```
<!-- cheat
var rhost_ip
-->

### List module contents

List files exposed by an rsync module.

```sh title:"List rsync module contents"
rsync "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

### Recursive listing

Recursively list a module.

```sh title:"Recursively list rsync module"
rsync -av "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

## transfer

### Download module

Download a module to a local directory.

```sh title:"Download rsync module"
rsync -av "$rhost_ip::$module_name" "$local_dir"
```
<!-- cheat
var rhost_ip
var module_name
var local_dir
-->

### Download module path

Download a path from an rsync module.

```sh title:"Download rsync module path"
rsync -av "$rhost_ip::$module_name/$remote_path" "$local_path"
```
<!-- cheat
var rhost_ip
var module_name
var remote_path
var local_path
-->

### Upload module path

Upload a file or directory to a writable rsync module path.

```sh title:"Upload rsync module path"
rsync -av "$local_path" "$rhost_ip::$module_name/$remote_path"
```
<!-- cheat
var local_path
var rhost_ip
var module_name
var remote_path
-->

### SSH upload

Upload a file or directory through rsync over SSH.

```sh title:"Upload with rsync over SSH"
rsync -av -e ssh "$local_path" "$user@$rhost_ip:$remote_path"
```
<!-- cheat
var local_path
var user
var rhost_ip
var remote_path
-->
