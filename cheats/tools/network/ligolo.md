# Ligolo

## ligolo

### Proxy server

Start proxy server with Ligolo.

```sh title:"Ligolo Start Proxy Server"
sudo ligolo-proxy -selfcert
```
<!-- cheat -->

### Windows agent

Execute windows agent with Ligolo.

```sh title:"Ligolo Execute Windows Agent"
.\agent.exe -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Linux agent

Execute linux agent with Ligolo.

```sh title:"Ligolo Execute Linux Agent"
./agent -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Magic local route

Run magic local route with Ligolo.

```sh title:"Ligolo Run Magic Local Route"
sudo ip route add 240.0.0.1/32 dev ligolo
```
<!-- cheat -->

### Create tun interface

Create tun interface with Ligolo.

```sh title:"Ligolo Create Tun Interface"
sudo ip tuntap add user $USER mode tun ligolo
```
<!-- cheat
import tun_ip
var USER
-->

### Bring tun up

Run bring tun up with Ligolo.

```sh title:"Ligolo Run Bring Tun Up"
sudo ip link set ligolo up
```
<!-- cheat -->

### Route subnet via tun

Enumerate route subnet via tun with Ligolo.

```sh title:"Ligolo Enumerate Route Subnet Via Tun"
sudo ip route add $rhost_ip/24 dev ligolo
```
<!-- cheat
var rhost_ip
-->

### Default reverse listener

List default reverse listener with Ligolo.

```sh title:"Ligolo List Default Reverse Listener"
listener_add --addr 0.0.0.0:11601 --to 127.0.0.1:11601
```
<!-- cheat -->

### Custom reverse listener

List custom reverse listener with Ligolo.

```sh title:"Ligolo List Custom Reverse Listener"
listener_add --addr 0.0.0.0:$rport --to 127.0.0.1:$lport
```
<!-- cheat
import tun_ip
import lports
var rport
-->

