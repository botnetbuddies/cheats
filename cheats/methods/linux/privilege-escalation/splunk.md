---
technique: Splunk Abuse
category: privilege-escalation
targets: Splunk
protocols: HTTP, Local
remote_capable: true
tags: linux privilege-escalation splunk forwarder persistence
---

# Splunk Abuse

Splunk abuse targets local Splunk services, forwarder management, and app deployment features that execute scripts as the Splunk service user.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Splunk access | Local filesystem access or valid Splunk credentials |
| Execution path | Splunk app, scripted input, or forwarder management must run code |
| Service context | Impact depends on the Splunk service user |

## Linux

### Splunk processes

#sh #splunk #recon

List Splunk processes.

```sh title:"List Splunk processes"
pgrep -af splunk
```
<!-- cheat -->

### Splunk ports

#sh #splunk #network

List listening Splunk service ports.

```sh title:"List Splunk listening ports"
ss -lntp
```
<!-- cheat -->

### Splunk directory

#sh #splunk #filesystem

List the common Splunk installation directory.

```sh title:"List Splunk directory"
ls -la /opt/splunk
```
<!-- cheat -->

### Forwarder directory

#sh #splunk #filesystem

List the common Splunk forwarder installation directory.

```sh title:"List Splunk forwarder directory"
ls -la /opt/splunkforwarder
```
<!-- cheat -->

### Local users file

#sh #splunk #credentials

Read local Splunk user hashes when filesystem access permits.

```sh title:"Read Splunk passwd file"
cat "$splunk_home/etc/passwd"
```
<!-- cheat
var splunk_home
-->

### App directories

#sh #splunk #filesystem

List Splunk app directories.

```sh title:"List Splunk apps"
ls -la "$splunk_home/etc/apps"
```
<!-- cheat
var splunk_home
-->

### REST server info

#sh #splunk #http

Query Splunk management API server info with credentials.

```sh title:"Query Splunk server info"
curl -k -u "$user:$pass" "https://$rhost:$rport/services/server/info"
```
<!-- cheat
var user
var pass
var rhost
var rport
-->

## Detection

Monitor Splunk app changes, scripted input creation, management API logins, and deployment activity from unusual accounts.
