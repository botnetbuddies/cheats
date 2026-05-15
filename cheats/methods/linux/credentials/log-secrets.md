---
technique: Linux Log Secret Hunting
category: credentials
targets: Linux Logs
protocols: Local
remote_capable: false
tags: linux credentials logs audit sudo su
---

# Linux Log Secret Hunting

Log secret hunting searches authentication, application, and audit logs for passwords, tokens, command arguments, and reused service credentials.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Log read access | Root or `adm` group often expands readable logs |
| Target log paths | Distribution and services determine useful log locations |

## Linux

### Auth log

#sh #logs #auth

Read Debian-family authentication logs.

```sh title:"Read auth log"
cat /var/log/auth.log
```
<!-- cheat -->

### Secure log

#sh #logs #auth

Read Red Hat-family authentication logs.

```sh title:"Read secure log"
cat /var/log/secure
```
<!-- cheat -->

### Audit TTY report

#sh #auditd #logs

Report TTY events recorded by auditd.

```sh title:"Report audit TTY events"
aureport --tty
```
<!-- cheat -->

### Search logs for passwords

#sh #logs #credentials

Search logs for common password strings.

```sh title:"Search logs for password strings"
grep -R -i -e password -e passwd -e token -e authorization /var/log 2>/dev/null
```
<!-- cheat -->

### Journal authentication events

#sh #journald #auth

Read recent SSH service journal entries.

```sh title:"Read SSH journal entries"
journalctl -u ssh --since "$since_time"
```
<!-- cheat
var since_time
-->

## Detection

Monitor broad reads and recursive searches across `/var/log`, audit reports, and journal queries by non-administrative accounts.
