# Crontab

## user crontab

### List jobs

List jobs with Crontab.

List the current user's cron jobs.

```sh title:"Crontab List Jobs"
crontab -l
```
<!-- cheat -->

### Edit jobs

Run edit jobs with Crontab.

Open the current user's crontab in the configured editor.

```sh title:"Crontab Run Edit Jobs"
crontab -e
```
<!-- cheat -->

### List another user

List another user with Crontab.

List another user's cron jobs. Requires sufficient privileges.

```sh title:"Crontab List Another User"
crontab -u "$target_user" -l
```
<!-- cheat
var target_user
-->

## system cron

### System crontab

Run system crontab with Crontab.

Print the system crontab.

```sh title:"Crontab Run System Crontab"
cat /etc/crontab
```
<!-- cheat -->

### Cron directories

List cron directories with Crontab.

List common system cron directories.

```sh title:"Crontab List Cron Directories"
ls -la /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
```
<!-- cheat -->
