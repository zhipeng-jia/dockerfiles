FROM debian:buster-slim as build
RUN apt update && apt upgrade -y && apt install -y build-essential wget

ARG VERSION=1.35.0

WORKDIR /tmp
RUN wget https://github.com/aria2/aria2/releases/download/release-$VERSION/aria2-$VERSION.tar.xz && \
    tar -xJf aria2-$VERSION.tar.xz && rm aria2-$VERSION.tar.xz

RUN apt install -y libssl-dev libxml2-dev libssh2-1-dev libc-ares-dev zlib1g-dev pkg-config

WORKDIR /tmp/aria2-$VERSION
ENV CFLAGS="-O3 -flto"
ENV CXXFLAGS="-O3 -flto"
RUN ./configure \
    --prefix=/usr/local \
    --with-libcares \
    --without-gnutls \
    --with-openssl \
    --without-sqlite3 \
    --with-libxml2 \
    --without-libexpat \
    --with-libz \
    --without-libgmp \
    --with-libssh2 \
    --without-libgcrypt \
    --without-libnettle
RUN make -j $(nproc) install

FROM debian:buster-slim as release
RUN apt update && apt upgrade -y
RUN apt install -y libssl1.1 libxml2 libssh2-1 libc-ares2
COPY --from=build /usr/local/bin/aria2c /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/aria2c"]
