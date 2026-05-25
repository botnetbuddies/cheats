# Drupwn

## enum

### Classic

Enumerate Drupal users, nodes, modules, default files, and themes.

```sh title:"Enumerate Drupal with drupwn"
drupwn --users --nodes --modules --dfiles --themes enum "$url"
```
<!-- cheat
var url
-->

### Docker

Run drupwn in Docker.

```sh title:"Enumerate Drupal with drupwn Docker"
sudo docker run --rm -it immunit/drupwn --users --nodes --modules --dfiles --themes enum "$url"
```
<!-- cheat
var url
-->
