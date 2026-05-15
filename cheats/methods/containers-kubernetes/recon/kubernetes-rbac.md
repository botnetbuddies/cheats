---
technique: Kubernetes RBAC Recon
category: recon
targets: Kubernetes RBAC
protocols: Kubernetes API
remote_capable: true
tags: kubernetes recon rbac service-account authorization
---

# Kubernetes RBAC Recon

Kubernetes RBAC recon identifies what the current identity can do and which roles, bindings, and service accounts may expose escalation paths.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| API access | Requires kubeconfig or service account token |
| RBAC visibility | Listing roles and bindings depends on current permissions |

## Linux

### Current identity permissions

#sh #kubectl #rbac

Check whether the current identity can perform every action.

```sh title:"Check current RBAC permissions"
kubectl auth can-i --list
```
<!-- cheat -->

### Namespaced permissions

#sh #kubectl #rbac

Check permissions in a namespace.

```sh title:"Check namespace RBAC permissions"
kubectl auth can-i --list -n "$namespace"
```
<!-- cheat
var namespace
-->

### Service accounts

#sh #kubectl #service-account

List service accounts across namespaces.

```sh title:"List service accounts"
kubectl get serviceaccounts --all-namespaces
```
<!-- cheat -->

### Roles

#sh #kubectl #rbac

List roles across namespaces.

```sh title:"List Kubernetes roles"
kubectl get roles --all-namespaces
```
<!-- cheat -->

### Cluster roles

#sh #kubectl #rbac

List cluster roles.

```sh title:"List Kubernetes cluster roles"
kubectl get clusterroles
```
<!-- cheat -->

### Role bindings

#sh #kubectl #rbac

List role bindings across namespaces.

```sh title:"List Kubernetes role bindings"
kubectl get rolebindings --all-namespaces
```
<!-- cheat -->

### Cluster role bindings

#sh #kubectl #rbac

List cluster role bindings.

```sh title:"List Kubernetes cluster role bindings"
kubectl get clusterrolebindings
```
<!-- cheat -->
