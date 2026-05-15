---
technique: Kubeconfig File Hunting
category: credentials
targets: Kubernetes
protocols: Kubernetes API
remote_capable: false
tags: kubernetes credentials kubeconfig
---

# Kubeconfig File Hunting

Kubeconfig files can contain client certificates, bearer tokens, exec plugins, and cluster endpoints for local or remote Kubernetes access.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Filesystem access | Requires shell access on a workstation, server, or container |
| kubectl | Useful for validating discovered kubeconfigs |
| Scope | Treat discovered contexts as separate identities |

## Linux

### Default kubeconfig

#sh #kubeconfig #credentials

Check the default user kubeconfig path.

```sh title:"List default kubeconfig"
ls -la ~/.kube/config
```
<!-- cheat -->

### System kubeconfigs

#sh #kubeconfig #credentials

Find kubeconfig files under common system paths.

```sh title:"Find system kubeconfig files"
find /etc /opt /var -type f -name "*kubeconfig*"
```
<!-- cheat -->

### User kubeconfigs

#sh #kubeconfig #credentials

Find kubeconfig files under home directories.

```sh title:"Find user kubeconfig files"
find /home -type f -path "*/.kube/config"
```
<!-- cheat -->

### Kubeconfig contexts

#sh #kubectl #kubeconfig

List contexts from a discovered kubeconfig.

```sh title:"List contexts from kubeconfig"
kubectl --kubeconfig "$kubeconfig_file" config get-contexts
```
<!-- cheat
var kubeconfig_file
-->

### Kubeconfig current user

#sh #kubectl #kubeconfig

Print the selected user from a kubeconfig.

```sh title:"Print current kubeconfig user"
kubectl --kubeconfig "$kubeconfig_file" config view --minify -o "jsonpath={.contexts[0].context.user}"
```
<!-- cheat
var kubeconfig_file
-->

### Kubeconfig auth test

#sh #kubectl #kubeconfig

Validate API access from a discovered kubeconfig.

```sh title:"Test kubeconfig API access"
kubectl --kubeconfig "$kubeconfig_file" auth can-i get pods --all-namespaces
```
<!-- cheat
var kubeconfig_file
-->
