---
technique: Kubernetes Port Forwarding
category: lateral-movement
targets: Kubernetes Pods, Kubernetes Services
protocols: Kubernetes API, TCP
remote_capable: true
tags: kubernetes lateral-movement port-forward services
---

# Kubernetes Port Forwarding

Kubernetes port forwarding exposes pod or service ports through the API server to reach internal services from the operator host.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Port-forward rights | Current identity must create port-forward sessions |
| Target workload | Pod or service must expose a useful port |
| API reachability | Operator must reach the Kubernetes API server |

## Linux

### Check port-forward rights

#sh #kubectl #rbac

Check whether the current identity can create pod port-forward sessions.

```sh title:"Check pod port-forward rights"
kubectl auth can-i create pods/portforward -n "$namespace"
```
<!-- cheat
var namespace
-->

### Pod port forward

#sh #kubectl #port-forward

Forward a local port to a pod port.

```sh title:"Forward local port to pod"
kubectl port-forward "pod/$pod_name" "$lport:$rport" -n "$namespace"
```
<!-- cheat
var pod_name
var lport
var rport
var namespace
-->

### Service port forward

#sh #kubectl #port-forward

Forward a local port to a service port.

```sh title:"Forward local port to service"
kubectl port-forward "service/$service_name" "$lport:$rport" -n "$namespace"
```
<!-- cheat
var service_name
var lport
var rport
var namespace
-->
