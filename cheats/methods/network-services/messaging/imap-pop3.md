---
technique: IMAP and POP3 Enumeration
category: messaging
targets: IMAP, POP3
protocols: IMAP, POP3
remote_capable: true
tags: network-services imap pop3 mail
---

# IMAP and POP3 Enumeration

IMAP and POP3 enumeration checks mail service capabilities, TLS support, NTLM disclosure, and mailbox access with valid credentials.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Mail ports | Common ports are 110, 143, 993, and 995 |
| Credentials | Mailbox access requires valid credentials |
| TLS mode | STARTTLS and implicit TLS differ by port |

## Linux

### POP3 capabilities

#sh #nmap #pop3

Enumerate POP3 capabilities and NTLM info.

```sh title:"Enumerate POP3 capabilities"
nmap -sV -p "$rport" --script "pop3-capabilities or pop3-ntlm-info" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 110
-->

### IMAP capabilities

#sh #nmap #imap

Enumerate IMAP capabilities and NTLM info.

```sh title:"Enumerate IMAP capabilities"
nmap -sV -p "$rport" --script "imap-capabilities or imap-ntlm-info" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 143
-->

### IMAPS connect

#sh #openssl #imap

Connect to IMAP over TLS.

```sh title:"Connect to IMAPS with OpenSSL"
openssl s_client -connect "$rhost_ip:$rport"
```
<!-- cheat
var rhost_ip
var rport := 993
-->

### POP3S connect

#sh #openssl #pop3

Connect to POP3 over TLS.

```sh title:"Connect to POP3S with OpenSSL"
openssl s_client -connect "$rhost_ip:$rport"
```
<!-- cheat
var rhost_ip
var rport := 995
-->
