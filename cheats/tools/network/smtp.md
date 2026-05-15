# SMTP

## recon

### Commands

Enumerate SMTP commands with nmap.

```sh title:"Enumerate SMTP commands"
nmap -p 25 --script smtp-commands "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### NTLM info

Check for SMTP NTLM information disclosure.

```sh title:"Check SMTP NTLM info"
nmap -p 25 --script smtp-ntlm-info "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## user enum

### Nmap users

Enumerate SMTP users with nmap.

```sh title:"Enumerate SMTP users with nmap"
nmap --script smtp-enum-users -p 25 "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### smtp-user-enum

Enumerate SMTP users with VRFY and a user list.

```sh title:"Enumerate SMTP users with VRFY"
smtp-user-enum -M VRFY -U "$user_file" -t "$rhost_ip"
```
<!-- cheat
var user_file
var rhost_ip
-->

### Metasploit enum

Enumerate SMTP users with Metasploit.

```sh title:"Enumerate SMTP users with Metasploit"
msfconsole -x "use auxiliary/scanner/smtp/smtp_enum; set RHOSTS $rhost_ip; run; exit"
```
<!-- cheat
var rhost_ip
-->
