# VNC

## recon

### Nmap enum

Enumerate nmap enum with VNC.

Enumerate VNC info, title, and RealVNC auth bypass.

```sh title:"VNC Enumerate Nmap Enum"
nmap -sV --script vnc-info,realvnc-auth-bypass,vnc-title -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### No-auth check

Check no auth check with VNC.

Check for VNC servers that allow no-auth access with Metasploit.

```sh title:"VNC Check No Auth Check"
msfconsole -x "use auxiliary/scanner/vnc/vnc_none_auth; set RHOSTS $rhost_ip; set RPORT $rport; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

## connect

### No password

Dump no password with VNC.

Connect to VNC without a password.

```sh title:"VNC Dump No Password"
vncviewer "$rhost_ip::$rport"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### Password file

Dump password file with VNC.

Connect to VNC using a password file.

```sh title:"VNC Dump Password File"
vncviewer -password "$password_file" "$rhost_ip::$rport"
```
<!-- cheat
var password_file
var rhost_ip
var rport := 5900
-->

## brute force

### Metasploit username

Check metasploit username with VNC.

Run Metasploit VNC login check with one username.

```sh title:"VNC Check Metasploit Username"
msfconsole -x "use auxiliary/scanner/vnc/vnc_login; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
var user
-->

### Metasploit wordlists

List metasploit wordlists with VNC.

Run Metasploit VNC login brute force with user and password files.

```sh title:"VNC List Metasploit Wordlists"
msfconsole -x "use auxiliary/scanner/vnc/vnc_login; set RHOSTS $rhost_ip; set RPORT $rport; set USER_FILE $wordlists_users; set PASS_FILE $wordlists; run; exit"
```
<!-- cheat
import wordlists_users
import wordlist_passwords
var rhost_ip
var rport := 5900
-->
