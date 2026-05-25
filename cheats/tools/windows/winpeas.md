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

Run the standard winPEAS scan.

```cmd title:"Run winPEAS scan"
winPEASx64.exe
```
<!-- cheat -->

### Quiet scan

#cmd #winpeas

Run winPEAS with reduced banner and noise.

```cmd title:"Run winPEAS quiet scan"
winPEASx64.exe quiet
```
<!-- cheat -->

### Log output

#cmd #winpeas

Write winPEAS output to a file.

```cmd title:"Run winPEAS and write output"
winPEASx64.exe log="$output_file"
```
<!-- cheat
var output_file
-->
