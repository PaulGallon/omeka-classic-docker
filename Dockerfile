FROM php:7.4-apache

RUN apt-get update && apt-get install -y git imagemagick gettext-base

RUN a2enmod rewrite
RUN docker-php-ext-install mysqli exif

RUN git clone --recurse-submodules \
  --single-branch --branch v3.0.1 \
  https://github.com/omeka/Omeka.git \
  /var/www/html

RUN mv application/config/config.ini.changeme /var/www/html/application/config/config.ini
RUN mv .htaccess.changeme .htaccess

ENV OMEKA_DB_HOST localhost
ENV OMEKA_DB_USERNAME omeka
ENV OMEKA_DB_PASSWORD omeka
ENV OMEKA_DB_NAME omeka
ENV OMEKA_DB_PREFIX _omeka
ENV OMEKA_DB_CHARSET utf8
ENV OMEKA_DB_PORT 3306

COPY db.ini.changeme /var/www/html/db.ini.changeme
COPY docker-omeka-entrypoint /usr/local/bin/

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R g+w /var/www/html/files

ENTRYPOINT ["docker-omeka-entrypoint"]
CMD ["apache2-foreground"]
