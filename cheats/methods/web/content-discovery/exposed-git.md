---
technique: Exposed Git Discovery
category: content-discovery
targets: Web Applications
protocols: HTTP, HTTPS
remote_capable: true
tags: web git source-disclosure
---

# Exposed Git Discovery

Exposed `.git` directories can disclose source code, secrets, commit history, and deployment configuration.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| URL | Requires a target web root |
| Writable output | Dumping needs a destination directory |
| Review | Recovered repositories should be searched for secrets and config |

## Linux

### Git HEAD probe

#sh #curl #git

Check whether `.git/HEAD` is exposed.

```sh title:"Probe exposed git HEAD"
curl -sk "$url/.git/HEAD"
```
<!-- cheat
var url
-->

### gitdumper

#sh #gitdumper #git

Dump an exposed `.git` directory with gitdumper.

```sh title:"Dump exposed git with gitdumper"
gitdumper "$url/.git/" "$destination_dir"
```
<!-- cheat
var url
var destination_dir
-->

### git-dumper

#sh #git-dumper #git

Dump an exposed `.git` directory with git-dumper.

```sh title:"Dump exposed git with git-dumper"
git-dumper "$url/.git/" "$destination_dir"
```
<!-- cheat
var url
var destination_dir
-->
