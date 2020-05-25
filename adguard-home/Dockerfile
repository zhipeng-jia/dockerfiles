FROM alpine:3.11 as build

RUN apk --no-cache add ca-certificates wget

ARG VERSION=0.101.0

WORKDIR /tmp
RUN wget https://github.com/AdguardTeam/AdGuardHome/releases/download/v$VERSION/AdGuardHome_linux_amd64.tar.gz && \
    tar -xzf AdGuardHome_linux_amd64.tar.gz

FROM alpine:3.11 as release
RUN apk --no-cache --update add ca-certificates
RUN mkdir -p /opt/adguardhome/work
COPY --from=build /tmp/AdGuardHome/AdGuardHome /usr/local/bin/
VOLUME ["/opt/adguardhome/conf"]
ENTRYPOINT ["/usr/local/bin/AdGuardHome"]
CMD ["-c", "/opt/adguardhome/conf/AdGuardHome.yaml", "-w", "/opt/adguardhome/work"]
