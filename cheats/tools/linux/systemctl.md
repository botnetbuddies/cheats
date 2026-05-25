# Systemctl

## service state

### Status

Show status with Systemctl.

```sh title:"Systemctl Show Status"
systemctl status "$service_name"
```
<!-- cheat
var service_name
-->

### Start

Start start with Systemctl.

```sh title:"Systemctl Start Start"
systemctl start "$service_name"
```
<!-- cheat
var service_name
-->

### Stop

Run stop with Systemctl.

```sh title:"Systemctl Run Stop"
systemctl stop "$service_name"
```
<!-- cheat
var service_name
-->

### Restart

Start restart with Systemctl.

```sh title:"Systemctl Start Restart"
systemctl restart "$service_name"
```
<!-- cheat
var service_name
-->

### Reload

Run reload with Systemctl.

```sh title:"Systemctl Run Reload"
systemctl reload "$service_name"
```
<!-- cheat
var service_name
-->

## boot state

### Enable

Enable enable with Systemctl.

```sh title:"Systemctl Enable Enable"
systemctl enable "$service_name"
```
<!-- cheat
var service_name
-->

### Disable

Disable disable with Systemctl.

```sh title:"Systemctl Disable Disable"
systemctl disable "$service_name"
```
<!-- cheat
var service_name
-->

## list

### Running services

List running services with Systemctl.

```sh title:"Systemctl List Running Services"
systemctl list-units --type=service --state=running
```
<!-- cheat -->

### Enabled services

List enabled services with Systemctl.

```sh title:"Systemctl List Enabled Services"
systemctl list-unit-files --type=service --state=enabled
```
<!-- cheat -->

### Disabled services

List disabled services with Systemctl.

```sh title:"Systemctl List Disabled Services"
systemctl list-unit-files --type=service --state=disabled
```
<!-- cheat -->

### All services

List all services with Systemctl.

```sh title:"Systemctl List All Services"
systemctl list-units --type=service --all
```
<!-- cheat -->
