---
technique: etcd Access
category: privilege-escalation
targets: Kubernetes, etcd
protocols: etcd API
remote_capable: true
tags: kubernetes etcd credentials privilege-escalation
---

# etcd Access

etcd access can expose Kubernetes objects, secrets, service account tokens, and cluster state outside normal Kubernetes API authorization.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network path | Requires access to the etcd listener or local node filesystem |
| TLS material | Most clusters require client certificate, key, and CA paths |
| etcdctl | Commands assume etcdctl is available |

## Linux

### etcd pods

#sh #kubectl #etcd

Find etcd pods in the control-plane namespace.

```sh title:"List etcd pods"
kubectl get pods -n kube-system -l component=etcd -o wide
```
<!-- cheat -->

### etcd service

#sh #kubectl #etcd

Find exposed etcd services.

```sh title:"List etcd services"
kubectl get services --all-namespaces -l component=etcd
```
<!-- cheat -->

### Static pod manifest

#sh #etcd #kubernetes

Read the local static pod manifest on a control-plane node.

```sh title:"Read etcd static pod manifest"
cat /etc/kubernetes/manifests/etcd.yaml
```
<!-- cheat -->

### etcd member list

#sh #etcdctl #etcd

List etcd members with client TLS material.

```sh title:"List etcd members"
etcdctl --endpoints "https://$etcd_host:2379" --cacert "$ca_file" --cert "$cert_file" --key "$key_file" member list
```
<!-- cheat
var etcd_host
var ca_file
var cert_file
var key_file
-->

### Kubernetes keys

#sh #etcdctl #kubernetes

List Kubernetes keys stored in etcd.

```sh title:"List Kubernetes keys in etcd"
etcdctl --endpoints "https://$etcd_host:2379" --cacert "$ca_file" --cert "$cert_file" --key "$key_file" get /registry --prefix --keys-only
```
<!-- cheat
var etcd_host
var ca_file
var cert_file
var key_file
-->

### Kubernetes secrets keys

#sh #etcdctl #kubernetes #secrets

List secret object keys stored in etcd.

```sh title:"List Kubernetes secret keys in etcd"
etcdctl --endpoints "https://$etcd_host:2379" --cacert "$ca_file" --cert "$cert_file" --key "$key_file" get /registry/secrets --prefix --keys-only
```
<!-- cheat
var etcd_host
var ca_file
var cert_file
var key_file
-->
