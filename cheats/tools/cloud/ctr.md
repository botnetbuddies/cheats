---
tool: ctr
category: tools
targets: containerd
protocols: containerd API
remote_capable: false
tags: containers containerd ctr tools
---

# ctr

`ctr` is the low-level containerd client. Access to the containerd socket can expose images, containers, tasks, snapshots, and privileged container creation.

## Linux

### Version

#sh #ctr #containerd

Print the ctr client and server version.

```sh title:"Print ctr version"
ctr version
```
<!-- cheat -->

### Images

#sh #ctr #containerd

List containerd images.

```sh title:"ctr List containerd images"
ctr images list
```
<!-- cheat -->

### Containers

#sh #ctr #containerd

List containerd containers.

```sh title:"ctr List containerd containers"
ctr containers list
```
<!-- cheat -->

### Tasks

#sh #ctr #containerd

List running containerd tasks.

```sh title:"ctr List containerd tasks"
ctr tasks list
```
<!-- cheat -->

### Kubernetes namespace images

#sh #ctr #containerd #kubernetes

List images in the Kubernetes containerd namespace.

```sh title:"ctr List Kubernetes namespace images"
ctr --namespace k8s.io images list
```
<!-- cheat -->

### Host mount container

#sh #ctr #containerd

Run an image with the host filesystem bind-mounted.

```sh title:"ctr Run containerd task with host mount"
ctr run --mount type=bind,src=/,dst=/host,options=rbind:rw -t "$image_name" "$container_name" /bin/sh
```
<!-- cheat
var image_name
var container_name
-->
