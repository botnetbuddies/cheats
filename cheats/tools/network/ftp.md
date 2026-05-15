# FTP

## connect

### Connect

Connect to FTP on the default port.

```sh title:"Connect to FTP"
ftp "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Connect port

Connect to FTP on a custom port.

```sh title:"Connect to FTP on custom port"
ftp "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 21
-->

## download

### Mirror anonymous

Mirror an anonymous FTP server.

```sh title:"Mirror anonymous FTP server"
wget -m "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mirror anonymous active mode

Mirror an anonymous FTP server without passive mode.

```sh title:"Mirror anonymous FTP server without passive mode"
wget -m --no-passive "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## recon

### Anonymous access

Check for anonymous FTP access with nmap.

```sh title:"Check anonymous FTP access"
nmap -v -p 21 --script ftp-anon "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## brute force

### Metasploit login

Run Metasploit FTP login brute force with wordlists.

```sh title:"Run FTP login brute force with Metasploit"
msfconsole -x "use auxiliary/scanner/ftp/ftp_login; set RHOSTS $rhost_ip; set USER_FILE $wordlists_users; set PASS_FILE $wordlists; run; exit"
```
<!-- cheat
import wordlists_users
import wordlist_passwords
var rhost_ip
-->
