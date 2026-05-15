---
tool: chw00t
category: linux-tool
tags: linux tool chroot escape chw00t
---

# chw00t

chw00t automates chroot escape checks and payloads when the current context has the privileges needed to break out.

## Linux

### Help

#sh #chw00t

Print chw00t usage.

```sh title:"Print chw00t help"
./chw00t --help
```
<!-- cheat -->

### Auto escape

#sh #chw00t #chroot

Run chw00t automatic chroot escape checks.

```sh title:"Run chw00t auto escape"
./chw00t
```
<!-- cheat -->

### Target method

#sh #chw00t #chroot

Run a selected chw00t escape method.

```sh title:"Run chw00t selected method"
./chw00t "$method_name"
```
<!-- cheat
var method_name
-->
