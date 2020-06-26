FROM mysql:5.6

RUN mkdir -p /app/database && mkdir -p /app/dump && mkdir -p /app/error  

COPY docker-entrypoint.sh /app/docker-entrypoint.sh

RUN chmod -R 777 /app

WORKDIR /app

VOLUME /app/database
VOLUME /app/dump
VOLUME /app/error

CMD ["/app/docker-entrypoint.sh"]