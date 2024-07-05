FROM alpine:3.13

RUN apk update && apk upgrade && apk add --no-cache \
        nginx \
        openssl

# OpenSSL configuration
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/inception.pem \
        -keyout /etc/nginx/ssl/inception.key \
        -subj "/CN=${LOGIN}/"

# Nginx configuration
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Start Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]