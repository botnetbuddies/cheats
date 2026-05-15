---
tool: ProcDump
category: windows-tool
tags: windows tool procdump lsass dump credentials
---

# ProcDump

ProcDump creates process dumps for later analysis, commonly including LSASS dumps during credential access workflows.

## Windows

### Dump process by PID

#cmd #procdump

Create a full dump for a process ID.

```cmd title:"Dump process by PID"
procdump.exe -accepteula -ma "$pid" "$dump_file"
```
<!-- cheat
var pid
var dump_file
-->

### Dump LSASS

#cmd #procdump #lsass

Create a full dump of LSASS.

```cmd title:"Dump LSASS with ProcDump"
procdump.exe -accepteula -ma lsass.exe "$dump_file"
```
<!-- cheat
var dump_file
-->

### Dump by process name

#cmd #procdump

Create a full dump for a named process.

```cmd title:"Dump process by name"
procdump.exe -accepteula -ma "$process_name" "$dump_file"
```
<!-- cheat
var process_name
var dump_file
-->
