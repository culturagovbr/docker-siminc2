FROM php:5.6.30-apache

VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y libfreetype6-dev \
    && apt-get install -y libjpeg62-turbo-dev \
    && apt-get install -y libcurl4-gnutls-dev \
    && apt-get install -y libxml2-dev \
    && apt-get install -y freetds-dev \
    && apt-get install -y git \
    && apt-get install -y libghc-postgresql-libpq-dev \
    && apt-get install -y libpq-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install soap \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/include/postgresql/ \
    && docker-php-ext-install pgsql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install zip \
    && docker-php-ext-install xml

WORKDIR /var/www/

EXPOSE 80
EXPOSE 9000

COPY ./src /tmp/src

RUN chmod +x -R /tmp/src/
RUN usermod -u 1000 www-data

COPY ./src/actions/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD /tmp/src/actions/start.sh