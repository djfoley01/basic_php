FROM factory:8081/docker-local/rhel7-httpd:latest
COPY index.php /var/www/html/index.php
RUN chmod 777 /var/run/* -R && chmod 777 /var/log/* -R

EXPOSE 8080
