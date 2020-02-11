#!/bin/sh

# Start the first process
php-fpm7
nginx -g "daemon off;"
