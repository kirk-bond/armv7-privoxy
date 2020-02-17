  
#
# Dockerfile for privoxy
#

FROM arm32v7/alpine
MAINTAINER kirk

RUN set -xe \
    && apk add -U curl privoxy \
    && apk del curl \
    && rm -rf /var/cache/apk/*

RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
           -e '/^accept-intercepted-requests/s/0/1/' \
           -e '/^enforce-blocks/s/0/1/' \
           -e '/^#debug/s/#//' /etc/privoxy/config

VOLUME /etc/privoxy

EXPOSE 8118

CMD sudo -u privoxy privoxy --no-daemon /etc/privoxy/config