# POP

## recon

### Nmap info

Enumerate POP3 capabilities and NTLM info.

```sh title:"Enumerate POP3 capabilities and NTLM info"
nmap -sV -p "$rport" --script "pop3-capabilities or pop3-ntlm-info" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 110
-->
