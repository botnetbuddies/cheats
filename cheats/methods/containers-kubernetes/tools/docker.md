---
tool: Docker
category: containers-kubernetes-tool
tags: containers tool docker
---

# Docker

Docker manages local containers, images, networks, volumes, and daemon-backed container execution.

## Linux

### Running containers

#sh #docker #containers

List running containers.

```sh title:"List running Docker containers"
docker ps
```
<!-- cheat -->

### All containers

#sh #docker #containers

List running and stopped containers.

```sh title:"List all Docker containers"
docker ps -a
```
<!-- cheat -->

### Exec shell

#sh #docker #exec

Open a shell inside a container.

```sh title:"Exec shell in Docker container"
docker exec -it "$container_id" /bin/sh
```
<!-- cheat
var container_id
-->

### Inspect container

#sh #docker #inspect

Inspect a container.

```sh title:"Inspect Docker container"
docker inspect "$container_id"
```
<!-- cheat
var container_id
-->

### Container logs

#sh #docker #logs

Tail container logs.

```sh title:"Tail Docker container logs"
docker logs --tail 100 "$container_id"
```
<!-- cheat
var container_id
-->
