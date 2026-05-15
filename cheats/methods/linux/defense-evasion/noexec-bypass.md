---
technique: noexec Bypass
category: defense-evasion
targets: Linux Filesystems
protocols: Local
remote_capable: false
tags: linux defense-evasion noexec interpreter memfd
---

# noexec Bypass

noexec bypass runs code through interpreters, dynamic loaders, or memory-backed execution paths when direct execution from a mounted filesystem is blocked.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Readable payload | The payload must be readable even when direct execution is blocked |
| Interpreter or loader | A trusted executable outside the noexec mount must run the payload |
| Compatible payload | Script and ELF payloads need different launch paths |

## Linux

### Mount options

#sh #filesystem #recon

Show filesystem mount options.

```sh title:"Show mount options"
findmnt -no TARGET,OPTIONS "$mount_path"
```
<!-- cheat
var mount_path
-->

### Run shell script with sh

#sh #shell #noexec

Run a script through `/bin/sh` from a noexec path.

```sh title:"Run script through sh"
/bin/sh "$script_path"
```
<!-- cheat
var script_path
-->

### Run Python script

#sh #python #noexec

Run a Python script through the interpreter.

```sh title:"Run script through python"
python3 "$script_path"
```
<!-- cheat
var script_path
-->

### Run ELF with loader

#sh #elf #noexec

Run an ELF binary through the dynamic loader when compatible.

```sh title:"Run ELF through dynamic loader"
/lib64/ld-linux-x86-64.so.2 "$binary_path"
```
<!-- cheat
var binary_path
-->

### memfd execution helper

#sh #memfd #noexec

Run a prepared memfd execution helper with a payload file.

```sh title:"Run payload with memfd helper"
"$helper_path" "$payload_file"
```
<!-- cheat
var helper_path
var payload_file
-->

### DDexec payload

#sh #ddexec #noexec

Run a prepared payload through a DDexec-style helper.

```sh title:"Run DDexec payload"
bash "$ddexec_script" "$payload_name"
```
<!-- cheat
var ddexec_script
var payload_name
-->

### DDexec with seeker

#sh #ddexec #noexec

Run DDexec with a selected seeker helper.

```sh title:"Run DDexec with seeker"
SEEKER="$seeker" bash "$ddexec_script" "$payload_name"
```
<!-- cheat
var seeker
var ddexec_script
var payload_name
-->

## Detection

Monitor interpreters executing files from noexec mounts, dynamic loader invocation with unusual arguments, and memfd-backed executable mappings.
