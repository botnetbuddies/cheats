---
tool: Helm
category: tools
targets: Kubernetes
protocols: Kubernetes API
remote_capable: true
tags: kubernetes helm charts tools
---

# Helm

Helm manages Kubernetes charts and releases. It is useful for finding deployed applications, values, release history, and legacy Tiller exposure.

## Linux

### Version

#sh #helm

Print Helm version.

```sh title:"Print Helm version"
helm version
```
<!-- cheat -->

### Repositories

#sh #helm

List configured chart repositories.

```sh title:"List Helm repositories"
helm repo list
```
<!-- cheat -->

### Releases

#sh #helm #kubernetes

List releases across namespaces.

```sh title:"List Helm releases"
helm list --all-namespaces
```
<!-- cheat -->

### Release values

#sh #helm #kubernetes

Read values for a release.

```sh title:"Read Helm release values"
helm get values "$release_name" -n "$namespace" --all
```
<!-- cheat
var release_name
var namespace
-->

### Release manifest

#sh #helm #kubernetes

Read the rendered manifest for a release.

```sh title:"Read Helm release manifest"
helm get manifest "$release_name" -n "$namespace"
```
<!-- cheat
var release_name
var namespace
-->

### Release history

#sh #helm #kubernetes

Read release revision history.

```sh title:"Read Helm release history"
helm history "$release_name" -n "$namespace"
```
<!-- cheat
var release_name
var namespace
-->
