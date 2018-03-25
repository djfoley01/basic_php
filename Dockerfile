FROM rhel7

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd php && \
    yum clean all

EXPOSE 8080

# Simple startup script to avoid some issues observed with container restart
COPY run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && sed -i 's/index.html/index.html index.php/g' /etc/httpd/conf/httpd.conf
COPY index.php /var/www/html/index.php
CMD ["/run-httpd.sh"]
