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

List contexts with kubectl.

```sh title:"Kubectl List Contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Describe resource

#sh #kubectl #describe

Run describe resource with kubectl.

```sh title:"Kubectl Run Describe Resource"
kubectl describe "$resource/$name" -n "$namespace"
```
<!-- cheat
var resource
var name
var namespace
-->

### Follow logs

#sh #kubectl #logs

Run follow logs with kubectl.

```sh title:"Kubectl Run Follow Logs"
kubectl logs -f "pod/$pod_name" -n "$namespace"
```
<!-- cheat
var pod_name
var namespace
-->

### Explain resource

#sh #kubectl #docs

Run explain resource with kubectl.

```sh title:"Kubectl Run Explain Resource"
kubectl explain "$resource"
```
<!-- cheat
var resource
-->
