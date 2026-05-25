# Drupwn

## enum

### Classic

Enumerate classic with Drupwn.

Enumerate Drupal users, nodes, modules, default files, and themes.

```sh title:"Drupwn Enumerate Classic"
drupwn --users --nodes --modules --dfiles --themes enum "$url"
```
<!-- cheat
var url
-->

### Docker

Enumerate docker with Drupwn.

Run drupwn in Docker.

```sh title:"Drupwn Enumerate Docker"
sudo docker run --rm -it immunit/drupwn --users --nodes --modules --dfiles --themes enum "$url"
```
<!-- cheat
var url
-->
