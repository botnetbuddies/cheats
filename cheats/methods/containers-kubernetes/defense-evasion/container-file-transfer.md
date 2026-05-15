---
technique: Container File Transfer
category: defense-evasion
targets: Containers, Kubernetes Pods
protocols: Kubernetes API, Docker API
remote_capable: true
tags: containers kubernetes file-transfer kubectl docker
---

# Container File Transfer

Container file transfer covers moving tooling or output through `kubectl cp`, `docker cp`, and direct pod execution paths when standard network transfer tools are unavailable.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Container access | Requires pod or container access through Kubernetes or Docker |
| Tool support | `kubectl cp` depends on tar in many images |
| Permissions | Copy direction and path access depend on container filesystem permissions |

## Linux

### Copy file into pod

#sh #kubectl #file-transfer

Copy a local file into a pod.

```sh title:"Copy file into Kubernetes pod"
kubectl cp "$local_file" "$namespace/$pod_name:$remote_path"
```
<!-- cheat
var local_file
var namespace
var pod_name
var remote_path
-->

### Copy file from pod

#sh #kubectl #file-transfer

Copy a file out of a pod.

```sh title:"Copy file from Kubernetes pod"
kubectl cp "$namespace/$pod_name:$remote_path" "$local_file"
```
<!-- cheat
var namespace
var pod_name
var remote_path
var local_file
-->

### Copy file into Docker container

#sh #docker #file-transfer

Copy a local file into a Docker container.

```sh title:"Copy file into Docker container"
docker cp "$local_file" "$container_id:$remote_path"
```
<!-- cheat
var local_file
var container_id
var remote_path
-->

### Copy file from Docker container

#sh #docker #file-transfer

Copy a file out of a Docker container.

```sh title:"Copy file from Docker container"
docker cp "$container_id:$remote_path" "$local_file"
```
<!-- cheat
var container_id
var remote_path
var local_file
-->

### Execute uploaded file

#sh #kubectl #execution

Run an uploaded executable inside a pod.

```sh title:"Execute uploaded file in pod"
kubectl exec -it "$pod_name" -n "$namespace" -- "$remote_path"
```
<!-- cheat
var pod_name
var namespace
var remote_path
-->
