FROM alpine
ARG PHP_V=7

ENV ADD_REQ wget nginx composer curl

ENV uName nginx
ENV uGroup nginx
ENV TIMEZONE="Europe/Kiev"

RUN set -x \
    && echo "${TIMEZONE}" > /etc/timezone \
    && mkdir /run/nginx && mkdir /home/${uName} \
    && addgroup -g 101 -S ${uGroup} \
    && adduser -S -D -H -u 101 -h /var/cache/${uName} -s /sbin/nologin -G ${uGroup} -g ${uGroup} ${uName} \
    && chown -R ${uGroup}:${uName} /run/nginx && chown -R ${uGroup}:${uName}  /home/${uName} && chown -R ${uGroup}:${uName}  /run/nginx

COPY --chown=${uGroup}:${uName} nginx-drupal.conf /etc/nginx/nginx.conf

ENV PHP_REQ php php${PHP_V}-fpm \
 php${PHP_V}-common php${PHP_V}-openssl \
 php${PHP_V}-mysqli php${PHP_V}-json \
 php${PHP_V}-curl php${PHP_V}-session \
 php${PHP_V}-pdo  php${PHP_V}-pdo_mysql \
 php${PHP_V}-dom php${PHP_V}-simplexml \
 php${PHP_V}-xml php${PHP_V}-xmlrpc php${PHP_V}-tokenizer \ 
 php${PHP_V}-common  php${PHP_V}-opcache \
 php${PHP_V}-mbstring  php${PHP_V}-gd


RUN apk update && apk add --no-cache ${ADD_REQ} ${PHP_REQ} && rm -rf /var/cache/apk/*
RUN mkdir -p /etc/nginx /etc/nginx/sites-available /etc/nginx/sites-enabled /run/nginx && chown -R ${uGroup}:${uName}  /var/log/* && sed -i 's/nobody/nginx/g' /etc/php${PHP_V}/php-fpm.d/www.conf

RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php-fpm.d/www.conf && \
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/bin --filename=composer


RUN  cd /var/www/ && wget https://ftp.drupal.org/files/projects/drupal-8.8.2.tar.gz \
  && tar zxvf drupal*  && rm *.tar.gz && mv drupal* drupal \
  && cd drupal && composer install --no-progress --profile --prefer-dist \
  && chown -R ${uGroup}:${uName} /var/www/drupal
#cp  drupal/sites/default/default.settings.php drupal/sites/default/settins.php 
COPY --chown=${uGroup}:${uName} entrypoint.sh /etc/entrypoint.sh

EXPOSE 8080 443 9000
USER ${uName}
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
