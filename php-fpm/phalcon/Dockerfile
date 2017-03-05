FROM flitzfiete/php-fpm:5.6
ENV PHALCON_VERSION 1.3.3
COPY phalcon.ini /etc/php5/mods-avalable/
RUN apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                      git-core php5-dev build-essential \
        && git clone -q --depth=1 https://github.com/phalcon/cphalcon.git -b ${PHALCON_VERSION} \
        && cd cphalcon/ext \
        && phpize \
        && ./configure --enable-phalcon \
        && make -j4 \
        && make install \
        && cd ../.. \
        && rm -rf cphalcon \
        && rm -rf /var/lib/apt/lists/* \
        && ln -s /etc/php5/mods-avalable/phalcon.ini /etc/php5/fpm/conf.d/20-phalcon.ini

WORKDIR /var/www
VOLUME ["/var/log"]
EXPOSE 9000

CMD ["/usr/bin/supervisord"]
