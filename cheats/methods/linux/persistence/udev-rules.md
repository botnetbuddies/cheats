---
technique: udev Rule Persistence
category: persistence
targets: Linux udev
protocols: Local
remote_capable: false
tags: linux persistence udev device-rules
---

# udev Rule Persistence

udev persistence installs rules that run commands when matching device events occur.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Root access | Required to write udev rules |
| Triggerable event | A matching device add, change, or remove event must occur |
| Prepared command | Payload logic should live in a staged script or tool note |

## Linux

### List udev rules

#sh #udev #recon

List system udev rule files.

```sh title:"List udev rules"
ls -la /etc/udev/rules.d /lib/udev/rules.d
```
<!-- cheat -->

### Monitor udev events

#sh #udev #recon

Monitor udev events while triggering devices.

```sh title:"Monitor udev events"
udevadm monitor
```
<!-- cheat -->

### Step 1: Install udev rule

#sh #udev #persistence

Copy a prepared udev rule into the rules directory.

```sh title:"Install udev rule"
cp "$rule_file" "/etc/udev/rules.d/$rule_name.rules"
```
<!-- cheat
var rule_file
var rule_name
-->

### Step 2: Reload udev rules

#sh #udev #persistence

Reload udev rules after installing a rule file.

```sh title:"Reload udev rules"
udevadm control --reload-rules
```
<!-- cheat -->

### Step 3: Trigger udev rules

#sh #udev #persistence

Trigger udev rule processing for existing devices.

```sh title:"Trigger udev rules"
udevadm trigger
```
<!-- cheat -->

## Detection

Monitor writes under `/etc/udev/rules.d`, udev reloads, and rule actions that execute scripts from unusual paths.
