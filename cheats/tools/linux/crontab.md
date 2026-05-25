# Crontab

## user crontab

### List jobs

List jobs with Crontab.

```sh title:"Crontab List Jobs"
crontab -l
```
<!-- cheat -->

### Edit jobs

Run edit jobs with Crontab.

```sh title:"Crontab Run Edit Jobs"
crontab -e
```
<!-- cheat -->

### List another user

List another user with Crontab.

```sh title:"Crontab List Another User"
crontab -u "$target_user" -l
```
<!-- cheat
var target_user
-->

## system cron

### System crontab

Run system crontab with Crontab.

```sh title:"Crontab Run System Crontab"
cat /etc/crontab
```
<!-- cheat -->

### Cron directories

List cron directories with Crontab.

```sh title:"Crontab List Cron Directories"
ls -la /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
```
<!-- cheat -->
