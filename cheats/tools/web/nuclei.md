---
tool: Nuclei
category: tools
targets: Web Applications, Network Services
protocols: HTTP, TCP, UDP
remote_capable: true
tags: web nuclei scanner tools
---

# Nuclei

Nuclei runs template-based checks for exposed panels, misconfigurations, known vulnerabilities, and technology-specific issues.

## Linux

### Single target

#sh #nuclei #web

Scan single target with Nuclei.

```sh title:"Nuclei Scan Single Target"
nuclei -u "$url"
```
<!-- cheat
var url
-->

### Target list

#sh #nuclei #web

List target list with Nuclei.

```sh title:"Nuclei List Target List"
nuclei -l "$targets_file"
```
<!-- cheat
var targets_file
-->

### Template directory

#sh #nuclei #web

Scan template directory with Nuclei.

```sh title:"Nuclei Scan Template Directory"
nuclei -u "$url" -t "$template_dir"
```
<!-- cheat
var url
var template_dir
-->

### Severity filter

#sh #nuclei #web

Scan severity filter with Nuclei.

```sh title:"Nuclei Scan Severity Filter"
nuclei -l "$targets_file" -severity "$severity"
```
<!-- cheat
var targets_file
var severity
-->
