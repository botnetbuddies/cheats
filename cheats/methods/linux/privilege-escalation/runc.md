---
technique: runc Abuse
category: privilege-escalation
targets: Linux runc
protocols: Local
remote_capable: false
tags: linux privilege-escalation runc containers oci
---

# runc Abuse

runc abuse starts an OCI container from a controlled bundle, often after modifying the bundle to mount host paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| runc access | Current user must run `runc` with useful privileges |
| OCI bundle | A bundle directory with `config.json` and `rootfs` is required |
| Writable bundle | Operator must modify the runtime spec before launch |

## Linux

### Locate runc

#sh #runc #recon

Find the `runc` binary.

```sh title:"Locate runc binary"
which runc
```
<!-- cheat -->

### runc help

#sh #runc #recon

Print runc help to confirm the runtime is callable.

```sh title:"Print runc help"
runc --help
```
<!-- cheat -->

### Step 1: Create OCI spec

#sh #runc

Create a default OCI `config.json` in the bundle directory.

```sh title:"Create runc OCI spec"
runc spec
```
<!-- cheat -->

### Step 2: Create rootfs directory

#sh #runc

Create the rootfs directory required by the OCI bundle.

```sh title:"Create runc rootfs directory"
mkdir -p rootfs
```
<!-- cheat -->

### Step 3: Run OCI bundle

#sh #runc

Run the prepared OCI bundle after editing `config.json`.

```sh title:"Run prepared runc bundle"
runc run "$container_name"
```
<!-- cheat
var container_name
-->

## Detection

Monitor direct runc execution, unexpected OCI bundle creation, and runtime specs that mount host paths into containers.
