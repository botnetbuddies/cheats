---
technique: MQTT Enumeration
category: messaging
targets: MQTT
protocols: MQTT
remote_capable: true
tags: network-services mqtt iot messaging
---

# MQTT Enumeration

MQTT enumeration checks broker metadata, anonymous access, topic visibility, and publish permissions.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| TCP 1883 | TLS brokers often use 8883 |
| Client ID | Some brokers require unique client IDs |
| Scope | Topic subscriptions may expose sensitive telemetry |

## Linux

### Service detection

#sh #nmap #mqtt

Run MQTT service detection.

```sh title:"Run MQTT service detection"
nmap -sV -p "$rport" --script mqtt-subscribe "$rhost_ip"
```
<!-- cheat
var rhost_ip
var rport := 1883
-->

### Subscribe wildcard

#sh #mqtt

Subscribe to all visible topics.

```sh title:"Subscribe to MQTT wildcard"
mosquitto_sub -h "$rhost_ip" -p "$rport" -t "#"
```
<!-- cheat
var rhost_ip
var rport := 1883
-->

### Authenticated subscribe

#sh #mqtt

Subscribe with username and password.

```sh title:"Subscribe to MQTT with credentials"
mosquitto_sub -h "$rhost_ip" -p "$rport" -u "$user" -P "$pass" -t "$topic"
```
<!-- cheat
var rhost_ip
var rport := 1883
var user
var pass
var topic
-->

### Publish test

#sh #mqtt

Publish a test message to an authorized topic.

```sh title:"Publish MQTT test message"
mosquitto_pub -h "$rhost_ip" -p "$rport" -t "$topic" -m "$message"
```
<!-- cheat
var rhost_ip
var rport := 1883
var topic
var message
-->
