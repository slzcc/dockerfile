FROM harbor.ops.zhangyue-ops.com/public/centos:7.8.2003

ARG TENGINE_VERSION=2.3.2
ARG BASE_PATH=/opt
ARG LIBRARY_PATH=/$BASE_PATH/install
ARG SERVER_PATH=/$BASE_PATH/server
ARG LOG_PATH=/$BASE_PATH/logs

RUN curl http://upload.ops.zhangyue-ops.com/yum/set_nexus_catyum.sh|bash -x

RUN yum -y install gcc gcc-c++ bzip2 perl curl curl-devel expat-devel gettext-devel \
                   openssl-devel libxml2 libxml2-devel libjpeg-devel libpng-devel freetype-devel \
                   libmcrypt-devel autoconf libmcrypt libmcrypt-devel mcrypt mhash \
                   wget make cmake unzip

WORKDIR $LIBRARY_PATH

RUN wget -qO- http://192.168.7.24/libunwind-1.1.tar.gz | tar zx -C $LIBRARY_PATH && \
    cd $LIBRARY_PATH/libunwind-1.1 && ./configure && make -j32 && make install -j32 && \
    wget -qO- http://192.168.7.24/gperftools-2.1.tar.gz | tar zx -C $LIBRARY_PATH && \
    cd $LIBRARY_PATH/gperftools-2.1 && ./configure && make -j32 && make install -j32 && \
    wget -qO- http://192.168.7.24/LuaJIT-2.1.0.tar.gz | tar zx -C $LIBRARY_PATH && \
    cd $LIBRARY_PATH/LuaJIT-2.1.0 && make -j32 && make install -j32 && \
    wget -qO- http://upload.ops.zhangyue-ops.com/software/jemalloc/jemalloc-4.4.0.tar.bz2 | tar jx -C $LIBRARY_PATH && \
    cd $LIBRARY_PATH/jemalloc-4.4.0 && ./configure --prefix=/$SERVER_PATH/jemalloc && make -j32 && make install -j32 && \
    cd $LIBRARY_PATH/ && \
    wget -qO- http://192.168.7.24/lua-nginx-module-0.10.17.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://192.168.7.24/ngx_cache_purge-2.3.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://192.168.7.24/ngx_devel_kit-0.3.1.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://192.168.7.24/lua-upstream-nginx-module-master.zip > lua-upstream-nginx-module-master.zip && \
    wget -qO- http://192.168.7.24/tengine-$TENGINE_VERSION.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://upload.ops.zhangyue-ops.com/software/openssl/openssl-1.0.2j.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://upload.ops.zhangyue-ops.com/software/pcre/pcre-8.39.tar.gz | tar zx -C $LIBRARY_PATH && \
    wget -qO- http://upload.ops.zhangyue-ops.com/software/zlib/zlib-1.2.11.tar.gz | tar zx -C $LIBRARY_PATH && \
    unzip lua-upstream-nginx-module-master.zip

RUN echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig

ENV LUAJIT_LIB=/usr/local/lib \
    LUAJIT_INC=/usr/local/include/luajit-2.1

RUN cd tengine-$TENGINE_VERSION && \
    ./configure \
     --user=web \
     --group=web \
     --prefix=/$SERVER_PATH/tengine-$TENGINE_VERSION \
     --with-http_realip_module \
     --with-http_stub_status_module  \
     --with-http_ssl_module \
     --with-http_v2_module  \
     --with-http_gzip_static_module \
     --with-ld-opt='-ldl -ltcmalloc' \
     --with-google_perftools_module \
     --add-module=../ngx_cache_purge-2.3 \
     --add-module=../ngx_devel_kit-0.3.1 \
     --add-module=../lua-upstream-nginx-module-master \
     --add-module=./modules/ngx_http_reqstat_module \
     --add-module=./modules/ngx_http_sysguard_module \
     --add-module=./modules/ngx_http_upstream_dyups_module \
     --add-module=./modules/ngx_http_lua_module \
     --with-openssl=../openssl-1.0.2j/ \
     --with-pcre=../pcre-8.39/ \
     --with-zlib=../zlib-1.2.11 \
     --with-debug && \
     make -j32 && make install -j32

RUN mkdir -p $LOG_PATH/nginx && \ 
    ln -sf /dev/stderr $LOG_PATH/nginx/error.log && ln -sf /dev/stdout $LOG_PATH/nginx/access.log

RUN groupadd web \
    && useradd -d $SERVER_PATH/tengine-$TENGINE_VERSION -s /sbin/nologin -G web -g web web && \
    wget -qO- http://192.168.7.24/template/nginx.conf > $SERVER_PATH/tengine-$TENGINE_VERSION/conf/nginx.conf && \
    mkdir $SERVER_PATH/tengine-$TENGINE_VERSION/conf/{vhosts,upstream} && \
    chown -R web.web $BASE_PATH

ENV PATH=$SERVER_PATH/tengine-$TENGINE_VERSION/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    TENGINE_VERSION=$TENGINE_VERSION

USER web

WORKDIR $SERVER_PATH/tengine-$TENGINE_VERSION

CMD ["nginx", "-g", "daemon off;"]