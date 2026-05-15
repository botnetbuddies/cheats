---
technique: rsync Enumeration
category: file-services
targets: rsync
protocols: rsync
remote_capable: true
tags: network-services rsync files
---

# rsync Enumeration

rsync enumeration identifies exposed modules and readable or writable sync paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 873 | Requires rsync daemon reachability |
| Module access | Modules may allow anonymous or credentialed access |
| Local storage | Downloads may copy large directory trees |

## Linux

### Modules

#sh #rsync

List exposed rsync modules.

```sh title:"List rsync modules"
rsync "$rhost_ip::"
```
<!-- cheat
var rhost_ip
-->

### Module contents

#sh #rsync

List contents of a module.

```sh title:"List rsync module contents"
rsync "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

### Recursive listing

#sh #rsync

Recursively list a module.

```sh title:"Recursively list rsync module"
rsync -av "$rhost_ip::$module_name"
```
<!-- cheat
var rhost_ip
var module_name
-->

### Download module

#sh #rsync

Download a module to a local directory.

```sh title:"Download rsync module"
rsync -av "$rhost_ip::$module_name" "$local_dir"
```
<!-- cheat
var rhost_ip
var module_name
var local_dir
-->
