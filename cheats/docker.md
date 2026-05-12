# Docker

## containers

### List running containers

Show running containers.

```sh title:"List running containers"
docker ps
```
<!-- cheat -->

### List all containers

Show running and stopped containers.

```sh title:"List all containers"
docker ps -a
```
<!-- cheat -->

### Stop container

Stop a running container with SIGTERM.

```sh title:"Stop container with SIGTERM"
docker stop "$container_id"
```
<!-- cheat
var container_id
-->

### Kill container

Stop a running container with SIGKILL.

```sh title:"Kill container with SIGKILL"
docker kill "$container_id"
```
<!-- cheat
var container_id
-->

### Remove all containers

Remove all running and stopped containers. Requires typing `YES` before it runs.

```sh title:"Confirm, then remove all containers"
read -r -p "Remove all Docker containers? Type YES: " confirm; [ "$confirm" = "YES" ] && docker rm -f $(docker ps -aq)
```
<!-- cheat -->

### Exec bash

Open an interactive bash shell inside a container.

```sh title:"Open bash in container"
docker exec -it "$container_id" bash
```
<!-- cheat
var container_id
-->

### Tail logs

Print the last 100 lines from a container.

```sh title:"Tail last 100 container log lines"
docker logs --tail 100 "$container_id"
```
<!-- cheat
var container_id
-->

### Follow logs

Follow container logs from the last 100 lines.

```sh title:"Follow container logs"
docker logs --tail 100 -f "$container_id"
```
<!-- cheat
var container_id
-->

## networks

### List networks

List Docker networks.

```sh title:"List Docker networks"
docker network ls
```
<!-- cheat -->

### Create network

Create a Docker network.

```sh title:"Create Docker network"
docker network create "$network_name"
```
<!-- cheat
var network_name
-->

## compose

### Compose up

Build, create, start, and attach to all Compose services.

```sh title:"Start Compose services in foreground"
docker compose up
```
<!-- cheat -->

### Compose up detached

Build, create, start, and detach from all Compose services.

```sh title:"Start Compose services in background"
docker compose up -d
```
<!-- cheat -->

### Compose service up detached

Build, create, start, and detach from one Compose service.

```sh title:"Start one Compose service in background"
docker compose up -d "$service_name"
```
<!-- cheat
var service_name
-->

### Compose service logs

Print the last 100 lines from a Compose service.

```sh title:"Tail last 100 Compose service log lines"
docker compose logs --tail 100 "$service_name"
```
<!-- cheat
var service_name
-->

### Compose service follow logs

Follow Compose service logs from the last 100 lines.

```sh title:"Follow Compose service logs"
docker compose logs -f --tail 100 "$service_name"
```
<!-- cheat
var service_name
-->

### Compose down

Stop and remove containers and networks created by `docker compose up`.

```sh title:"Stop Compose stack and remove created containers/networks"
docker compose down
```
<!-- cheat -->

## images

### List images

Show local Docker images.

```sh title:"List Docker images"
docker images
```
<!-- cheat -->

### Run MySQL

Run a temporary MySQL container with an empty root password.

```sh title:"Run MySQL container with empty root password"
docker run --rm --name "$container_name" -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d "mysql/mysql-server:$image_tag"
```
<!-- cheat
var container_name := mysql8
var image_tag := latest
-->

### MySQL shell

Open a MySQL shell in a running MySQL container.

```sh title:"Open MySQL shell in container"
docker exec -ti "$container_name" mysql
```
<!-- cheat
var container_name := mysql8
-->
