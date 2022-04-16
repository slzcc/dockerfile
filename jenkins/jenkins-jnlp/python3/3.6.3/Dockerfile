FROM slzcc/jenkins-slave:ubuntu-jnlp

RUN apt update && \
    apt install -y git ldap-utils libffi-dev && \
    apt install -y fonts-baekmuk ttf-baekmuk fonts-nanum language-pack-zh-hans jq telnet && \
    apt autoremove --purge -y python3 && \
    locale-gen en_US.UTF-8 && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean

RUN wget -qO- https://mirror.shileizcc.com/Python/src/Python-3.6.3.tgz | tar zx -C /opt && \
    cd /opt/Python-3.6.3 && \
    ./configure --prefix=/usr/local/python3 && \
    make -j8 && make install

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/python3/bin/