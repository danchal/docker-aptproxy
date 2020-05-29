FROM lsiobase/ubuntu:bionic

ENV TERM=xterm

RUN apt-get update;
RUN apt-get install --no-install-recommends --yes \
	apt-cacher-ng \
    ca-certificates \
    wget \
	avahi-daemon \
    libnss-mdns;
RUN rm -rf /var/lib/apt/lists/*;

EXPOSE 3142/tcp
EXPOSE 5353/udp
VOLUME ["/data"]

ENV APTPROXY_OPTIONS=

COPY entrypoint.sh /
RUN  chmod +x /entrypoint.sh;

HEALTHCHECK --interval=30s --timeout=2s --retries=3 \
    CMD wget --quiet --spider http://localhost:3142/acng-report.html || exit 1

ENTRYPOINT ["/entrypoint.sh"]
