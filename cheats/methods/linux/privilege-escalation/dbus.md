---
technique: D-Bus Abuse
category: privilege-escalation
targets: Linux D-Bus
protocols: D-Bus
remote_capable: false
tags: linux privilege-escalation dbus ipc polkit
---

# D-Bus Abuse

D-Bus abuse targets permissive bus policies and privileged services that expose methods callable by low-privileged users.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Local shell | D-Bus is usually local IPC |
| Callable service | Current user must send to a useful bus name or interface |
| Useful method | Target method must cause file writes, command execution, or privileged state changes |

## Linux

### List system bus names

#sh #dbus #recon

List names on the system bus.

```sh title:"List system D-Bus names"
busctl list --system
```
<!-- cheat -->

### List user bus names

#sh #dbus #recon

List names on the user bus.

```sh title:"List user D-Bus names"
busctl list --user
```
<!-- cheat -->

### Service tree

#sh #dbus #recon

Show object paths exposed by a D-Bus service.

```sh title:"Show D-Bus service tree"
busctl tree "$service_name"
```
<!-- cheat
var service_name
-->

### Introspect object

#sh #dbus #recon

Print methods and properties exposed by an object path.

```sh title:"Introspect D-Bus object"
busctl introspect "$service_name" "$object_path"
```
<!-- cheat
var service_name
var object_path
-->

### Call method

#sh #dbus

Call a D-Bus method with prepared arguments.

```sh title:"Call D-Bus method"
busctl call "$service_name" "$object_path" "$interface_name" "$method_name" "$signature" "$method_args"
```
<!-- cheat
var service_name
var object_path
var interface_name
var method_name
var signature
var method_args
-->

### Review system policies

#sh #dbus #recon

Search D-Bus system policies for broad allow rules.

```sh title:"Search D-Bus system policies"
grep -R "<allow" /etc/dbus-1/system.d 2>/dev/null
```
<!-- cheat -->

## Detection

Monitor unusual method calls to privileged services, D-Bus policy changes, and low-privileged users sending to administrative interfaces.
