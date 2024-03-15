FROM alpine:3.17

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache curl bash php81 php81-fpm php81-phar php81-mysqli php81-iconv php81-gd mariadb-client dumb-init

RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    curl -s -L https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh --output /usr/local/bin/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -g 82 -S www-data; \
    fi
RUN adduser -D -H -u 82 -G www-data www-data

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
RUN mkdir -p /run/php

COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

EXPOSE $WP_PORT

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/script.sh" ]
CMD [ "/usr/sbin/php-fpm81", "--nodaemonize" ]