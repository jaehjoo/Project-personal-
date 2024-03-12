FROM alpine:3.18.6

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache curl bash php82 php82-fpm php82-phar php82-mysqli php82-iconv mariadb-client dumb-init && \
    ln -s /usr/bin/php82 /usr/bin/php

RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

RUN addgroup -g 82 -S www-data;     exit 0
RUN adduser -D -H -u 82 -G www-data www-data

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf
RUN mkdir -p /run/php

COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

EXPOSE $WP_PORT

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/script.sh" ]
CMD [ "/usr/sbin/php-fpm82", "--nodaemonize" ]