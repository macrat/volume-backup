#!/bin/sh

schedule=${BACKUP_SCHEDULE:-42 2 * * *}
prefix=${BACKUP_PREFIX:-backup-}
retains=${BACKUP_RETAIN_NUM:-3}
uid=${BACKUP_USER:-1000}

adduser -u ${uid} -g ${uid} -D ${uid}

echo "${schedule} cd /data && tar czvf \"/backup/${prefix}\$(date +%Y%m%d%H%M).tar.gz\" --numeric-owner \$(ls -A) && ls /backup/${prefix}* | head -n -${retains} | xargs -r rm" >> /var/spool/cron/crontabs/${uid}

exec crond -f -L /dev/stdout
