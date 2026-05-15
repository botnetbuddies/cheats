---
technique: Host Namespace Sharing
category: privilege-escalation
targets: Kubernetes Pods, Container Runtimes
protocols: Kubernetes API
remote_capable: true
tags: kubernetes containers namespaces hostpid hostnetwork privilege-escalation
---

# Host Namespace Sharing

Host PID, network, and IPC namespace sharing turns a pod into a stronger node-level foothold, especially when paired with extra capabilities or host mounts.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Workload visibility | Recon requires pod read rights or local shell access |
| Pod creation | Abuse requires creating or patching pods |
| Admission | Namespace sharing may be blocked by policy |

## Linux

### Host namespace pods

#sh #kubectl #namespaces

List pod manifests for host namespace review.

```sh title:"List pods for host namespace review"
kubectl get pods --all-namespaces -o yaml
```
<!-- cheat -->

### Host PID process view

#sh #linux #hostpid

Check whether the container can see host processes.

```sh title:"List visible processes"
ps auxww
```
<!-- cheat -->

### Host network interfaces

#sh #linux #hostnetwork

Check whether the container sees host network interfaces.

```sh title:"List network interfaces"
ip addr
```
<!-- cheat -->

### Can create hostPID pod

#sh #kubectl #rbac

Check pod creation rights before testing a prepared host namespace manifest.

```sh title:"Check pod creation before host namespace test"
kubectl auth can-i create pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Dry-run host namespace pod

#sh #kubectl #admission

Send a prepared host namespace pod manifest through server-side admission.

```sh title:"Dry-run host namespace pod manifest"
kubectl apply --dry-run=server -f "$manifest_file"
```
<!-- cheat
var manifest_file
-->
