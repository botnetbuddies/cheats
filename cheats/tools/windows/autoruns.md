---
tool: Autoruns
category: windows-tool
tags: windows tool autoruns persistence sysinternals
---

# Autoruns

Autoruns enumerates Windows autostart extension points across registry, services, scheduled tasks, drivers, Office, and shell locations.

## Windows

### Accept EULA and scan

#cmd #autoruns

Scan accept EULA and scan with Autoruns.

```cmd title:"Autoruns Scan Accept EULA and Scan"
autorunsc.exe -accepteula
```
<!-- cheat -->

### CSV output

#cmd #autoruns

Execute CSV output with Autoruns.

```cmd title:"Autoruns Execute CSV Output"
autorunsc.exe -accepteula -a * -c > "$output_file"
```
<!-- cheat
var output_file
-->

### Verify signatures

#cmd #autoruns

Read verify signatures with Autoruns.

```cmd title:"Autoruns Read Verify Signatures"
autorunsc.exe -accepteula -v
```
<!-- cheat -->
