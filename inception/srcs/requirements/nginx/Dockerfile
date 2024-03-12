FROM alpine:3.18.6

WORKDIR /nginx

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache bash nginx openssl dumb-init curl

RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx && \
    chown -R nginx:nginx /var/www/html /etc/nginx/ssl /run/nginx
RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

EXPOSE $NGINX_PORT

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "/usr/local/bin/script.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]