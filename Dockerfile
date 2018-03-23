FROM php:7.0-apache
COPY index.php /var/www/html/index.php
RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf
RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/*
RUN chmod 777 /var/run/* -R && chmod 777 /var/log/* -R

EXPOSE 8080
