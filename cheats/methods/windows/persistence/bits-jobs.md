---
technique: BITS Jobs
category: persistence
targets: Windows BITS
protocols: HTTP, HTTPS, BITS
remote_capable: false
tags: windows persistence bits bitsadmin file-transfer
---

# BITS Jobs

BITS jobs can download files in the background and survive transient network failures. Operators use them for payload staging and defenders often monitor the BITS Client operational log.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| BITS service | Background Intelligent Transfer Service must be available |
| Network access | The target must reach the source URL |
| Destination path | The current context must be able to write the output path |

## Windows

### Transfer file

#cmd #bitsadmin #download

Download a file with a foreground BITS transfer.

```cmd title:"Download file with bitsadmin transfer"
bitsadmin /transfer "$job_name" /download /priority high "$url" "$outfile"
```
<!-- cheat
var job_name
var url
var outfile
-->

### Create BITS job

#cmd #bitsadmin

Create a named BITS job for staged setup.

```cmd title:"Create BITS job"
bitsadmin /create "$job_name"
```
<!-- cheat
var job_name
-->

### Add file to BITS job

#cmd #bitsadmin

Add a remote file and local output path to a BITS job.

```cmd title:"Add file to BITS job"
bitsadmin /addfile "$job_name" "$url" "$outfile"
```
<!-- cheat
var job_name
var url
var outfile
-->

### Resume BITS job

#cmd #bitsadmin

Start or resume a queued BITS job.

```cmd title:"Resume BITS job"
bitsadmin /resume "$job_name"
```
<!-- cheat
var job_name
-->

### Complete BITS job

#cmd #bitsadmin

Finalize a transferred BITS job and commit the output file.

```cmd title:"Complete BITS job"
bitsadmin /complete "$job_name"
```
<!-- cheat
var job_name
-->

### List BITS jobs

#cmd #bitsadmin

List BITS jobs visible to the current user.

```cmd title:"List BITS jobs"
bitsadmin /list /verbose
```
<!-- cheat -->

### Cancel BITS job

#cmd #bitsadmin #cleanup

Cancel a named BITS job.

```cmd title:"Cancel BITS job"
bitsadmin /cancel "$job_name"
```
<!-- cheat
var job_name
-->

### PowerShell BITS transfer

#powershell #bits #download

Download a file with the PowerShell BITS cmdlet.

```powershell title:"Download file with Start-BitsTransfer"
Start-BitsTransfer -Source "$url" -Destination "$outfile"
```
<!-- cheat
var url
var outfile
-->

### PowerShell async BITS transfer

#powershell #bits #download

Start an asynchronous BITS download.

```powershell title:"Start asynchronous BITS download"
Start-BitsTransfer -Source "$url" -Destination "$outfile" -Asynchronous
```
<!-- cheat
var url
var outfile
-->

## Linux

No Linux operator command is included here. This note covers Windows-local BITS usage.

## Detection

Monitor bitsadmin.exe command lines and the Microsoft-Windows-Bits-Client Operational log.
