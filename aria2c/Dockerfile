FROM debian:buster-slim

# install runtime dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		libssl1.1 \
		libxml2 \
		libc-ares2 \
	; \
	rm -rf /var/lib/apt/lists/*

ARG ARIA2_VERSION=1.36.0

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		build-essential \
		wget \
		libssl-dev \
		libxml2-dev \
		libc-ares-dev \
		zlib1g-dev \
		pkg-config \
	; \
	rm -r /var/lib/apt/lists/*; \
	\
	cd /tmp; \
	wget https://github.com/aria2/aria2/releases/download/release-$ARIA2_VERSION/aria2-$ARIA2_VERSION.tar.xz; \
	tar -xJf aria2-$ARIA2_VERSION.tar.xz; \
	rm aria2-$ARIA2_VERSION.tar.xz; \
	\
	cd aria2-$ARIA2_VERSION; \
	./configure \
		--prefix=/usr/local \
		--with-libcares \
		--without-gnutls \
		--with-openssl \
		--without-sqlite3 \
		--with-libxml2 \
		--without-libexpat \
		--with-libz \
		--without-libgmp \
		--without-libssh2 \
		--without-libgcrypt \
		--without-libnettle \
		CFLAGS="-O3 -flto" \
		CXXFLAGS="-O3 -flto" \
	; \
	make -j "$(nproc)"; \
	make install; \
	\
	cd ..; \
	rm -r aria2-$ARIA2_VERSION; \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	find /usr/local -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { print $(NF-1) }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		| xargs -r apt-mark manual \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;

ENTRYPOINT ["/usr/local/bin/aria2c"]
CMD ["--conf-path", "/etc/aria2/aria2.conf"]
