---
tool: kubectl
category: containers-kubernetes-tool
tags: kubernetes tool kubectl
---

# kubectl

kubectl is the standard Kubernetes client for cluster discovery, workload access, RBAC checks, logs, and operational changes.

## Linux

### Contexts

#sh #kubectl #context

List kubeconfig contexts.

```sh title:"kubectl List kubeconfig contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Describe resource

#sh #kubectl #describe

Describe a namespaced resource.

```sh title:"kubectl Describe Kubernetes resource"
kubectl describe "$resource/$name" -n "$namespace"
```
<!-- cheat
var resource
var name
var namespace
-->

### Follow logs

#sh #kubectl #logs

Follow logs from a pod.

```sh title:"kubectl Follow Kubernetes pod logs"
kubectl logs -f "pod/$pod_name" -n "$namespace"
```
<!-- cheat
var pod_name
var namespace
-->

### Explain resource

#sh #kubectl #docs

Show Kubernetes API documentation for a resource.

```sh title:"kubectl Explain Kubernetes resource"
kubectl explain "$resource"
```
<!-- cheat
var resource
-->
