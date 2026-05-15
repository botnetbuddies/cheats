---
technique: Kubernetes Admission Policy Recon
category: recon
targets: Kubernetes Admission Controllers
protocols: Kubernetes API
remote_capable: true
tags: kubernetes recon admission policy pod-security
---

# Kubernetes Admission Policy Recon

Admission policy recon identifies controls that may block privileged workloads, host mounts, unsafe capabilities, or unsigned images.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| API access | Requires Kubernetes API access |
| RBAC rights | Some admission resources require elevated read permissions |
| kubectl | Commands assume kubectl is available |

## Linux

### Pod Security labels

#sh #kubectl #pod-security

List namespace Pod Security labels.

```sh title:"List namespace Pod Security labels"
kubectl get namespaces --show-labels
```
<!-- cheat -->

### Validating webhooks

#sh #kubectl #admission

List validating admission webhooks.

```sh title:"List validating webhook configurations"
kubectl get validatingwebhookconfigurations
```
<!-- cheat -->

### Mutating webhooks

#sh #kubectl #admission

List mutating admission webhooks.

```sh title:"List mutating webhook configurations"
kubectl get mutatingwebhookconfigurations
```
<!-- cheat -->

### Validating admission policies

#sh #kubectl #admission

List CEL validating admission policies.

```sh title:"List validating admission policies"
kubectl get validatingadmissionpolicies
```
<!-- cheat -->

### Policy engines

#sh #kubectl #policy

Look for common policy engine workloads.

```sh title:"List policy engine pods"
kubectl get pods --all-namespaces -l control-plane=controller-manager
```
<!-- cheat -->

### Dry-run pod creation

#sh #kubectl #admission

Test admission response for a prepared pod manifest without creating it.

```sh title:"Dry-run pod manifest through admission"
kubectl apply --dry-run=server -f "$manifest_file"
```
<!-- cheat
var manifest_file
-->
