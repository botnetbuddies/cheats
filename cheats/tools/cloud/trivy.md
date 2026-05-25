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

Scan image vulnerabilities with Trivy.

```sh title:"Trivy Scan Image Vulnerabilities"
trivy image "$image_name"
```
<!-- cheat
var image_name
-->

### Image secrets

#sh #trivy #secrets

Dump image secrets with Trivy.

```sh title:"Trivy Dump Image Secrets"
trivy image --scanners secret "$image_name"
```
<!-- cheat
var image_name
-->

### Filesystem scan

#sh #trivy #filesystem

Scan filesystem scan with Trivy.

```sh title:"Trivy Scan Filesystem Scan"
trivy fs "$target_path"
```
<!-- cheat
var target_path
-->

### Kubernetes scan

#sh #trivy #kubernetes

Scan kubernetes scan with Trivy.

```sh title:"Trivy Scan Kubernetes Scan"
trivy k8s --report summary cluster
```
<!-- cheat -->
