---
technique: FreeIPA Recon
category: recon
targets: FreeIPA
protocols: LDAP, Kerberos
remote_capable: true
tags: linux recon freeipa ldap kerberos ipa
---

# FreeIPA Recon

FreeIPA recon maps Kerberos, LDAP, host-based access control, sudo rules, users, groups, hosts, and role assignments in Linux identity domains.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Domain context | Host should be enrolled or able to reach FreeIPA services |
| Kerberos ticket | Authenticated LDAP and `ipa` commands usually require a valid ticket |
| IPA tools | `ipa`, `klist`, and `ldapsearch` improve coverage |

## Linux

### Kerberos config

#sh #kerberos #freeipa

Read Kerberos client configuration.

```sh title:"Read Kerberos config"
cat /etc/krb5.conf
```
<!-- cheat -->

### IPA defaults

#sh #freeipa #recon

Read FreeIPA client defaults.

```sh title:"Read IPA default config"
cat /etc/ipa/default.conf
```
<!-- cheat -->

### Ticket cache

#sh #kerberos #freeipa

List Kerberos tickets in the current cache.

```sh title:"List Kerberos tickets"
klist
```
<!-- cheat -->

### Host keytab

#sh #kerberos #keytab

List principals in the host keytab.

```sh title:"List host keytab principals"
klist -k /etc/krb5.keytab
```
<!-- cheat -->

### IPA users

#sh #freeipa #users

List FreeIPA users through the IPA client.

```sh title:"Find IPA users"
ipa user-find
```
<!-- cheat -->

### IPA groups

#sh #freeipa #groups

List FreeIPA user groups.

```sh title:"Find IPA user groups"
ipa usergroup-find
```
<!-- cheat -->

### IPA hosts

#sh #freeipa #hosts

List FreeIPA hosts.

```sh title:"Find IPA hosts"
ipa host-find
```
<!-- cheat -->

### IPA sudo rules

#sh #freeipa #sudo

List FreeIPA sudo rules.

```sh title:"Find IPA sudo rules"
ipa sudorule-find
```
<!-- cheat -->

### IPA HBAC rules

#sh #freeipa #hbac

List host-based access control rules.

```sh title:"Find IPA HBAC rules"
ipa hbacrule-find
```
<!-- cheat -->

## Detection

Monitor bursts of IPA client enumeration, Kerberos keytab reads, and LDAP queries against FreeIPA containers.
