---
tool: crictl
category: tools
targets: Kubernetes Nodes, CRI Runtimes
protocols: CRI
remote_capable: false
tags: containers kubernetes crictl runtime tools
---

# crictl

`crictl` talks to CRI-compatible runtimes such as containerd and CRI-O. It is useful on Kubernetes nodes for runtime recon and container interaction.

## Linux

### Runtime info

#sh #crictl #runtime

Print CRI runtime information.

```sh title:"Print CRI runtime info"
crictl info
```
<!-- cheat -->

### Pods

#sh #crictl #kubernetes

List pods known to the runtime.

```sh title:"List CRI pods"
crictl pods
```
<!-- cheat -->

### Containers

#sh #crictl #containers

List containers known to the runtime.

```sh title:"List CRI containers"
crictl ps -a
```
<!-- cheat -->

### Images

#sh #crictl #images

List images known to the runtime.

```sh title:"List CRI images"
crictl images
```
<!-- cheat -->

### Container inspect

#sh #crictl #containers

Inspect a container by ID.

```sh title:"Inspect CRI container"
crictl inspect "$container_id"
```
<!-- cheat
var container_id
-->

### Container shell

#sh #crictl #containers

Open a shell in a running container through the runtime.

```sh title:"Open shell through crictl"
crictl exec -it "$container_id" /bin/sh
```
<!-- cheat
var container_id
-->
