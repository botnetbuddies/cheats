---
tool: DDexec
category: linux-tool
tags: linux tool ddexec noexec memfd defense-evasion
---

# DDexec

DDexec-style tooling executes a payload by hijacking an existing process, which can help when direct file execution is blocked.

## Linux

### Run payload

#sh #ddexec #noexec

Run a prepared payload through the DDexec helper.

```sh title:"Run DDexec payload"
bash "$ddexec_script" "$payload_name"
```
<!-- cheat
var ddexec_script
var payload_name
-->

### Run with seeker

#sh #ddexec #noexec

Run DDexec with a selected seeker helper.

```sh title:"Run DDexec with seeker"
SEEKER="$seeker" bash "$ddexec_script" "$payload_name"
```
<!-- cheat
var seeker
var ddexec_script
var payload_name
-->
