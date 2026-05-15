---
technique: Linux Namespace Recon
category: recon
targets: Linux Namespaces
protocols: Local
remote_capable: false
tags: linux recon namespaces containers network
---

# Linux Namespace Recon

Namespace recon identifies container boundaries, hidden network stacks, and host namespace handles that can change movement and escape options.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | Commands run from the target host or container |
| procfs access | Namespace links are exposed through `/proc` |

## Linux

### Current namespaces

#sh #namespaces

List namespaces for the current process.

```sh title:"List current namespaces"
ls -la /proc/self/ns
```
<!-- cheat -->

### Init namespaces

#sh #namespaces

List namespaces for PID 1.

```sh title:"List PID one namespaces"
ls -la /proc/1/ns
```
<!-- cheat -->

### Network namespaces

#sh #network #namespaces

List named network namespaces.

```sh title:"List named network namespaces"
ip netns list
```
<!-- cheat -->

### Namespace process list

#sh #namespaces #processes

List namespace IDs for running processes.

```sh title:"List process namespace IDs"
lsns
```
<!-- cheat -->

### Enter network namespace

#sh #namespaces #network

Run a command inside a process network namespace.

```sh title:"Enter process network namespace"
nsenter --net="/proc/$pid/ns/net" "$command"
```
<!-- cheat
var pid
var command
-->

### Enter mount namespace

#sh #namespaces #mount

Run a command inside a process mount namespace.

```sh title:"Enter process mount namespace"
nsenter --mount="/proc/$pid/ns/mnt" "$command"
```
<!-- cheat
var pid
var command
-->

## Detection

Watch for namespace entry commands, process namespace enumeration, and shells spawned in host namespaces from container contexts.
