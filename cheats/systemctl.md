# Systemctl

## service state

### Status

Show systemd unit status.

```sh title:"Show systemd service status"
systemctl status "$service_name"
```
<!-- cheat
var service_name
-->

### Start

Start a systemd service.

```sh title:"Start systemd service"
systemctl start "$service_name"
```
<!-- cheat
var service_name
-->

### Stop

Stop a systemd service.

```sh title:"Stop systemd service"
systemctl stop "$service_name"
```
<!-- cheat
var service_name
-->

### Restart

Restart a systemd service.

```sh title:"Restart systemd service"
systemctl restart "$service_name"
```
<!-- cheat
var service_name
-->

### Reload

Reload a systemd service without a full restart.

```sh title:"Reload systemd service"
systemctl reload "$service_name"
```
<!-- cheat
var service_name
-->

## boot state

### Enable

Enable a systemd service at boot.

```sh title:"Enable systemd service at boot"
systemctl enable "$service_name"
```
<!-- cheat
var service_name
-->

### Disable

Disable a systemd service at boot.

```sh title:"Disable systemd service at boot"
systemctl disable "$service_name"
```
<!-- cheat
var service_name
-->

## list

### Running services

List running systemd services.

```sh title:"List running systemd services"
systemctl list-units --type=service --state=running
```
<!-- cheat -->

### Enabled services

List services enabled at boot.

```sh title:"List enabled systemd services"
systemctl list-unit-files --type=service --state=enabled
```
<!-- cheat -->

### Disabled services

List disabled systemd services.

```sh title:"List disabled systemd services"
systemctl list-unit-files --type=service --state=disabled
```
<!-- cheat -->

### All services

List all loaded systemd services.

```sh title:"List all loaded systemd services"
systemctl list-units --type=service --all
```
<!-- cheat -->
