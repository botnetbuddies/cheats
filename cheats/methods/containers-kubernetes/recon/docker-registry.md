---
technique: Docker Registry Recon
category: recon
targets: Docker Registry
protocols: HTTP, HTTPS
remote_capable: true
tags: containers docker registry recon images
---

# Docker Registry Recon

Docker registry recon identifies exposed repositories, tags, manifests, and authentication requirements.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network path | Requires HTTP or HTTPS access to the registry |
| Registry API | Commands assume Docker Registry HTTP API v2 |
| Credentials | Authenticated registries require valid credentials or bearer token |

## Linux

### Registry API probe

#sh #curl #registry

Probe the v2 API root.

```sh title:"Probe Docker Registry v2 API"
curl -sk "$registry_url/v2/"
```
<!-- cheat
var registry_url
-->

### Repository catalog

#sh #curl #registry

List repositories when catalog access is allowed.

```sh title:"List registry repositories"
curl -sk "$registry_url/v2/_catalog"
```
<!-- cheat
var registry_url
-->

### Authenticated catalog

#sh #curl #registry

List repositories with basic authentication.

```sh title:"List registry repositories with basic auth"
curl -sk -u "$username:$password" "$registry_url/v2/_catalog"
```
<!-- cheat
var username
var registry_url
-->

### Repository tags

#sh #curl #registry

List tags for a repository.

```sh title:"List registry repository tags"
curl -sk "$registry_url/v2/$repository/tags/list"
```
<!-- cheat
var registry_url
var repository
-->

### Image manifest

#sh #curl #registry

Read an image manifest.

```sh title:"Read registry image manifest"
curl -sk "$registry_url/v2/$repository/manifests/$tag"
```
<!-- cheat
var registry_url
var repository
var tag
-->

### Pull image

#sh #docker #registry

Pull an image from a registry.

```sh title:"Pull image from registry"
docker pull "$registry_host/$repository:$tag"
```
<!-- cheat
var registry_host
var repository
var tag
-->
