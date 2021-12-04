#!/bin/sh

schedule=${BACKUP_SCHEDULE:-42 2 * * *}
prefix=${BACKUP_PREFIX:-gitea-backup-}
retains=${BACKUP_RETAIN_NUM:-3}
user=${BACKUP_USER:-git}

echo "${schedule} cd /backup && gitea dump -f \"${prefix}\$(date +%Y%m%d%H%M).zip\" && ls ${prefix}* | head -n -${retains} | xargs rm" >> /etc/crontabs/${user}

exec crond -f -L /dev/stdout
