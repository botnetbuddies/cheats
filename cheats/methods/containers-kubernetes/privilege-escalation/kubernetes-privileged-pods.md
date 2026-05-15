---
technique: Kubernetes Privileged Pod Abuse
category: privilege-escalation
targets: Kubernetes Pods, Kubernetes Nodes
protocols: Kubernetes API
remote_capable: true
tags: kubernetes privilege-escalation privileged-pod hostpath node
---

# Kubernetes Privileged Pod Abuse

Privileged pod abuse creates or modifies a pod with elevated security context and host mounts to access node resources.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Workload create rights | Current identity must create or patch pods |
| Admission policy | Cluster policy must allow privileged settings or hostPath |
| Node target | Host access depends on pod scheduling to a node |

## Linux

### Check pod creation rights

#sh #kubectl #rbac

Check whether the current identity can create pods.

```sh title:"Check pod creation rights"
kubectl auth can-i create pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Check pod patch rights

#sh #kubectl #rbac

Check whether the current identity can patch pods.

```sh title:"Check pod patch rights"
kubectl auth can-i patch pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Step 1: Apply privileged pod manifest

#sh #kubectl #privileged-pod

Apply a prepared privileged pod manifest.

```sh title:"Apply privileged pod manifest"
kubectl apply -f "$manifest_file" -n "$namespace"
```
<!-- cheat
var manifest_file
var namespace
-->

### Step 2: Exec into privileged pod

#sh #kubectl #privileged-pod

Open a shell inside the privileged pod.

```sh title:"Exec into privileged pod"
kubectl exec -it "$pod_name" -n "$namespace" -- /bin/sh
```
<!-- cheat
var pod_name
var namespace
-->

### Step 3: Access host mount

#sh #kubernetes #hostpath

List the mounted host filesystem from inside the pod.

```sh title:"List mounted host filesystem"
ls -la /host
```
<!-- cheat -->
