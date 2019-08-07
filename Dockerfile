FROM node:10

RUN apt-get update -Y && \
    apt-get install nginx -Y

RUN mkdir /var/www/ && mkdir /var/www/app

COPY files/nginx/nginx.conf /etc/nginx/nginx.conf
COPY files/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
