FROM armhf/debian:jessie
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib" > /etc/apt/sources.list.d/backports.list \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                certbot -t jessie-backports \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/letsencrypt
