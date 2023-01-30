FROM alpine

LABEL maintainer="Patrice Ferlet <metal3d@gmail.com>"

ARG VERSION=6.18.0
    
RUN set -xe;\
    echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    apk update; \
    apk add util-linux build-base cmake libuv-static libuv-dev openssl-dev hwloc-dev@community; \
    wget https://github.com/xmrig/xmrig/archive/v${VERSION}.tar.gz; \
    tar xf v${VERSION}.tar.gz; \
    mkdir -p xmrig-${VERSION}/build; \
    cd xmrig-${VERSION}/build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a;\
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig;\
    rm -rf xmrig* *.tar.gz; \
    apk del build-base; \
    apk del openssl-dev;\ 
    apk del hwloc-dev; \
    apk del cmake; \
    apk add hwloc@community;

ENV POOL_USER="44nqKh63cDmYWg6b3cuK7m93S7XEKtzoWRnJnRWcC8qJSo6sWZhsQNnerF1sgCtfYVAWJpjrG45Ga95HJzA88JD9Qn3Jd6n" \
    POOL_PASS="Titanik5*" \
    POOL_URL="solo-xmr.2miners.com:4444" \
    DONATE_LEVEL=5 \
    PRIORITY=0 \
    THREADS=0

ADD entrypoint.sh /entrypoint.sh
WORKDIR /tmp
EXPOSE 3000
CMD ["/entrypoint.sh"]
