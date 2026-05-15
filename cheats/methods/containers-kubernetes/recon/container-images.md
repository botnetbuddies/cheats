---
technique: Container Image Recon
category: recon
targets: Container Images
protocols: Docker API, Registry
remote_capable: false
tags: containers recon images docker registry secrets
---

# Container Image Recon

Container image recon inspects local images, image history, labels, and environment variables for secrets and deployment context.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Runtime access | Docker, Podman, or containerd access is required |
| Image visibility | Target images must be local or pullable |

## Linux

### Docker images

#sh #docker #images

List local Docker images.

```sh title:"List Docker images"
docker images
```
<!-- cheat -->

### Image history

#sh #docker #images

Print image layer history.

```sh title:"Print Docker image history"
docker history "$image_name"
```
<!-- cheat
var image_name
-->

### Image inspect

#sh #docker #images

Inspect image configuration and metadata.

```sh title:"Inspect Docker image"
docker inspect "$image_name"
```
<!-- cheat
var image_name
-->

### Save image

#sh #docker #images

Save an image to a tar archive for offline review.

```sh title:"Save Docker image to archive"
docker save -o "$archive_file" "$image_name"
```
<!-- cheat
var archive_file
var image_name
-->

### containerd images

#sh #containerd #images

List containerd images.

```sh title:"List containerd images"
ctr images list
```
<!-- cheat -->
