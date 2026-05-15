---
technique: Kubernetes Cluster Recon
category: recon
targets: Kubernetes
protocols: Kubernetes API
remote_capable: true
tags: kubernetes recon kubectl api cluster
---

# Kubernetes Cluster Recon

Kubernetes cluster recon maps contexts, namespaces, nodes, workloads, services, and events visible to the current kubeconfig or service account.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| API access | Requires kubeconfig or in-cluster service account access |
| RBAC rights | Output depends on permissions granted to the identity |
| kubectl | Commands assume kubectl is available |

## Linux

### Current context

#sh #kubectl #context

Print the active kubeconfig context.

```sh title:"Print current Kubernetes context"
kubectl config current-context
```
<!-- cheat -->

### Namespaces

#sh #kubectl #namespaces

List namespaces visible to the current identity.

```sh title:"List Kubernetes namespaces"
kubectl get namespaces
```
<!-- cheat -->

### Nodes

#sh #kubectl #nodes

List nodes with IPs, OS, kernel, and runtime details.

```sh title:"List Kubernetes nodes with details"
kubectl get nodes -o wide
```
<!-- cheat -->

### Pods

#sh #kubectl #pods

List pods across all namespaces.

```sh title:"List pods in all namespaces"
kubectl get pods --all-namespaces -o wide
```
<!-- cheat -->

### Services

#sh #kubectl #services

List services across all namespaces.

```sh title:"List services in all namespaces"
kubectl get services --all-namespaces -o wide
```
<!-- cheat -->

### Events

#sh #kubectl #events

List recent cluster events across namespaces.

```sh title:"List Kubernetes events"
kubectl get events --all-namespaces
```
<!-- cheat -->
