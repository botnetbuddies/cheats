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

Run nuclei against one target.

```sh title:"Run nuclei against target"
nuclei -u "$url"
```
<!-- cheat
var url
-->

### Target list

#sh #nuclei #web

Run nuclei against a list of targets.

```sh title:"Run nuclei against target list"
nuclei -l "$targets_file"
```
<!-- cheat
var targets_file
-->

### Template directory

#sh #nuclei #web

Run nuclei with a specific template directory.

```sh title:"Run nuclei template directory"
nuclei -u "$url" -t "$template_dir"
```
<!-- cheat
var url
var template_dir
-->

### Severity filter

#sh #nuclei #web

Run nuclei with a severity filter.

```sh title:"Run nuclei with severity filter"
nuclei -l "$targets_file" -severity "$severity"
```
<!-- cheat
var targets_file
var severity
-->
