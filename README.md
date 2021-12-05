backup container's volume
=========================

A docker container image for scheduling backup of the volume.

This container runs cron, and compress `/data/` directory to `/backup/` directory as a tar.gz file every day.

``` bash
$ YOUR_TIMEZONE="Asia/Tokyo"
$ docker run -d -v your-data:/data:ro -v $(pwd):/backup -e TZ=${YOUR_TIMEZONE} ghcr.io/macrat/volume-backup
```

In default, it runs backup on 2:42 every day, and retain 3 versions.
You can customize this behavior via environment variables.

Note: You can not stop this container with Ctrl-C. Please use `docker stop` command.


## Options

| Environment Variable | Default      | Description                                                                         |
|----------------------|--------------|-------------------------------------------------------------------------------------|
| BACKUP_SCHEDULE      | `42 2 * * *` | Schedule in crontab spec.                                                           |
| BACKUP_PREFIX        | `backup-`    | Prefix string of backup file.                                                       |
| BACKUP_RETAIN_NUM    | `3`          | Number of retain backup versions. 0 or negative value means don't remove old files. |
| BACKUP_UID           | `1000`       | Backup file owner's UID.                                                            |

``` bash
# For example, retain backup files 7 days.
$ docker run -d -v your-data:/data:ro -v $(pwd):/backup -e BACKUP_RETAIN_NUM=7 ghcr.io/macrat/volume-backup

# Or, backup once a week, every sunday.
$ docker run -d -v your-data:/data:ro -v $(pwd):/backup -e BACKUP_SCHEDULE='0 0 * * 0' ghcr.io/macrat/volume-backup
```
