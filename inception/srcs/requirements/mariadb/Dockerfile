FROM alpine:3.17

WORKDIR /mariadb

RUN apk update && \
    apk upgrade --no-cache && \
    apk add bash mariadb mariadb-client dumb-init gettext --no-cache && \
    mkdir -p /var/run/mysqld /var/lib/mysql /home/mysql/log && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /home/mysql/log && \
    chmod -R 755 /var/lib/mysql /run/mysqld /home/mysql/log

COPY ./tools/script.sh /usr/local/bin/script.sh
COPY ./conf/wordpress.sql /usr/local/bin/wordpress.sql
COPY ./conf/my.cnf /etc/my.cnf
RUN chmod +x /usr/local/bin/script.sh

EXPOSE $MARIADB_PORT
ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/script.sh" ]
CMD [ "/usr/bin/mysqld_safe" ]
