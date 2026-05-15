---
technique: Office Add-in Persistence
category: persistence
targets: Microsoft Office
protocols: Local
remote_capable: false
tags: windows persistence office addin template
---

# Office Add-in Persistence

Office add-in persistence uses trusted Office startup paths or add-in registry keys to load operator-controlled content when Office starts.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User profile write access | Current-user Office persistence writes under the profile or HKCU |
| Office installed | Target user must open the relevant Office application |
| Prepared add-in | Payload construction belongs in a tool or payload note |

## Windows

### Word startup folder

#cmd #office #startup

List the current user's Word startup folder.

```cmd title:"List Word startup folder"
dir "%APPDATA%\Microsoft\Word\STARTUP"
```
<!-- cheat -->

### Excel XLSTART folder

#cmd #office #startup

List the current user's Excel startup folder.

```cmd title:"List Excel XLSTART folder"
dir "%APPDATA%\Microsoft\Excel\XLSTART"
```
<!-- cheat -->

### Copy Word add-in

#cmd #office #persistence

Copy a prepared Word add-in to the Word startup folder.

```cmd title:"Copy Word add-in to startup"
copy "$addin_file" "%APPDATA%\Microsoft\Word\STARTUP\$file_name"
```
<!-- cheat
var addin_file
var file_name
-->

### Copy Excel add-in

#cmd #office #persistence

Copy a prepared Excel add-in to the XLSTART folder.

```cmd title:"Copy Excel add-in to XLSTART"
copy "$addin_file" "%APPDATA%\Microsoft\Excel\XLSTART\$file_name"
```
<!-- cheat
var addin_file
var file_name
-->

## Linux

No Linux operator command is included here. This note covers Windows Office add-in persistence.
