---
tool: winPEAS
category: windows-tool
tags: windows tool winpeas recon privilege-escalation
---

# winPEAS

winPEAS automates Windows privilege escalation enumeration across services, registry, credentials, users, and security controls.

## Windows

### Full scan

#cmd #winpeas

Scan full scan with winPEAS.

#cmd #winpeas

Run the standard winPEAS scan.

```cmd title:"WinPEAS Scan Full Scan"
winPEASx64.exe
```
<!-- cheat -->

### Quiet scan

#cmd #winpeas

Scan quiet scan with winPEAS.

#cmd #winpeas

Run winPEAS with reduced banner and noise.

```cmd title:"WinPEAS Scan Quiet Scan"
winPEASx64.exe quiet
```
<!-- cheat -->

### Log output

#cmd #winpeas

Execute log output with winPEAS.

#cmd #winpeas

Write winPEAS output to a file.

```cmd title:"WinPEAS Execute Log Output"
winPEASx64.exe log="$output_file"
```
<!-- cheat
var output_file
-->
