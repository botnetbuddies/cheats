# Service

## sysvinit

### List services

List services with Service.

List SysV-style services and their status.

```sh title:"Service List Services"
service --status-all
```
<!-- cheat -->

### Service status

Show status with Service.

Show status for a SysV-style service.

```sh title:"Service Show Status"
service "$service_name" status
```
<!-- cheat
var service_name
-->

### Start service

Start service with Service.

Start a SysV-style service.

```sh title:"Service Start Service"
service "$service_name" start
```
<!-- cheat
var service_name
-->

### Stop service

Run stop service with Service.

Stop a SysV-style service.

```sh title:"Service Run Stop Service"
service "$service_name" stop
```
<!-- cheat
var service_name
-->

### Restart service

Start restart service with Service.

Restart a SysV-style service.

```sh title:"Service Start Restart Service"
service "$service_name" restart
```
<!-- cheat
var service_name
-->
