FROM alpine
RUN apk update --no-cache && apk upgrade --no-cache && apk add php7 php7-fpm nginx --no-cache && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/nginx /etc/nginx/sites-available /etc/nginx/sites-enabled /run/nginx

COPY entrypoint.sh /etc/entrypoint.sh
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

COPY --chown=nginx:nginx web /var/www/mysite/web/

EXPOSE 80 443

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
