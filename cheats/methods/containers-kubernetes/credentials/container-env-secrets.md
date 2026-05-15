---
technique: Container Environment Secret Hunting
category: credentials
targets: Containers, Kubernetes Pods
protocols: Local Process Environment
remote_capable: false
tags: containers kubernetes credentials environment
---

# Container Environment Secret Hunting

Container environment variables often expose application credentials, cloud tokens, registry credentials, and Kubernetes service metadata.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Requires shell access in a container or host process namespace |
| Process visibility | Host PID sharing or elevated access increases process coverage |
| Scope | Environment values may belong to other workloads |

## Linux

### Current environment

#sh #linux #environment

Print the current process environment.

```sh title:"Print current environment"
env
```
<!-- cheat -->

### Process environment

#sh #linux #environment

Read a target process environment from procfs.

```sh title:"Read process environment"
strings "/proc/$pid/environ"
```
<!-- cheat
var pid
-->

### Kubernetes service variables

#sh #linux #kubernetes

Print Kubernetes-injected service environment variables.

```sh title:"Print Kubernetes service environment variables"
printenv KUBERNETES_SERVICE_HOST
```
<!-- cheat -->

### Mounted secret files

#sh #linux #credentials

Find likely mounted secret files.

```sh title:"Find mounted secret files"
find /run /var/run /etc -type f -iname "*secret*"
```
<!-- cheat -->

### Token-like files

#sh #linux #credentials

Find likely token files in common mount paths.

```sh title:"Find token-like files"
find /run /var/run /etc -type f -iname "*token*"
```
<!-- cheat -->
