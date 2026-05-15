---
technique: Container Posture Recon
category: recon
targets: Containers
protocols: Local
remote_capable: false
tags: containers recon capabilities seccomp apparmor mounts
---

# Container Posture Recon

Container posture recon identifies whether the current process runs inside a container and what isolation controls are active.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Container shell | Commands run from a suspected container |
| procfs access | Most checks read `/proc` and cgroup metadata |

## Linux

### Container cgroup

#sh #containers #cgroups

Read cgroup membership for the current process.

```sh title:"Read current cgroup membership"
cat /proc/1/cgroup
```
<!-- cheat -->

### Mount info

#sh #containers #mounts

Read mountinfo for PID 1.

```sh title:"Read container mountinfo"
cat /proc/1/mountinfo
```
<!-- cheat -->

### Capabilities

#sh #containers #capabilities

Print current capability state.

```sh title:"Print container capabilities"
capsh --print
```
<!-- cheat -->

### Seccomp status

#sh #containers #seccomp

Read seccomp mode for the current process.

```sh title:"Read container seccomp status"
grep Seccomp /proc/self/status
```
<!-- cheat -->

### AppArmor label

#sh #containers #apparmor

Read the AppArmor label for the current process.

```sh title:"Read AppArmor label"
cat /proc/self/attr/current
```
<!-- cheat -->

### Hostname

#sh #containers #uts

Print the container hostname.

```sh title:"Print container hostname"
hostname
```
<!-- cheat -->
