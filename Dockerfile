FROM busybox:latest

COPY ./entrypoint.sh /

RUN mkdir -p /var/spool/cron/crontabs && chmod 755 /entrypoint.sh && mkdir /backup && chown 1000:1000 /backup

VOLUME /backup

CMD /entrypoint.sh
