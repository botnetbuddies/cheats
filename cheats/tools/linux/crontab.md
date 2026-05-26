# Crontab

## user crontab

### List jobs

List the current user's cron jobs.

```sh title:"Crontab List current user's cron jobs"
crontab -l
```
<!-- cheat -->

### Edit jobs

Open the current user's crontab in the configured editor.

```sh title:"Edit current user's crontab"
crontab -e
```
<!-- cheat -->

### List another user

List another user's cron jobs. Requires sufficient privileges.

```sh title:"Crontab List another user's cron jobs"
crontab -u "$target_user" -l
```
<!-- cheat
var target_user
-->

## system cron

### System crontab

Print the system crontab.

```sh title:"Print /etc/crontab"
cat /etc/crontab
```
<!-- cheat -->

### Cron directories

List common system cron directories.

```sh title:"Crontab List system cron directories"
ls -la /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
```
<!-- cheat -->
