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

Run Autoruns and accept the EULA.

```cmd title:"Run Autoruns scan"
autorunsc.exe -accepteula
```
<!-- cheat -->

### CSV output

#cmd #autoruns

Write Autoruns output to CSV.

```cmd title:"Write Autoruns CSV output"
autorunsc.exe -accepteula -a * -c > "$output_file"
```
<!-- cheat
var output_file
-->

### Verify signatures

#cmd #autoruns

Run Autoruns with signature verification.

```cmd title:"Run Autoruns with signature verification"
autorunsc.exe -accepteula -v
```
<!-- cheat -->
