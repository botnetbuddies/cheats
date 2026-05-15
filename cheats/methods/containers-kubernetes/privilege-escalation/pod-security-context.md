---
technique: Kubernetes Pod Security Context Abuse
category: privilege-escalation
targets: Kubernetes Pods
protocols: Kubernetes API
remote_capable: true
tags: kubernetes security-context capabilities privileged privilege-escalation
---

# Kubernetes Pod Security Context Abuse

Pod security context issues include privileged containers, extra Linux capabilities, host users, root execution, and weak seccomp or AppArmor posture.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Workload read rights | Needed to inspect pod specs |
| Pod mutation rights | Needed to change workload security context |
| Admission | Pod Security and webhooks may block unsafe context values |

## Linux

### Pod specs

#sh #kubectl #security-context

Read pod specs for security context review.

```sh title:"Read pod specs for security context review"
kubectl get pods --all-namespaces -o yaml
```
<!-- cheat -->

### Deployment specs

#sh #kubectl #security-context

Read deployment specs for inherited pod templates.

```sh title:"Read deployment specs for security context review"
kubectl get deployments --all-namespaces -o yaml
```
<!-- cheat -->

### Can patch deployment

#sh #kubectl #rbac

Check whether the current identity can patch deployments.

```sh title:"Check deployment patch rights"
kubectl auth can-i patch deployments -n "$namespace"
```
<!-- cheat
var namespace
-->

### Dry-run security context manifest

#sh #kubectl #admission

Test a prepared security context manifest through admission.

```sh title:"Dry-run security context manifest"
kubectl apply --dry-run=server -f "$manifest_file"
```
<!-- cheat
var manifest_file
-->

### Container capabilities

#sh #linux #capabilities

Print effective capabilities from inside a container.

```sh title:"Print container capabilities"
capsh --print
```
<!-- cheat -->

### Seccomp status

#sh #linux #seccomp

Print seccomp mode for the current process.

```sh title:"Print current seccomp mode"
grep Seccomp /proc/self/status
```
<!-- cheat -->
