FROM alpine:3.11 as build

RUN apk --no-cache add ca-certificates wget

ARG VERSION=4.35.1
ARG SHA256=6bb16db10e362c1a14bdd1450d72d0eca51e6ff41eb366129dcefbbf789941c5

WORKDIR /tmp
RUN echo "$SHA256 *v2ray-linux-64.zip" > checksum && \
    wget https://github.com/v2fly/v2ray-core/releases/download/v$VERSION/v2ray-linux-64.zip && \
    sha256sum -cs checksum && \
    mkdir v2ray && unzip v2ray-linux-64.zip -d v2ray

FROM alpine:3.11 as release
RUN mkdir -p /usr/local/v2ray /etc/v2ray
COPY --from=build /tmp/v2ray/v2ray /usr/local/v2ray/
COPY --from=build /tmp/v2ray/v2ctl /usr/local/v2ray/
COPY --from=build /tmp/v2ray/geoip.dat /usr/local/v2ray/
COPY --from=build /tmp/v2ray/geosite.dat /usr/local/v2ray/
COPY --from=build /tmp/v2ray/config.json /etc/v2ray/
WORKDIR /usr/local/v2ray
ENTRYPOINT ["/usr/local/v2ray/v2ray"]
CMD ["-c", "/etc/v2ray/config.json"]
