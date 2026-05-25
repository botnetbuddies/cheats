# SMTP

## recon

### Commands

Enumerate commands with SMTP.

```sh title:"SMTP Enumerate Commands"
nmap -p 25 --script smtp-commands "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### NTLM info

Check NTLM info with SMTP.

```sh title:"SMTP Check NTLM Info"
nmap -p 25 --script smtp-ntlm-info "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## user enum

### Nmap users

Enumerate nmap users with SMTP.

```sh title:"SMTP Enumerate Nmap Users"
nmap --script smtp-enum-users -p 25 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### smtp-user-enum

Enumerate smtp user enum with SMTP.

```sh title:"SMTP Enumerate Smtp User Enum"
smtp-user-enum -M VRFY -U "$wordlists_users" -t "$rhost_ip"
```
<!-- cheat
import wordlists_users
var rhost_ip
-->

### Metasploit enum

Enumerate metasploit enum with SMTP.

```sh title:"SMTP Enumerate Metasploit Enum"
msfconsole -x "use auxiliary/scanner/smtp/smtp_enum; set RHOSTS $rhost_ip; run; exit"
```
<!-- cheat
var rhost_ip
-->
