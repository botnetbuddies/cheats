---
tool: Seatbelt
category: windows-tool
tags: windows tool seatbelt recon
---

# Seatbelt

Seatbelt performs targeted Windows situational awareness checks for users, processes, services, defensive controls, and credentials.

## Windows

### All checks

#cmd #seatbelt

Run all Seatbelt checks.

```cmd title:"Run all Seatbelt checks"
Seatbelt.exe all
```
<!-- cheat -->

### User checks

#cmd #seatbelt

Run user-focused Seatbelt checks.

```cmd title:"Run Seatbelt user checks"
Seatbelt.exe UserChecks
```
<!-- cheat -->

### Defensive checks

#cmd #seatbelt

Run defensive control checks.

```cmd title:"Run Seatbelt defensive checks"
Seatbelt.exe -group=system
```
<!-- cheat -->
