# Openvpn

<!-- cheat
export vpn
var vpn = sh -c 'printf "%s\n" "$VPN_FOLDER/competitive.ovpn"; find "$VPN_FOLDER" -maxdepth 1 -type f ! -name ".*" -printf "%p\n" | grep -v "^$(basename "$VPN_FOLDER/")$" | sort' --- --header 'VPN directory files'
-->

## openvpn

### Start OpenVPN

Start the chosen `.ovpn` profile detached and silent. `sudo -l` first to refresh the timestamp so it doesn't prompt mid-tunnel.

```sh title:"Openvpn Start chosen .ovpn detached and silent"
sudo -l && sudo openvpn --config "$vpn" >/dev/null 2>&1 &
```
<!-- cheat
import vpn
-->

### Kill OpenVPN

Stop every running openvpn process (no graceful shutdown).

```sh title:"Kill every running openvpn process"
sudo pkill openvpn
```
<!-- cheat -->
