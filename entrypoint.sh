#!/bin/sh

schedule=${BACKUP_SCHEDULE:-42 2 * * *}
prefix=${BACKUP_PREFIX:-backup-}
retains=${BACKUP_RETAIN_NUM:-3}
uid=${BACKUP_USER:-1000}

adduser -u ${uid} -g ${uid} -D backup

echo "${schedule} cd /data && tar czvf \"/backup/${prefix}\$(date +%Y%m%d%H%M).tar.gz\" --numeric-owner * && ls ${prefix}* | head -n -${retains} | xargs -r rm" >> /var/spool/cron/crontabs/backup

exec crond -f -L /dev/stdout
