# POP

## recon

### Nmap info

Show nmap info with POP.

Enumerate POP3 capabilities and NTLM info.

```sh title:"POP Show Nmap Info"
nmap -sV -p "$rport" --script "pop3-capabilities or pop3-ntlm-info" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 110
-->
