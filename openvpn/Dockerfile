FROM armhf/debian:jessie

RUN apt-get update \
    && apt-get install -y openvpn iptables \
    && rm -rf /var/lib/apt/lists/*

ADD openvpn.sh /root/openvpn.sh
RUN chmod +x /root/openvpn.sh
RUN sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
VOLUME /etc/openvpn
EXPOSE 1194/udp

CMD ["/root/openvpn.sh"]
