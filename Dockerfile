FROM php:8.4-alpine

# Install PHP modules and clean up
RUN apk add --no-cache $PHPIZE_DEPS \
    imagemagick-dev icu-dev zlib-dev jpeg-dev libpng-dev libpq-dev libzip-dev libgomp linux-headers; \
    docker-php-ext-configure gd --with-jpeg; \
    docker-php-ext-install intl pcntl gd exif zip mysqli pdo pdo_mysql bcmath opcache; \
    pecl install imagick; \
    docker-php-ext-enable imagick; \
    apk del $PHPIZE_DEPS; \
    rm -rf /tmp/pear;

# Install other dependencies
RUN apk add --no-cache patch git curl sqlite nodejs npm mariadb-client ncdu openssh-client;