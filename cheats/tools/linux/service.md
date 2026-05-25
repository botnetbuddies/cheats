# Service

## sysvinit

### List services

List SysV-style services and their status.

```sh title:"List SysV services"
service --status-all
```
<!-- cheat -->

### Service status

Show status for a SysV-style service.

```sh title:"Show SysV service status"
service "$service_name" status
```
<!-- cheat
var service_name
-->

### Start service

Start a SysV-style service.

```sh title:"Start SysV service"
service "$service_name" start
```
<!-- cheat
var service_name
-->

### Stop service

Stop a SysV-style service.

```sh title:"Stop SysV service"
service "$service_name" stop
```
<!-- cheat
var service_name
-->

### Restart service

Restart a SysV-style service.

```sh title:"Restart SysV service"
service "$service_name" restart
```
<!-- cheat
var service_name
-->
