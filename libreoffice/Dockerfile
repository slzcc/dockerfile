FROM ubuntu:16.04
 
RUN apt update && \
    apt-get install -y software-properties-common &&   \
    add-apt-repository ppa:openjdk-r/ppa &&  \
    apt-get update &&   \
    apt-get install -y openjdk-8-jdk libreoffice language-pack-zh-hans fonts-wqy-microhei fonts-wqy-zenhei wget && \
    apt-get autoremove --purge --yes && \
    rm --force --recursive \
        /tmp/* \
        /var/lib/apt/lists/*
 
ENV TZ=Asia/Shanghai \
    LANGUAGE=zh_CN:zh:en_US:en \
    LANG=zh_CN.UTF-8 \
    LC_NUMBERIC=zh_CN.UTF-8 \
    JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/