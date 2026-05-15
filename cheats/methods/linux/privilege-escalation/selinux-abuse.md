---
technique: SELinux Abuse
category: privilege-escalation
targets: Linux SELinux
protocols: Local
remote_capable: false
tags: linux privilege-escalation selinux mac policy
---

# SELinux Abuse

SELinux abuse targets permissive domains, relabeling rights, and sudo rules that grant control over SELinux policy tools.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SELinux enabled | Target must use SELinux as part of its privilege boundary |
| Policy primitive | Operator needs relabel, permissive-domain, or policy-loading rights |
| Target domain | A confined service or user domain must be useful to weaken |

## Linux

### Current context

#sh #selinux #recon

Print the current SELinux context.

```sh title:"Print SELinux context"
id -Z
```
<!-- cheat -->

### Process labels

#sh #selinux #processes

List process SELinux labels.

```sh title:"List SELinux process labels"
ps -eZ
```
<!-- cheat -->

### Local file contexts

#sh #selinux #policy

List local SELinux file context overrides.

```sh title:"List local SELinux file contexts"
semanage fcontext -C -l
```
<!-- cheat -->

### Permissive domains

#sh #selinux #policy

List SELinux domains set to permissive mode.

```sh title:"List permissive SELinux domains"
semanage permissive -l
```
<!-- cheat -->

### Check path label

#sh #selinux #filesystem

Compare a path label with its policy default.

```sh title:"Validate SELinux path label"
matchpathcon -V "$target_path"
```
<!-- cheat
var target_path
-->

### Relabel dry run

#sh #selinux #filesystem

Preview relabel changes for a target path.

```sh title:"Preview SELinux relabel"
restorecon -n -v "$target_path"
```
<!-- cheat
var target_path
-->

### Search AVC denials

#sh #selinux #logs

Search recent SELinux access denials.

```sh title:"Search recent SELinux denials"
ausearch -m AVC,USER_AVC -ts recent
```
<!-- cheat -->

## Detection

Monitor SELinux policy module loads, local file-context changes, permissive-domain changes, and relabel operations on privileged paths.
