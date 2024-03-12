#!/bin/sh

echo "set nginx configure"
sed -i "s/listen ssl;/listen ${NGINX_PORT} ssl;/g" /etc/nginx/nginx.conf
sed -i "s/listen \[::\]: ssl;/listen \[::\]:${NGINX_PORT} ssl;/g" /etc/nginx/nginx.conf
sed -i "s/ssl_certificate;/ssl_certificate ${SSL_CRT};/g" /etc/nginx/nginx.conf
sed -i "s/ssl_certificate_key;/ssl_certificate_key ${SSL_KEY};/g" /etc/nginx/nginx.conf
sed -i "s/fastcgi_pass wordpress:/fastcgi_pass wordpress:${WP_PORT}/g" /etc/nginx/nginx.conf
echo "complete nginx configure"

echo "wait wordpress"
/usr/local/bin/wait-for-it.sh $WP_HOST:$WP_PORT --timeout=15
echo "complete wordpress"

echo "set openssl"
openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-keyout ${SSL_KEY_OSL} \
	-out ${SSL_CRT_OSL} -sha256 \
	-subj "/C=KR/ST=Seoul/L=Gangnam/O=42Seoul/OU=Cadet/CN=jaehjoo/emailAddress=jaehjoo@email.net"
echo "complete openssl"

echo "start nginx"
exec "$@"