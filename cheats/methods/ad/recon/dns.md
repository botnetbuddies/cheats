---
technique: DNS Recon
category: recon
targets: Active Directory DNS
protocols: DNS, LDAP, SMB
remote_capable: true
tags: dns recon srv-records adidnsdump bloodyad netexec ad
---

# DNS Recon

Active Directory relies on DNS SRV records to locate domain controllers, Kerberos KDCs, LDAP services, and global catalog servers. AD-integrated DNS zones can also expose internal host records to any authenticated domain user.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain name | Needed for SRV queries and ADIDNS zone targeting |
| DNS server | Usually a domain controller or AD DNS server |
| Domain credentials | Needed for LDAP-based ADIDNS dumping |

## Windows

### Query all records

#cmd #dns

Query DNS records for the current domain from a Windows host.

```cmd title:"Query domain DNS records with nslookup"
nslookup -type=any %USERDNSDOMAIN%.
```
<!-- cheat -->

### Query domain controllers

#cmd #srv-records

Query domain controller SRV records.

```cmd title:"Query domain controller SRV records"
nslookup -type=srv _ldap._tcp.dc._msdcs.%USERDNSDOMAIN%
```
<!-- cheat -->

### Query Kerberos KDCs

#cmd #srv-records #kerberos

Query Kerberos KDC SRV records.

```cmd title:"Query Kerberos KDC SRV records"
nslookup -type=srv _kerberos._tcp.%USERDNSDOMAIN%
```
<!-- cheat -->

## Linux

### Query PDC SRV record

#dns #srv-records

Find the primary domain controller SRV record.

```sh title:"Query PDC SRV record"
nslookup -type=srv _ldap._tcp.pdc._msdcs."$domain"
```
<!-- cheat
import domain_ip
-->

### Query DC SRV records

#dns #srv-records

Find domain controller SRV records.

```sh title:"Query domain controller SRV records"
nslookup -type=srv _ldap._tcp.dc._msdcs."$domain"
```
<!-- cheat
import domain_ip
-->

### Query global catalog SRV records

#dns #srv-records

Find global catalog SRV records.

```sh title:"Query global catalog SRV records"
nslookup -type=srv gc._msdcs."$domain"
```
<!-- cheat
import domain_ip
-->

### Dump ADIDNS records

#adidnsdump #ldap #dns

Dump AD-integrated DNS records over LDAP and resolve entries.

```sh title:"Dump ADIDNS records with adidnsdump"
adidnsdump -u "$domain\\$user" -p "$pass" "ldap://$rhost_ip" -r
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### Dump ADIDNS records with bloodyAD

#bloodyad #ldap #dns

Dump AD-integrated DNS records using bloodyAD.

```sh title:"Dump ADIDNS records with bloodyAD"
bloodyAD --host "$rhost_ip" -d "$domain" -u "$user" $auth_flags get dnsDump
```
<!-- cheat
import domain_ip
import users
import bloody_auth
-->

### Dump DNS records with netexec

#netexec #dns #wmi

Dump Microsoft DNS records with the netexec enum_dns module when administrative access is available.

```sh title:"Dump DNS records with netexec enum_dns"
netexec smb "$rhost_ip" -u "$user" $auth_flags -d "$domain" -M enum_dns
```
<!-- cheat
import domain_ip
import users
import nxc_auth
-->
