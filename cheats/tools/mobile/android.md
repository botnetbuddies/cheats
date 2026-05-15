# Android

## adb

### Devices

List connected Android devices.

```sh title:"List connected Android devices"
adb devices
```
<!-- cheat -->

### Shell

Open an adb shell.

```sh title:"Open adb shell"
adb shell
```
<!-- cheat -->

### Install APK

Install an APK on the connected device.

```sh title:"Install APK with adb"
adb install "$apk_file"
```
<!-- cheat
var apk_file
-->

### Pull file

Pull a file from the device.

```sh title:"Pull file from Android device"
adb pull "$remote_path" "$local_path"
```
<!-- cheat
var remote_path
var local_path
-->

### Push file

Push a file to the device.

```sh title:"Push file to Android device"
adb push "$local_path" "$remote_path"
```
<!-- cheat
var local_path
var remote_path
-->

## apktool

### Decode APK

Decode APK resources and smali with apktool.

```sh title:"Decode APK with apktool"
apktool d "$apk_file" -o "$output_dir"
```
<!-- cheat
var apk_file
var output_dir
-->

### Build APK

Rebuild a decoded APK project.

```sh title:"Rebuild APK with apktool"
apktool b "$project_dir" -o "$apk_file"
```
<!-- cheat
var project_dir
var apk_file
-->

## jadx

### GUI

Open an APK in jadx-gui.

```sh title:"Open APK in jadx-gui"
jadx-gui "$apk_file"
```
<!-- cheat
var apk_file
-->

### Decompile

Decompile an APK to Java source.

```sh title:"Decompile APK with jadx"
jadx -d "$output_dir" "$apk_file"
```
<!-- cheat
var output_dir
var apk_file
-->

## objection

### Explore

Attach Objection to a running app by package name.

```sh title:"Attach Objection to Android app"
objection -g "$package_name" explore
```
<!-- cheat
var package_name
-->

### Disable SSL pinning

Disable common Android SSL pinning checks at runtime.

```sh title:"Disable Android SSL pinning with Objection"
objection -g "$package_name" explore -s "android sslpinning disable"
```
<!-- cheat
var package_name
-->
