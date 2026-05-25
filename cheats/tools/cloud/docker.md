# Docker

## containers

### List running containers

List running containers with Docker.

Show running containers.

```sh title:"Docker List Running Containers"
docker ps
```
<!-- cheat -->

### List all containers

List all containers with Docker.

Show running and stopped containers.

```sh title:"Docker List All Containers"
docker ps -a
```
<!-- cheat -->

### Stop container

Run stop container with Docker.

Stop a running container with SIGTERM.

```sh title:"Docker Run Stop Container"
docker stop "$container_id"
```
<!-- cheat
var container_id
-->

### Kill container

Run kill container with Docker.

Stop a running container with SIGKILL.

```sh title:"Docker Run Kill Container"
docker kill "$container_id"
```
<!-- cheat
var container_id
-->

### Remove all containers

Remove all containers with Docker.

Remove all running and stopped containers. Requires typing `YES` before it runs.

```sh title:"Docker Remove All Containers"
read -r -p "Remove all Docker containers? Type YES: " confirm; [ "$confirm" = "YES" ] && docker rm -f $(docker ps -aq)
```
<!-- cheat
var confirm
-->

### Exec bash

Execute exec bash with Docker.

Open an interactive bash shell inside a container.

```sh title:"Docker Execute Exec Bash"
docker exec -it "$container_id" bash
```
<!-- cheat
var container_id
-->

### Exec sh

Execute exec sh with Docker.

Open an interactive POSIX shell inside a container.

```sh title:"Docker Execute Exec Sh"
docker exec -it "$container_id" /bin/sh
```
<!-- cheat
var container_id
-->

### Inspect container

Run inspect container with Docker.

Inspect a container.

```sh title:"Docker Run Inspect Container"
docker inspect "$container_id"
```
<!-- cheat
var container_id
-->

### Tail logs

Run tail logs with Docker.

Print the last 100 lines from a container.

```sh title:"Docker Run Tail Logs"
docker logs --tail 100 "$container_id"
```
<!-- cheat
var container_id
-->

### Follow logs

Run follow logs with Docker.

Follow container logs from the last 100 lines.

```sh title:"Docker Run Follow Logs"
docker logs --tail 100 -f "$container_id"
```
<!-- cheat
var container_id
-->

## networks

### List networks

List networks with Docker.

List Docker networks.

```sh title:"Docker List Networks"
docker network ls
```
<!-- cheat -->

### Create network

Create network with Docker.

Create a Docker network.

```sh title:"Docker Create Network"
docker network create "$network_name"
```
<!-- cheat
var network_name
-->

## compose

### Compose up

Start compose up with Docker.

Build, create, start, and attach to all Compose services.

```sh title:"Docker Start Compose Up"
docker compose up
```
<!-- cheat -->

### Compose up detached

Start compose up detached with Docker.

Build, create, start, and detach from all Compose services.

```sh title:"Docker Start Compose Up Detached"
docker compose up -d
```
<!-- cheat -->

### Compose service up detached

Start compose service up detached with Docker.

Build, create, start, and detach from one Compose service.

```sh title:"Docker Start Compose Service Up Detached"
docker compose up -d "$service_name"
```
<!-- cheat
var service_name
-->

### Compose service logs

Run compose service logs with Docker.

Print the last 100 lines from a Compose service.

```sh title:"Docker Run Compose Service Logs"
docker compose logs --tail 100 "$service_name"
```
<!-- cheat
var service_name
-->

### Compose service follow logs

Run compose service follow logs with Docker.

Follow Compose service logs from the last 100 lines.

```sh title:"Docker Run Compose Service Follow Logs"
docker compose logs -f --tail 100 "$service_name"
```
<!-- cheat
var service_name
-->

### Compose down

Create compose down with Docker.

Stop and remove containers and networks created by `docker compose up`.

```sh title:"Docker Create Compose Down"
docker compose down
```
<!-- cheat -->

## images

### List images

List images with Docker.

Show local Docker images.

```sh title:"Docker List Images"
docker images
```
<!-- cheat -->

### Run MySQL

Run MySQL with Docker.

Run a temporary MySQL container with an empty root password.

```sh title:"Docker Run MySQL"
docker run --rm --name "$container_name" -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d "mysql/mysql-server:$image_tag"
```
<!-- cheat
var container_name := mysql8
var image_tag := latest
-->

### MySQL shell

Spawn MySQL shell with Docker.

Open a MySQL shell in a running MySQL container.

```sh title:"Docker Spawn MySQL Shell"
docker exec -ti "$container_name" mysql
```
<!-- cheat
var container_name := mysql8
-->
