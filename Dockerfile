FROM php:7.0-apache
COPY index.php /var/www/html/index.php
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/*
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf.d/*

EXPOSE 8080
