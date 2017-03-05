FROM flitzfiete/nginx
RUN apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                       git-core fcgiwrap \
        && rm -rf /var/lib/apt/lists/*

COPY fcgiwrap.conf /etc/supervisor/conf.d/
WORKDIR /var/www
VOLUME ["/var/log", "/etc/nginx/conf.d"]
EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
