FROM alpine
RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && mkdir /run/nginx && mkdir /home/nginx \
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && chown nginx:nginx /run/nginx && chown nginx:nginx /home/nginx
RUN apk update --no-cache && apk upgrade --no-cache && apk add php7 php7-fpm nginx --no-cache && chown -R nginx:nginx /var/log/nginx && chown -R nginx:nginx /run/nginx
ENV PHP_V 7
ENV SOFT nginx wget

ENV PHP_MOD php${PHP_V}-fpm \
 php${PHP_V}-common \
 php${PHP_V}-mysqli \
 php${PHP_V}-json \
 php${PHP_V}-openssl \
 php${PHP_V}-curl \
 php${PHP_V}-session \
 php${PHP_V}-pdo \
 php${PHP_V}-pdo_mysql \
 php${PHP_V}-dom \
 php${PHP_V}-simplexml \
 php${PHP_V}-xml \
 php${PHP_V}-xmlrpc \
 php${PHP_V}-tokenizer \
 php${PHP_V}-common \
 php${PHP_V}-opcache \
 php${PHP_V}-mbstring \
 php${PHP_V}-gd

RUN mkdir -p /etc/nginx /etc/nginx/sites-available /etc/nginx/sites-enabled /run/nginx && sed -i 's/nobody/nginx/g' /etc/php7/php-fpm.d/www.conf \
 && touch /var/log/php7/error.log && chown nginx:nginx /var/log/php7/error.log
COPY --chown=nginx:nginx entrypoint.sh /etc/entrypoint.sh
COPY --chown=nginx:nginx nginx-drupal.conf /etc/nginx/nginx.conf

RUN apk update \
  && apk --no-cache add ${SOFT} ${PHP_MOD}

RUN mkdir -p /usr/share/webapps/ \
  && cd /usr/share/webapps \
  && wget https://ftp.drupal.org/files/projects/drupal-8.8.2.tar.gz \
  && tar zxvf drupal* \
  && rm *.tar.gz \
  && mv drupal* drupal \
  && chown -R nginx:nginx /usr/share/webapps \
  && cp  /usr/share/webapps/drupal/sites/default/default.settings.php /usr/share/webapps/drupal/sites/default/settings.php \
  && mkdir /var/www/mysite && chown nginx:nginx /var/www/mysite \
  && ln -s /usr/share/webapps/drupal /var/www/mysite/ 
  
#COPY --chown=nginx:nginx web /var/www/mysite/web/

EXPOSE 80 443
#USER nginx
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
