---
tool: Grype and Syft
category: tools
targets: Container Images, Filesystems
protocols: Local Scan
remote_capable: false
tags: containers images sbom vulnerabilities tools
---

# Grype and Syft

Syft generates software bills of materials, and Grype scans images or filesystems for known vulnerabilities.

## Linux

### Image SBOM

#sh #syft #sbom

Generate image SBOM with Grype and Syft.

#sh #syft #sbom

Generate an SBOM for an image.

```sh title:"Grype and Syft Generate Image SBOM"
syft "$image_name"
```
<!-- cheat
var image_name
-->

### Image vulnerability scan

#sh #grype #vulnerabilities

Scan image vulnerability scan with Grype and Syft.

#sh #grype #vulnerabilities

Scan an image for vulnerabilities.

```sh title:"Grype and Syft Scan Image Vulnerability Scan"
grype "$image_name"
```
<!-- cheat
var image_name
-->

### Filesystem SBOM

#sh #syft #filesystem

Generate filesystem SBOM with Grype and Syft.

#sh #syft #filesystem

Generate an SBOM for a filesystem path.

```sh title:"Grype and Syft Generate Filesystem SBOM"
syft "dir:$target_path"
```
<!-- cheat
var target_path
-->

### Filesystem vulnerability scan

#sh #grype #filesystem

Scan filesystem vulnerability scan with Grype and Syft.

#sh #grype #filesystem

Scan a filesystem path for vulnerabilities.

```sh title:"Grype and Syft Scan Filesystem Vulnerability Scan"
grype "dir:$target_path"
```
<!-- cheat
var target_path
-->
