FROM php:5.6.30-apache

VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]

RUN echo "[ ***** ***** ***** ] - Copying files to Image ***** ***** ***** "
COPY ./src /tmp/src

RUN apt-get update

RUN echo "[ ***** ***** ***** ] - Installing each item in new command to use cache and avoid download again ***** ***** ***** "
RUN apt-get install -y apt-utils
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y freetds-dev
RUN apt-get install -y libghc-postgresql-libpq-dev
RUN apt-get install -y libpq-dev

RUN echo "[ ***** ***** ***** ] - Installing PHP Dependencies ***** ***** ***** "
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install soap
RUN docker-php-ext-configure pgsql --with-pgsql=/usr/include/postgresql/
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install zip
RUN docker-php-ext-install xml

RUN chmod +x -R /tmp/src/

EXPOSE 80
EXPOSE 9000

WORKDIR /var/www/

RUN echo "[ ***** ***** ***** ] - Begin of Actions inside Image ***** ***** ***** "
CMD /tmp/src/actions/start.sh