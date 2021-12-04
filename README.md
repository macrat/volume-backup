Gitea backup container
======================

A docker container image for scheduling backup of [Gitea](https://gitea.io/).

``` bash
# Start your Gitea container
$ docker run -d -v gitea:/data -p 3000:3000 gitea/gitea

# And then, start backup scheduling container.
$ docker run -d -v gitea:/data -v $(pwd):/backup ghcr.io/macrat/gitea-backup
```

In default, it runs backup on 2:42 every day, and retain 3 files.
You can customize this behavior via environment variables.

Please see also [Backup and Restore](https://docs.gitea.io/en-us/backup-and-restore/) section of the official documentation.


## Options

| Environment Variable | Default         | Description                    |
|----------------------|-----------------|--------------------------------|
| BACKUP_SCHEDULE      | `42 2 * * *`    | Schedule in crontab spec.      |
| BACKUP_PREFIX        | `gitea-backup-` | Prefix string of backup file.  |
| BACKUP_RETAIN_NUM    | `3`             | Number of retain backup files. |
| BACKUP_USER          | `git`           | Username to execute backup.    |

``` bash
# For example, retain backup files 7 days.
$ docker run -d -v gitea:/data -v $(pwd):/backup -e BACKUP_RETAIN_NUM=7 ghcr.io/macrat/gitea-backup

# Or, backup once a week, every sunday.
$ docker run -d -v gitea:/data -v $(pwd):/backup -e BACKUP_SCHEDULE='0 0 * * 0' ghcr.io/macrat/gitea-backup
```
