# Rsync

## recon

### List modules

List modules with Rsync.

```sh title:"Rsync List Modules"
rsync "$rhost_ip::"
```
<!-- cheat
var rhost_ip
-->

### List module contents

List module contents with Rsync.

```sh title:"Rsync List Module Contents"
rsync "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

### Recursive listing

List recursive listing with Rsync.

```sh title:"Rsync List Recursive Listing"
rsync -av "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

## transfer

### Download module

Download module with Rsync.

```sh title:"Rsync Download Module"
rsync -av "$rhost_ip::$module_name" "$local_dir"
```
<!-- cheat
var rhost_ip
var module_name
var local_dir
-->

### Download module path

Download module path with Rsync.

```sh title:"Rsync Download Module Path"
rsync -av "$rhost_ip::$module_name/$remote_path" "$local_path"
```
<!-- cheat
var rhost_ip
var module_name
var remote_path
var local_path
-->

### Upload module path

Upload module path with Rsync.

```sh title:"Rsync Upload Module Path"
rsync -av "$local_path" "$rhost_ip::$module_name/$remote_path"
```
<!-- cheat
var local_path
var rhost_ip
var module_name
var remote_path
-->

### SSH upload

Upload SSH upload with Rsync.

```sh title:"Rsync Upload SSH Upload"
rsync -av -e ssh "$local_path" "$user@$rhost_ip:$remote_path"
```
<!-- cheat
var local_path
var user
var rhost_ip
var remote_path
-->
