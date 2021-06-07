FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY ./compose/production/nginx/nginx.conf /etc/nginx/conf.d
# COPY ./compose/production/nginx/ssl /etc/ssl
