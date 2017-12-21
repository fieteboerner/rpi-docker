FROM arm32v7/debian:stretch
RUN  apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                libssl1.0 mumble-server \
        && apt-get clean \
        && mkdir /data \
        && chown mumble-server:mumble-server /data

WORKDIR /data
VOLUME ["/data"]
EXPOSE 64738 64738/udp

CMD ["murmurd", "-fg", "-ini", "/etc/mumble-server.ini"]
