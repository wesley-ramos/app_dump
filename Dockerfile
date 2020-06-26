FROM mysql:5.6

RUN apt-get update && apt-get install -y unzip zip awscli

RUN mkdir -p /app/config && mkdir -p /app/dump && mkdir -p /app/error  

COPY docker-entrypoint.sh /app/docker-entrypoint.sh

RUN chmod -R 777 /app

WORKDIR /app

VOLUME /app/config
VOLUME /app/dump
VOLUME /app/error

CMD ["/app/docker-entrypoint.sh"]