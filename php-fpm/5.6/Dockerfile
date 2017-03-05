FROM armhf/debian:jessie
RUN mkdir /var/www \
        && chown -R www-data:www-data /var/www \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
              ca-certificates gettext-base supervisor wget php5-mysqlnd php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-intl php5-pspell php5-recode \
              php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-fpm \
        && rm -rf /var/lib/apt/lists/* \
        && sed -i '/listen = \/var\/run\/php5-fpm.sock/c\listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
WORKDIR /var/www
VOLUME ["/var/log"]
EXPOSE 9000

CMD ["/usr/bin/supervisord"]
