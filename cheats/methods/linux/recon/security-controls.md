---
technique: Linux Security Controls
category: recon
targets: Linux Workstation, Linux Server
protocols: Local
remote_capable: false
tags: linux recon apparmor selinux seccomp capabilities
---

# Linux Security Controls

Security control enumeration identifies AppArmor, SELinux, seccomp, namespaces, and capability constraints that shape what payloads and privilege escalation paths can run.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | Commands run from the target host |
| Tool availability | Some distributions omit AppArmor or SELinux utilities |

## Linux

### AppArmor status

#sh #apparmor

Print AppArmor enforcement status and loaded profiles.

```sh title:"Print AppArmor status"
aa-status
```
<!-- cheat -->

### SELinux status

#sh #selinux

Print SELinux mode and policy status.

```sh title:"Print SELinux status"
sestatus
```
<!-- cheat -->

### Current SELinux mode

#sh #selinux

Print the current SELinux enforcement mode.

```sh title:"Print SELinux mode"
getenforce
```
<!-- cheat -->

### Process security labels

#sh #selinux #processes

List processes with security labels.

```sh title:"List process security labels"
ps axZ
```
<!-- cheat -->

### Current capability set

#sh #capabilities

Print the current process capability state.

```sh title:"Print current capabilities"
capsh --print
```
<!-- cheat -->

### Seccomp status

#sh #seccomp

Print seccomp status for a process.

```sh title:"Print process seccomp status"
grep Seccomp "/proc/$pid/status"
```
<!-- cheat
var pid
-->

## Detection

Security control recon appears as profile status checks, process label enumeration, and reads from `/proc/*/status`.
