# Kubernetes

## config

### List contexts

List contexts with Kubernetes.

```sh title:"Kubernetes List Contexts"
kubectl config get-contexts
```
<!-- cheat -->

### Current context

Run current context with Kubernetes.

```sh title:"Kubernetes Run Current Context"
kubectl config current-context
```
<!-- cheat -->

### Switch context

Run switch context with Kubernetes.

```sh title:"Kubernetes Run Switch Context"
kubectl config use-context "$context"
```
<!-- cheat
var context
-->

### Explain resource

Show explain resource with Kubernetes.

```sh title:"Kubernetes Show Explain Resource"
kubectl explain "$resource"
```
<!-- cheat
var resource
-->

## discovery

### Nodes

Discover nodes with Kubernetes.

```sh title:"Kubernetes Discover Nodes"
kubectl get nodes
```
<!-- cheat -->

### Nodes wide

Discover nodes wide with Kubernetes.

```sh title:"Kubernetes Discover Nodes Wide"
kubectl get nodes -o wide
```
<!-- cheat -->

### Namespaces

Discover namespaces with Kubernetes.

```sh title:"Kubernetes Discover Namespaces"
kubectl get namespaces
```
<!-- cheat -->

### Pods in namespace

Discover pods in namespace with Kubernetes.

```sh title:"Kubernetes Discover Pods in Namespace"
kubectl get pods -n "$namespace"
```
<!-- cheat
var namespace
-->

### Pods all namespaces

Discover pods all namespaces with Kubernetes.

```sh title:"Kubernetes Discover Pods All Namespaces"
kubectl get pods --all-namespaces
```
<!-- cheat -->

### Services in namespace

Discover services in namespace with Kubernetes.

```sh title:"Kubernetes Discover Services in Namespace"
kubectl get services -n "$namespace"
```
<!-- cheat
var namespace
-->

### Deployments in namespace

Discover deployments in namespace with Kubernetes.

```sh title:"Kubernetes Discover Deployments in Namespace"
kubectl get deployments -n "$namespace"
```
<!-- cheat
var namespace
-->

### Describe resource

Discover describe resource with Kubernetes.

```sh title:"Kubernetes Discover Describe Resource"
kubectl describe "$resource/$name" -n "$namespace"
```
<!-- cheat
var resource
var name
var namespace
-->

## logs

### Follow pod logs

Run follow pod logs with Kubernetes.

```sh title:"Kubernetes Run Follow Pod Logs"
kubectl logs -f "pod/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Previous pod logs

Start previous pod logs with Kubernetes.

```sh title:"Kubernetes Start Previous Pod Logs"
kubectl logs "pod/$name" -n "$namespace" --previous
```
<!-- cheat
var name
var namespace
-->

## workload ops

### Edit deployment

Run edit deployment with Kubernetes.

```sh title:"Kubernetes Run Edit Deployment"
kubectl edit "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Restart deployment

Start restart deployment with Kubernetes.

```sh title:"Kubernetes Start Restart Deployment"
kubectl rollout restart "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

### Rollout status

Show rollout status with Kubernetes.

```sh title:"Kubernetes Show Rollout Status"
kubectl rollout status "deployment/$name" -n "$namespace"
```
<!-- cheat
var name
var namespace
-->

## node ops

### Cordon node

Run cordon node with Kubernetes.

```sh title:"Kubernetes Run Cordon Node"
kubectl cordon "$node_name"
```
<!-- cheat
var node_name
-->

### Drain node

Run drain node with Kubernetes.

```sh title:"Kubernetes Run Drain Node"
kubectl drain "$node_name" --ignore-daemonsets --delete-emptydir-data
```
<!-- cheat
var node_name
-->

### Uncordon node

Run uncordon node with Kubernetes.

```sh title:"Kubernetes Run Uncordon Node"
kubectl uncordon "$node_name"
```
<!-- cheat
var node_name
-->

## metrics

### Top nodes

Show top nodes with Kubernetes.

```sh title:"Kubernetes Show Top Nodes"
kubectl top nodes
```
<!-- cheat -->

### Top pods

Show top pods with Kubernetes.

```sh title:"Kubernetes Show Top Pods"
kubectl top pods -n "$namespace"
```
<!-- cheat
var namespace
-->
