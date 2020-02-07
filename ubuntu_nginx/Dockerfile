FROM ubuntu:18.04
RUN apt-get update && apt-get install software-properties-common -y && add-apt-repository ppa:ondrej/php && \
apt-get install nginx php7.3-fpm -y && rm -rf /var/lib/apt/lists/* && DEBIAN_FRONTEND=noninteractive apt-get autoremove && \
mkdir /run/php && chown www-data:www-data /run/php && \
#sed -i 's+/run/php/php7.3-fpm.sock+127.0.0.1:9000+g' /etc/php/7.3/fpm/pool.d/www.conf


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo Europe/Kiev > /etc/timezone

COPY nginx-site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /etc/entrypoint.sh

COPY --chown=www-data:www-data web /var/www/mysite/web/


WORKDIR /var/www/mysite

EXPOSE 80 443

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
