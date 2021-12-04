FROM gitea/gitea:latest

COPY ./entrypoint.sh /

RUN rm /etc/crontabs/root && chmod 755 /entrypoint.sh && mkdir /backup && chown 1000:1000 /backup

VOLUME /backup

CMD /entrypoint.sh
