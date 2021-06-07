# Dockerfile
FROM node:12


COPY ./compose/nuxt/start /start
RUN sed -i 's/\r$//g' /start
RUN chmod +x /start


WORKDIR /app
