FROM armhf/debian:jessie
ENV PHP_VERSION 7.1.1
RUN mkdir /var/www \
        && chown -R www-data:www-data /var/www \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                       ca-certificates gettext-base supervisor wget build-essential autoconf libfcgi-dev libfcgi0ldbl libjpeg62-turbo-dbg libmcrypt-dev libssl-dev libc-client2007e libc-client2007e-dev \
                       libxml2-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev libfreetype6-dev libkrb5-dev libpq-dev libxml2-dev libxslt1-dev \
        && rm -rf /var/lib/apt/lists/* \
        && ln -s /usr/lib/libc-client.a /usr/lib/arm-linux-gnueabihf/libc-client.a \
        && cd /tmp \
        && wget http://de1.php.net/get/php-${PHP_VERSION}.tar.bz2/from/this/mirror -O php-${PHP_VERSION}.tar.bz2 \
        && tar jxf php-${PHP_VERSION}.tar.bz2 \
        && cd php-${PHP_VERSION} \
        &&  ./configure --config-cache --prefix=/usr --sbindir=/usr/bin --sysconfdir=/etc/php --localstatedir=/var --with-config-file-path=/etc/php --with-config-file-scan-dir=/etc/php/conf.d --with-pdo-pgsql \
        --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath \
        --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip \
        --with-pcre-regex --with-pdo-mysql --with-mysqli --with-mysql-sock=/var/run/mysqld/mysqld.sock --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=www-data \
        --with-fpm-group=www-data --with-libdir=/lib/arm-linux-gnueabihf --enable-ftp --with-imap --with-imap-ssl --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm \
        && make -j3 \
        && make install \
        && cd .. \
        && cp /tmp/php-${PHP_VERSION}/php.ini-production /etc/php/php.ini \
        && mv /etc/php/php-fpm.conf.default /etc/php/php-fpm.conf \
        && mv /etc/php/php-fpm.d/www.conf.default /etc/php/php-fpm.d/www.conf \
        && sed -i '/listen = 127.0.0.1:9000/c\listen = 0.0.0.0:9000' /etc/php/php-fpm.d/www.conf \
        && echo "zend_extension=opcache.so" >> /etc/php/php.ini \
        && rm -rf php-${PHP_VERSION}*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www
VOLUME ["/var/log"]
EXPOSE 9000

CMD ["/usr/bin/supervisord"]
