ARG NGINX_VERSION=1.17.9
FROM nginx:${NGINX_VERSION}-alpine as builder

# Download sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \
    wget "https://github.com/aperezdc/ngx-fancyindex/releases/download/v0.4.4/ngx-fancyindex-0.4.4.tar.xz" -O ngx-fancyindex.tar.xz

# For latest build deps, see https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile
RUN  apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \
    libedit-dev \
    mercurial \
    bash \
    alpine-sdk \
    findutils \
    xz

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN rm -rf /usr/src/nginx /usr/src/extra_module && mkdir -p /usr/src/nginx /usr/src/extra_module && \
    tar -xzC /usr/src/nginx -f nginx.tar.gz && \
    tar -xJC /usr/src/extra_module -f ngx-fancyindex.tar.xz

WORKDIR /usr/src/nginx/nginx-${NGINX_VERSION}

# Reuse same cli arguments as the nginx:alpine image used to build
RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') && \
    sh -c "./configure --with-compat $CONFARGS --add-dynamic-module=/usr/src/extra_module/*" && \
    make modules

FROM nginx:${NGINX_VERSION}-alpine
COPY --from=builder /usr/src/nginx/nginx-${NGINX_VERSION}/objs/*_module.so /etc/nginx/modules/
RUN sed -i '1s/^/load_module "modules\/ngx_http_fancyindex_module.so";\n/' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
