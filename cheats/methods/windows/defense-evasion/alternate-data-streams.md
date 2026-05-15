---
technique: Alternate Data Streams
category: defense-evasion
targets: NTFS
protocols: Local
remote_capable: false
tags: windows defense-evasion ads ntfs streams
---

# Alternate Data Streams

Alternate data streams store payloads or data inside NTFS stream names attached to a visible file.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| NTFS volume | ADS requires NTFS |
| Writable file | Operator must write to the host file or path |
| Execution method | Stream execution depends on a compatible interpreter or loader |

## Windows

### List streams

#cmd #ads

List alternate data streams on a file.

```cmd title:"List alternate data streams"
dir /r "$target_file"
```
<!-- cheat
var target_file
-->

### Write stream

#cmd #ads

Write text into an alternate data stream.

```cmd title:"Write alternate data stream"
echo $content > "$target_file:$stream_name"
```
<!-- cheat
var content
var target_file
var stream_name
-->

### Read stream

#cmd #ads

Read an alternate data stream.

```cmd title:"Read alternate data stream"
more < "$target_file:$stream_name"
```
<!-- cheat
var target_file
var stream_name
-->

### Execute script stream

#cmd #ads

Run a script stored in an alternate data stream with wscript.

```cmd title:"Run script from alternate data stream"
wscript.exe "$target_file:$stream_name"
```
<!-- cheat
var target_file
var stream_name
-->

## Linux

No Linux operator command is included here. This note covers NTFS alternate data streams.
