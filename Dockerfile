FROM php:7.4-apache

RUN apt-get update && apt-get install -y git imagemagick

RUN a2enmod rewrite
RUN docker-php-ext-install mysqli exif

RUN git clone --recurse-submodules --single-branch https://github.com/omeka/Omeka.git /var/www/html

RUN mv application/config/config.ini.changeme /var/www/html/application/config/config.ini
RUN mv .htaccess.changeme .htaccess

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R g+w /var/www/html/files
