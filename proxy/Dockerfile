#############
### proxy ###
#############

# base image
FROM nginx:alpine

# clear existing configs
RUN rm /etc/nginx/conf.d/*

# copy config
COPY proxy.conf /etc/nginx/conf.d/

# create ssl certificate and key
RUN apk update
RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/server.key -out /etc/ssl/server.crt -batch