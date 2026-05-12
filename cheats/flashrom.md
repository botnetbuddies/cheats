# Flashrom

## linux spi

### Read chip

Read SPI flash using Linux spidev, such as on a Raspberry Pi.

```sh title:"Read SPI flash with linux_spi"
flashrom -p "linux_spi:dev=$spidev,spispeed=$spispeed" -r "$output_file"
```
<!-- cheat
var spidev := /dev/spidev0.0
var spispeed := 1M
var output_file
-->

### Force read chip

Force a chip read when flashrom cannot safely auto-detect the chip.

```sh title:"Force read SPI flash with chip name"
flashrom -p "linux_spi:dev=$spidev,spispeed=$spispeed" -r "$output_file" -f -c "$chip_name"
```
<!-- cheat
var spidev := /dev/spidev0.0
var spispeed := 1M
var output_file
var chip_name
-->

## buspirate

### Read chip

Read SPI flash with a Bus Pirate.

```sh title:"Read SPI flash with Bus Pirate"
flashrom -p "buspirate_spi:dev=$buspirate,spispeed=$spispeed" -r "$output_file"
```
<!-- cheat
var buspirate := /dev/ttyUSB0
var spispeed := 1M
var output_file
-->

### Force read chip

Force a Bus Pirate chip read when flashrom cannot safely auto-detect the chip.

```sh title:"Force read SPI flash with Bus Pirate and chip name"
flashrom -p "buspirate_spi:dev=$buspirate,spispeed=$spispeed" -r "$output_file" -f -c "$chip_name"
```
<!-- cheat
var buspirate := /dev/ttyUSB0
var spispeed := 1M
var output_file
var chip_name
-->
