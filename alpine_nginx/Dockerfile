FROM alpine
RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && mkdir /run/nginx && mkdir /home/nginx \
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && chown nginx:nginx /run/nginx && chown nginx:nginx /home/nginx
RUN apk update --no-cache && apk upgrade --no-cache && apk add php7 php7-fpm nginx --no-cache && chown -R nginx:nginx /var/log/nginx && chown -R nginx:nginx /run/nginx

RUN mkdir -p /etc/nginx /etc/nginx/sites-available /etc/nginx/sites-enabled /run/nginx && sed -i 's/nobody/nginx/g' /etc/php7/php-fpm.d/www.conf \
 && touch /var/log/php7/error.log && chown nginx:nginx /var/log/php7/error.log
COPY --chown=nginx:nginx entrypoint.sh /etc/entrypoint.sh
COPY --chown=nginx:nginx nginx-site.conf /etc/nginx/conf.d/default.conf

COPY --chown=nginx:nginx web /var/www/mysite/web/

EXPOSE 80 443
#USER nginx
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
