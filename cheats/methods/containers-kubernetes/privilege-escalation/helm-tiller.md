---
technique: Helm Tiller Abuse
category: privilege-escalation
targets: Kubernetes, Helm 2 Tiller
protocols: Kubernetes API, TCP 44134
remote_capable: true
tags: kubernetes helm tiller privilege-escalation
---

# Helm Tiller Abuse

Helm 2 Tiller often ran in `kube-system` with broad cluster permissions. Exposed Tiller access can allow chart installation with Tiller's service account rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Legacy Helm | Applies to Helm 2 deployments with Tiller |
| Network path | Requires Kubernetes API access or direct access to TCP 44134 |
| Helm client | Commands assume Helm 2 compatible client syntax |

## Linux

### Tiller pods

#sh #kubectl #helm

Find Tiller pods across namespaces.

```sh title:"List Tiller pods"
kubectl get pods --all-namespaces -l app=helm
```
<!-- cheat -->

### Tiller services

#sh #kubectl #helm

Find Tiller services across namespaces.

```sh title:"List Tiller services"
kubectl get services --all-namespaces -l app=helm
```
<!-- cheat -->

### kube-system Tiller

#sh #kubectl #helm

Check the default Tiller deployment location.

```sh title:"List kube-system Tiller resources"
kubectl get pods,services -n kube-system -l app=helm
```
<!-- cheat -->

### Tiller version

#sh #helm #tiller

Query a reachable Tiller endpoint.

```sh title:"Query Tiller version"
helm --host "$tiller_host:44134" version
```
<!-- cheat
var tiller_host
-->

### Tiller releases

#sh #helm #tiller

List releases visible through Tiller.

```sh title:"List Tiller releases"
helm --host "$tiller_host:44134" list --all
```
<!-- cheat
var tiller_host
-->

### Tiller service account

#sh #kubectl #helm

Inspect the service account used by Tiller.

```sh title:"Describe Tiller deployment"
kubectl describe deployment tiller-deploy -n kube-system
```
<!-- cheat -->
