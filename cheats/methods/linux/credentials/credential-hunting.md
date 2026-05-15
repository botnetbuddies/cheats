---
technique: Linux Credential Hunting
category: credentials
targets: Linux Filesystem, User Profiles
protocols: Local
remote_capable: false
tags: linux credentials hunting ssh history config cloud
---

# Linux Credential Hunting

Linux credential hunting focuses on shell history, SSH keys, application configs, environment files, service units, and cloud or orchestration credentials.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Shell access | Most checks work as the current user |
| File permissions | Root or group membership expands readable locations |

## Linux

### Shell history

#sh #history

Read Bash command history for the current user.

```sh title:"Read Bash history"
cat ~/.bash_history
```
<!-- cheat -->

### SSH private key

#sh #ssh

Read a discovered SSH private key.

```sh title:"Read SSH private key"
cat "$key_file"
```
<!-- cheat
var key_file
-->

### Find SSH keys

#sh #ssh

Find common private key filenames.

```sh title:"Find SSH private keys"
find / -name id_rsa -o -name id_ed25519 -o -name "*.pem" 2>/dev/null
```
<!-- cheat -->

### Search home configs

#sh #files

Search home directories for credential-related strings.

```sh title:"Search home directories for secrets"
grep -rIi -e password -e passwd -e secret -e token -e api_key /home 2>/dev/null
```
<!-- cheat -->

### Search system configs

#sh #files

Search `/etc` for embedded credential strings.

```sh title:"Search system configs for secrets"
grep -rIi -e password -e passwd -e secret /etc 2>/dev/null
```
<!-- cheat -->

### Environment variables

#sh #env

Print environment variables for the current process.

```sh title:"Print environment variables"
env
```
<!-- cheat -->

### Process environment

#sh #env

Read environment variables from a running process.

```sh title:"Read process environment"
tr '\0' '\n' < "/proc/$pid/environ"
```
<!-- cheat
var pid
-->

### AWS credentials

#sh #cloud

Read AWS CLI credentials for the current user.

```sh title:"Read AWS credentials"
cat ~/.aws/credentials
```
<!-- cheat -->

### Kubernetes config

#sh #cloud

Read kubeconfig credentials for the current user.

```sh title:"Read kubeconfig"
cat ~/.kube/config
```
<!-- cheat -->

### Systemd units

#sh #systemd

Search systemd unit files for environment entries.

```sh title:"Search systemd units for credentials"
grep -R "Environment=" /etc/systemd/system /lib/systemd/system 2>/dev/null
```
<!-- cheat -->

## Detection

Watch for broad recursive greps across home directories, reads of private keys, and access to cloud credential files by unusual processes.
