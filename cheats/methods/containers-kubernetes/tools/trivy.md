---
tool: Trivy
category: tools
targets: Container Images, Filesystems, Kubernetes
protocols: Local Scan, Kubernetes API
remote_capable: true
tags: containers kubernetes trivy vulnerability secrets tools
---

# Trivy

Trivy scans container images, filesystems, repositories, and Kubernetes resources for vulnerabilities, secrets, and misconfigurations.

## Linux

### Image vulnerabilities

#sh #trivy #images

Scan an image for vulnerabilities.

```sh title:"Scan image for vulnerabilities"
trivy image "$image_name"
```
<!-- cheat
var image_name
-->

### Image secrets

#sh #trivy #secrets

Scan an image for secrets.

```sh title:"Scan image for secrets"
trivy image --scanners secret "$image_name"
```
<!-- cheat
var image_name
-->

### Filesystem scan

#sh #trivy #filesystem

Scan a filesystem path.

```sh title:"Scan filesystem path"
trivy fs "$target_path"
```
<!-- cheat
var target_path
-->

### Kubernetes scan

#sh #trivy #kubernetes

Scan visible Kubernetes resources.

```sh title:"Scan Kubernetes cluster"
trivy k8s --report summary cluster
```
<!-- cheat -->
