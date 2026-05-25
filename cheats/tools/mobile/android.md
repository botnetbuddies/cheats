# Android

## adb

### Devices

List devices with Android.

List connected Android devices.

```sh title:"Android List Devices"
adb devices
```
<!-- cheat -->

### Shell

Spawn shell with Android.

Open an adb shell.

```sh title:"Android Spawn Shell"
adb shell
```
<!-- cheat -->

### Install APK

Install APK with Android.

Install an APK on the connected device.

```sh title:"Android Install APK"
adb install "$apk_file"
```
<!-- cheat
var apk_file
-->

### Pull file

Download pull file with Android.

Pull a file from the device.

```sh title:"Android Download Pull File"
adb pull "$remote_path" "$local_path"
```
<!-- cheat
var remote_path
var local_path
-->

### Push file

Run push file with Android.

Push a file to the device.

```sh title:"Android Run Push File"
adb push "$local_path" "$remote_path"
```
<!-- cheat
var local_path
var remote_path
-->

## apktool

### Decode APK

Decode APK with Android.

Decode APK resources and smali with apktool.

```sh title:"Android Decode APK"
apktool d "$apk_file" -o "$output_dir"
```
<!-- cheat
var apk_file
var output_dir
-->

### Build APK

Build APK with Android.

Rebuild a decoded APK project.

```sh title:"Android Build APK"
apktool b "$project_dir" -o "$apk_file"
```
<!-- cheat
var project_dir
var apk_file
-->

## jadx

### GUI

Run GUI with Android.

Open an APK in jadx-gui.

```sh title:"Android Run GUI"
jadx-gui "$apk_file"
```
<!-- cheat
var apk_file
-->

### Decompile

Run decompile with Android.

Decompile an APK to Java source.

```sh title:"Android Run Decompile"
jadx -d "$output_dir" "$apk_file"
```
<!-- cheat
var output_dir
var apk_file
-->

## objection

### Explore

Run explore with Android.

Attach Objection to a running app by package name.

```sh title:"Android Run Explore"
objection -g "$package_name" explore
```
<!-- cheat
var package_name
-->

### Disable SSL pinning

Disable SSL pinning with Android.

Disable common Android SSL pinning checks at runtime.

```sh title:"Android Disable SSL Pinning"
objection -g "$package_name" explore -s "android sslpinning disable"
```
<!-- cheat
var package_name
-->
