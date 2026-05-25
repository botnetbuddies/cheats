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

Show runtime info with crictl.

#sh #crictl #runtime

Print CRI runtime information.

```sh title:"Crictl Show Runtime Info"
crictl info
```
<!-- cheat -->

### Pods

#sh #crictl #kubernetes

List pods with crictl.

#sh #crictl #kubernetes

List pods known to the runtime.

```sh title:"Crictl List Pods"
crictl pods
```
<!-- cheat -->

### Containers

#sh #crictl #containers

List containers with crictl.

#sh #crictl #containers

List containers known to the runtime.

```sh title:"Crictl List Containers"
crictl ps -a
```
<!-- cheat -->

### Images

#sh #crictl #images

List images with crictl.

#sh #crictl #images

List images known to the runtime.

```sh title:"Crictl List Images"
crictl images
```
<!-- cheat -->

### Container inspect

#sh #crictl #containers

Run container inspect with crictl.

#sh #crictl #containers

Inspect a container by ID.

```sh title:"Crictl Run Container Inspect"
crictl inspect "$container_id"
```
<!-- cheat
var container_id
-->

### Container shell

#sh #crictl #containers

Spawn container shell with crictl.

#sh #crictl #containers

Open a shell in a running container through the runtime.

```sh title:"Crictl Spawn Container Shell"
crictl exec -it "$container_id" /bin/sh
```
<!-- cheat
var container_id
-->
