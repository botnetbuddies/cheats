---
technique: Kubernetes Secret Access
category: credentials
targets: Kubernetes Secrets
protocols: Kubernetes API
remote_capable: true
tags: kubernetes credentials secrets service-account token
---

# Kubernetes Secret Access

Kubernetes secret access collects Secret objects, mounted service account tokens, and workload configuration that may expose credentials.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Secret read rights | API secret reads require RBAC permission |
| Pod filesystem access | Mounted token reads require pod shell access |
| Decoding step | Secret data is base64 encoded by the API |

## Linux

### List secrets

#sh #kubectl #secrets

List secrets across all namespaces.

```sh title:"List Kubernetes secrets"
kubectl get secrets --all-namespaces
```
<!-- cheat -->

### Read secret YAML

#sh #kubectl #secrets

Read a secret in YAML form.

```sh title:"Read Kubernetes secret YAML"
kubectl get secret "$secret_name" -n "$namespace" -o yaml
```
<!-- cheat
var secret_name
var namespace
-->

### Decode secret value

#sh #kubectl #secrets

Print a decoded value from a secret key.

```sh title:"Decode Kubernetes secret value"
kubectl get secret "$secret_name" -n "$namespace" -o "jsonpath={.data.$secret_key}"
```
<!-- cheat
var secret_name
var namespace
var secret_key
-->

### Service account token

#sh #kubernetes #token

Read the mounted service account token from a pod.

```sh title:"Read mounted service account token"
cat /var/run/secrets/kubernetes.io/serviceaccount/token
```
<!-- cheat -->

### Service account namespace

#sh #kubernetes #token

Read the namespace of the mounted service account.

```sh title:"Read mounted service account namespace"
cat /var/run/secrets/kubernetes.io/serviceaccount/namespace
```
<!-- cheat -->

### Service account CA

#sh #kubernetes #token

Read the mounted cluster CA certificate.

```sh title:"Read mounted service account CA"
cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```
<!-- cheat -->
