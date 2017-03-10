FROM armhf/debian:jessie

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

ADD noip.sh /root/noip/noip.sh
RUN chmod +x /root/noip/noip.sh

CMD ["/root/noip/noip.sh"]
