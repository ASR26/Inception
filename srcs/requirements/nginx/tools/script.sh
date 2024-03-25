#!/bin/bash

sed -i "s#DOMAIN_NAME#$DOMAIN_NAME#g" /etc/nginx/nginx.conf
sed -i "s#CERT_PATH#$CERT_PATH#g" /etc/nginx/nginx.conf
sed -i "s#KEY_PATH#$KEY_PATH#g" /etc/nginx/nginx.conf

mkdir -p $CERT_DIR_PATH

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY_PATH -out $CERT_PATH -subj "/C=$COUNTRY/ST=$COMUNITY/L=$LOCALITY/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$DOMAIN_NAME/UID=$LOGIN"

/usr/sbin/nginx -g "daemon off;"