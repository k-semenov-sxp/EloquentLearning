FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libonig-dev \
    libxml2-dev \
    libzip-dev

RUN docker-php-ext-install mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-scripts --no-autoloader && \
    composer dump-autoload --optimize

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

CMD php artisan serve --host=0.0.0.0 --port=8000
