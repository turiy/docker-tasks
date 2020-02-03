FROM centos:7

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo "Europe/Kiev" > /etc/timezone=
RUN yum update  -y && yum install epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y && yum clean all

RUN yum-config-manager --disable remi-php54 && yum-config-manager --enable remi-php73
RUN mkdir /run/php-fpm
RUN yum install php-fpm  nginx -y && yum clean all

COPY entrypoint.sh /etc/entrypoint.sh
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

COPY --chown=nginx:nginx web /var/www/mysite/web/
RUN chown nginx:nginx /run/php-fpm

WORKDIR /var/www/mysite

EXPOSE 80 443

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
