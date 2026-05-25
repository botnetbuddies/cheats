# Kubernetes

## config

### List contexts

Show all kubeconfig contexts and highlight the current one.

```sh title:"Kubernetes List kubeconfig contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Current context

Print the active kubeconfig context.

```sh title:"Kubernetes Print current kubeconfig context"
kubectl config current-context
```
<!-- cheat -->

### Switch context

Set the active kubeconfig context.

```sh title:"Kubernetes Switch kubeconfig context"
kubectl config use-context "$context"
```
<!-- cheat
var context
-->

### Explain resource

Print Kubernetes API documentation for a resource type or field path.

```sh title:"Show Kubernetes resource documentation"
kubectl explain "$resource"
```
<!-- cheat
var resource
-->

## discovery

### Nodes

List cluster nodes.

```sh title:"Kubernetes List nodes"
kubectl get nodes
```
<!-- cheat -->

### Nodes wide

List cluster nodes with IPs, OS, kernel, runtime, and other useful detail.

```sh title:"Kubernetes List nodes with details"
kubectl get nodes -o wide
```
<!-- cheat -->

### Namespaces

List namespaces.

```sh title:"Kubernetes List namespaces"
kubectl get namespaces
```
<!-- cheat -->

### Pods in namespace

List pods in a namespace.

```sh title:"Kubernetes List pods in namespace"
kubectl get pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Pods all namespaces

List pods across all namespaces.

```sh title:"Kubernetes List pods in all namespaces"
kubectl get pods --all-namespaces
```
<!-- cheat -->

### Services in namespace

List services in a namespace.

```sh title:"Kubernetes List services in namespace"
kubectl get services -n "$namespace"
```
<!-- cheat
var namespace
-->

### Deployments in namespace

List deployments in a namespace.

```sh title:"Kubernetes List deployments in namespace"
kubectl get deployments -n "$namespace"
```
<!-- cheat
var namespace
-->

### Describe resource

Show details and events for a named resource in a namespace.

```sh title:"Kubernetes Describe resource in namespace"
kubectl describe "$resource/$name" -n "$namespace"
```
<!-- cheat
var resource
var name
var namespace
-->

## logs

### Follow pod logs

Follow logs from a pod in a namespace.

```sh title:"Kubernetes Follow pod logs"
kubectl logs -f "pod/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Previous pod logs

Print logs from the previous container instance after a restart.

```sh title:"Kubernetes Print previous pod logs after restart"
kubectl logs "pod/$name" -n "$namespace" --previous
```
<!-- cheat
var name
var namespace
-->

## workload ops

### Edit deployment

Open a deployment in your configured editor.

```sh title:"Kubernetes Edit deployment in namespace"
kubectl edit "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Restart deployment

Trigger a rolling restart of a deployment.

```sh title:"Kubernetes Rollout restart deployment"
kubectl rollout restart "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Rollout status

Watch deployment rollout status until it completes or fails.

```sh title:"Kubernetes Watch deployment rollout status"
kubectl rollout status "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

## node ops

### Cordon node

Mark a node as unschedulable.

```sh title:"Kubernetes Mark node unschedulable"
kubectl cordon "$node_name"
```
<!-- cheat
var node_name
-->

### Drain node

Drain a node for maintenance. This evicts workloads and may disrupt service if replicas are not healthy.

```sh title:"Kubernetes Drain node for maintenance"
kubectl drain "$node_name" --ignore-daemonsets --delete-emptydir-data
```
<!-- cheat
var node_name
-->

### Uncordon node

Mark a node as schedulable again.

```sh title:"Kubernetes Mark node schedulable"
kubectl uncordon "$node_name"
```
<!-- cheat
var node_name
-->

## metrics

### Top nodes

Show node CPU and memory usage. Requires metrics-server.

```sh title:"Kubernetes Show node CPU and memory usage"
kubectl top nodes
```
<!-- cheat -->

### Top pods

Show pod CPU and memory usage in a namespace. Requires metrics-server.

```sh title:"Kubernetes Show pod CPU and memory usage"
kubectl top pods -n "$namespace"
```
<!-- cheat
var namespace
-->
