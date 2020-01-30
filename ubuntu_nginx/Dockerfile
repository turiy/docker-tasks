FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt-get autoremove
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd php7.3-imagick php7.3-cli php7.3-dev php7.3-imap php7.3-mbstring php7.3-soap php7.3-zip php7.3-bcmath git unzip -y
RUN apt-get install apache2 nginx -y
RUN sed -i 's+/run/php/php7.3-fpm.sock+127.0.0.1:9000+g' /etc/php/7.3/fpm/pool.d/www.conf
COPY nginx-site.conf /etc/nginx/sites-enabled/default
COPY entrypoint.sh /etc/entrypoint.sh

COPY --chown=www-data:www-data . /var/www/mysite
COPY --chown=www-data:www-data php /run/php

WORKDIR /var/www/mysite

EXPOSE 80 443

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
