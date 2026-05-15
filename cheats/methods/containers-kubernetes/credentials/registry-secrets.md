---
technique: Registry Secret Hunting
category: credentials
targets: Docker, Kubernetes
protocols: Docker Registry, Kubernetes API
remote_capable: true
tags: containers kubernetes credentials registry imagepullsecret
---

# Registry Secret Hunting

Registry secret hunting collects Docker config files and Kubernetes image pull secrets that can authenticate to private registries.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| File or API access | Requires readable Docker config or Kubernetes secret rights |
| Registry scope | Credentials may be scoped to one registry or namespace |

## Linux

### Docker config

#sh #docker #credentials

Read the current user's Docker config.

```sh title:"Read Docker config"
cat ~/.docker/config.json
```
<!-- cheat -->

### Root Docker config

#sh #docker #credentials

Read root's Docker config when permissions allow it.

```sh title:"Read root Docker config"
cat /root/.docker/config.json
```
<!-- cheat -->

### Image pull secrets

#sh #kubectl #credentials

List Kubernetes image pull secrets.

```sh title:"List image pull secrets"
kubectl get secrets --all-namespaces --field-selector type=kubernetes.io/dockerconfigjson
```
<!-- cheat -->

### Read image pull secret

#sh #kubectl #credentials

Read an image pull secret in JSON form.

```sh title:"Read image pull secret JSON"
kubectl get secret "$secret_name" -n "$namespace" -o json
```
<!-- cheat
var secret_name
var namespace
-->
