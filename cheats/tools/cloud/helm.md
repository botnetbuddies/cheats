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

Show version with Helm.

```sh title:"Helm Show Version"
helm version
```
<!-- cheat -->

### Repositories

#sh #helm

List repositories with Helm.

```sh title:"Helm List Repositories"
helm repo list
```
<!-- cheat -->

### Releases

#sh #helm #kubernetes

List releases with Helm.

```sh title:"Helm List Releases"
helm list --all-namespaces
```
<!-- cheat -->

### Release values

#sh #helm #kubernetes

Read release values with Helm.

```sh title:"Helm Read Release Values"
helm get values "$release_name" -n "$namespace" --all
```
<!-- cheat
var release_name
var namespace
-->

### Release manifest

#sh #helm #kubernetes

Read release manifest with Helm.

```sh title:"Helm Read Release Manifest"
helm get manifest "$release_name" -n "$namespace"
```
<!-- cheat
var release_name
var namespace
-->

### Release history

#sh #helm #kubernetes

Read release history with Helm.

```sh title:"Helm Read Release History"
helm history "$release_name" -n "$namespace"
```
<!-- cheat
var release_name
var namespace
-->
