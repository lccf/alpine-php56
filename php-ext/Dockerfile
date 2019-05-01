FROM dev/php-base:5.6
LABEL maintainer="leaf <leftcold@gmail.com>"

COPY src/redis.tar.gz /usr/src/redis.tar.gz
COPY src/xdebug.tgz /usr/src/xdebug.tgz
COPY src/memcached.tar.gz /usr/src/memcached.tar.gz

RUN apk add --no-cache libpng-dev libjpeg-turbo-dev icu-dev zlib-dev libmemcached-dev && \
    docker-php-source extract && \
    mkdir -p /usr/src/php/ext/redis && \
    tar -xzf /usr/src/redis.tar.gz -C /usr/src/php/ext/redis --strip-components=1 && \
    mkdir -p /usr/src/php/ext/xdebug && \
    tar -xzf /usr/src/xdebug.tgz -C /usr/src/php/ext/xdebug --strip-components=1 && \
    mkdir -p /usr/src/php/ext/memcached && \
    tar -xzf /usr/src/memcached.tar.gz -C /usr/src/php/ext/memcached --strip-components=1 && \
    docker-php-ext-install pdo_mysql bcmath intl gd opcache redis xdebug memcached && \
    docker-php-source delete && \
    rm -rf /var/cache/apk/*

CMD ["php-fpm"]