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

Show version with ctr.

#sh #ctr #containerd

Print the ctr client and server version.

```sh title:"Ctr Show Version"
ctr version
```
<!-- cheat -->

### Images

#sh #ctr #containerd

List images with ctr.

#sh #ctr #containerd

List containerd images.

```sh title:"Ctr List Images"
ctr images list
```
<!-- cheat -->

### Containers

#sh #ctr #containerd

List containers with ctr.

#sh #ctr #containerd

List containerd containers.

```sh title:"Ctr List Containers"
ctr containers list
```
<!-- cheat -->

### Tasks

#sh #ctr #containerd

List tasks with ctr.

#sh #ctr #containerd

List running containerd tasks.

```sh title:"Ctr List Tasks"
ctr tasks list
```
<!-- cheat -->

### Kubernetes namespace images

#sh #ctr #containerd #kubernetes

List kubernetes namespace images with ctr.

#sh #ctr #containerd #kubernetes

List images in the Kubernetes containerd namespace.

```sh title:"Ctr List Kubernetes Namespace Images"
ctr --namespace k8s.io images list
```
<!-- cheat -->

### Host mount container

#sh #ctr #containerd

Execute host mount container with ctr.

#sh #ctr #containerd

Run an image with the host filesystem bind-mounted.

```sh title:"Ctr Execute Host Mount Container"
ctr run --mount type=bind,src=/,dst=/host,options=rbind:rw -t "$image_name" "$container_name" /bin/sh
```
<!-- cheat
var image_name
var container_name
-->
