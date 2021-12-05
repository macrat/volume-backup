#!/bin/sh

schedule=${BACKUP_SCHEDULE:-42 2 * * *}
prefix=${BACKUP_PREFIX:-backup-}
retains=${BACKUP_RETAIN_NUM:-3}
uid=${BACKUP_UID:-1000}

echo "${schedule} cd /data && tar czvf \"/backup/${prefix}\$(date +%Y%m%d%H%M).tar.gz\" \$(ls -A) && chown ${uid}:${uid} /backup/${prefix}* && ls /backup/${prefix}* | head -n -${retains} | xargs -r rm" >> /var/spool/cron/crontabs/root

exec crond -f -L /dev/stdout
