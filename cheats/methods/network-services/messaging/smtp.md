---
technique: SMTP Enumeration
category: messaging
targets: SMTP
protocols: SMTP
remote_capable: true
tags: network-services smtp mail user-enumeration
---

# SMTP Enumeration

SMTP enumeration checks supported commands, relay posture, NTLM information disclosure, and user enumeration verbs.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 25 | Also check 465 and 587 where relevant |
| Mail domain | Relay and recipient checks need authorized test addresses |
| Tooling | Commands use nmap and smtp-user-enum |

## Linux

### SMTP commands

#sh #nmap #smtp

Enumerate supported SMTP commands.

```sh title:"Enumerate SMTP commands"
nmap -p 25 --script smtp-commands "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### NTLM info

#sh #nmap #smtp

Check for SMTP NTLM information disclosure.

```sh title:"Check SMTP NTLM info"
nmap -p 25 --script smtp-ntlm-info "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### User enum NSE

#sh #nmap #smtp

Enumerate SMTP users with nmap.

```sh title:"Enumerate SMTP users with nmap"
nmap --script smtp-enum-users -p 25 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### User enum VRFY

#sh #smtp-user-enum #smtp

Enumerate SMTP users with VRFY.

```sh title:"Enumerate SMTP users with VRFY"
smtp-user-enum -M VRFY -U "$user_file" -t "$rhost_ip"
```
<!-- cheat
var user_file
var rhost_ip
-->
