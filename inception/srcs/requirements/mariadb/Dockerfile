FROM alpine:3.18.6

WORKDIR /mariadb

RUN apk update && \
    apk upgrade --no-cache && \
    apk add bash mariadb mariadb-client dumb-init gettext --no-cache && \
    mkdir -p /run/mysqld /var/lib/mysql /home/mysql/log && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /home/mysql/log && \
    chmod -R 755 /var/lib/mysql /run/mysqld /home/mysql/log

COPY ./tools/script.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/
COPY ./conf/my.cnf /etc/
RUN chmod +x /usr/local/bin/script.sh

EXPOSE $MARIADB_PORT
ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/script.sh" ]
CMD [ "/usr/bin/mysqld_safe" ]
