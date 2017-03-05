FROM armhf/debian:jessie
ENV NGINX_VERSION 1.11.0
ENV OPENSSL_VERSION OpenSSL_1_0_2k
RUN mkdir /var/www \
        && chown -R www-data:www-data /var/www \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                       ca-certificates nginx gettext-base supervisor wget build-essential libpcre3 libpcre3-dev openssl zlib1g zlib1g-dev \
                       libxslt-dev libgd2-xpm-dev libgeoip-dev \
        && rm -rf /var/lib/apt/lists/* \
        && cd /usr/local/src \
        && wget https://github.com/openssl/openssl/archive/${OPENSSL_VERSION}.tar.gz \
        && tar xzf ${OPENSSL_VERSION}.tar.gz \
        && mv openssl-${OPENSSL_VERSION} openssl \
        && cd \
        && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
        && tar xzf nginx-${NGINX_VERSION}.tar.gz \
        && cd nginx-${NGINX_VERSION} \
        && ./configure --conf-path=/etc/nginx/nginx.conf --with-openssl=/usr/local/src/openssl --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module \
                --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module \
                --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail \
                --with-mail_ssl_module --with-threads --with-http_realip_module \
        && make -j3 \
        && make install \
        && ln -fs /usr/local/nginx/sbin/nginx /usr/sbin/nginx \
        && cd .. \
        && rm -rf nginx-${NGINX_VERSION}* \
        && rm -rf /usr/local/src/openssl

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www
VOLUME ["/var/log", "/etc/nginx/conf.d"]
EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
