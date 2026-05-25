# FTP

## connect

### Connect

Run connect with FTP.

```sh title:"FTP Run Connect"
ftp "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Connect port

Run connect port with FTP.

```sh title:"FTP Run Connect Port"
ftp "$rhost_ip" "$rport"
```
<!-- cheat
var rhost_ip
var rport := 21
-->

## download

### Mirror anonymous

Download mirror anonymous with FTP.

```sh title:"FTP Download Mirror Anonymous"
wget -m "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

### Mirror anonymous active mode

Download mirror anonymous active mode with FTP.

```sh title:"FTP Download Mirror Anonymous Active Mode"
wget -m --no-passive "ftp://anonymous:anonymous@$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## recon

### Anonymous access

Check anonymous access with FTP.

```sh title:"FTP Check Anonymous Access"
nmap -v -p 21 --script ftp-anon "$rhost_ip"
```
<!-- cheat
var rhost_ip
-->

## brute force

### Metasploit login

Execute metasploit login with FTP.

```sh title:"FTP Execute Metasploit Login"
msfconsole -x "use auxiliary/scanner/ftp/ftp_login; set RHOSTS $rhost_ip; set USER_FILE $wordlists_users; set PASS_FILE $wordlists; run; exit"
```
<!-- cheat
import wordlists_users
import wordlist_passwords
var rhost_ip
-->
