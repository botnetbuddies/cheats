---
technique: Kubernetes Exec
category: lateral-movement
targets: Kubernetes Pods
protocols: Kubernetes API
remote_capable: true
tags: kubernetes lateral-movement exec pods
---

# Kubernetes Exec

Kubernetes exec opens a command or shell inside a running container through the API server.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Exec rights | Current identity must create pod exec sessions |
| Running pod | Target pod and container must be running |
| Shell availability | Minimal images may not contain common shells |

## Linux

### Check exec rights

#sh #kubectl #rbac

Check whether the current identity can exec into pods.

```sh title:"Check pod exec rights"
kubectl auth can-i create pods/exec -n "$namespace"
```
<!-- cheat
var namespace
-->

### Exec shell

#sh #kubectl #exec

Open a shell in a pod.

```sh title:"Exec shell in pod"
kubectl exec -it "$pod_name" -n "$namespace" -- /bin/sh
```
<!-- cheat
var pod_name
var namespace
-->

### Exec container shell

#sh #kubectl #exec

Open a shell in a specific container in a pod.

```sh title:"Exec shell in pod container"
kubectl exec -it "$pod_name" -c "$container_name" -n "$namespace" -- /bin/sh
```
<!-- cheat
var pod_name
var container_name
var namespace
-->

### Run command in pod

#sh #kubectl #exec

Run a command in a pod.

```sh title:"Run command in pod"
kubectl exec "$pod_name" -n "$namespace" -- "$command"
```
<!-- cheat
var pod_name
var namespace
var command
-->
