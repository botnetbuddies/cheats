---
technique: chroot Escape
category: privilege-escalation
targets: Linux chroot
protocols: Local
remote_capable: false
tags: linux privilege-escalation chroot escape chw00t
---

# chroot Escape

chroot escape targets restricted filesystem roots when the current context has enough privilege or exposed host resources to break out.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| chroot context | Operator must be inside a chroot or equivalent filesystem jail |
| Escape primitive | Escape depends on available capabilities, mounts, devices, or privileged context |
| Tooling | chw00t can automate checks and known escape payloads |

## Linux

### chw00t help

#sh #chw00t

Print chw00t usage.

```sh title:"Print chw00t help"
./chw00t --help
```
<!-- cheat -->

### chw00t auto escape

#sh #chw00t #chroot

Run chw00t automatic chroot escape checks.

```sh title:"Run chw00t auto escape"
./chw00t
```
<!-- cheat -->

### chw00t selected method

#sh #chw00t #chroot

Run a selected chw00t escape method.

```sh title:"Run chw00t selected method"
./chw00t "$method_name"
```
<!-- cheat
var method_name
-->

## Detection

Monitor unexpected mount, chroot, namespace, device, and privileged filesystem operations from jailed contexts.
