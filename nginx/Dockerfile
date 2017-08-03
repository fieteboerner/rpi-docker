FROM arm32v7/debian:stretch
ENV NGINX_VERSION 1.13.3
ENV OPENSSL_VERSION OpenSSL_1_1_0f
# install and setup general
RUN mkdir /var/www \
        && chown -R www-data:www-data /var/www \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                       ca-certificates nginx gettext-base wget build-essential libpcre3 libpcre3-dev openssl zlib1g zlib1g-dev \
                       libxslt-dev libgd2-xpm-dev libgeoip-dev libssl-dev \
        && apt-get clean
# build nginx
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
        && tar xzf nginx-${NGINX_VERSION}.tar.gz \
        && cd nginx-${NGINX_VERSION} \
        && ./configure --conf-path=/etc/nginx/nginx.conf --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module \
                --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module \
                --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail \
                --with-mail_ssl_module --with-threads --with-http_realip_module \
        && make -j3 \
        && make install \
        && ln -fs /usr/local/nginx/sbin/nginx /usr/sbin/nginx \
        && rm /etc/nginx/modules-enabled/* \
        && cd .. \
        && rm -rf nginx-${NGINX_VERSION}*

WORKDIR /var/www
VOLUME ["/var/log", "/etc/nginx/conf.d"]
EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
