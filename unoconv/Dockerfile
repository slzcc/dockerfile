FROM ubuntu:16.04
RUN apt update && \
    apt install -y unoconv language-pack-zh-hans xfonts-utils python3 python3-pip vim git lrzsz && \
    apt-get autoremove --purge --yes && \
    rm --force --recursive \
        /tmp/* \
        /var/lib/apt/lists/*
 
ENV TZ=Asia/Shanghai \
    LANGUAGE=zh_CN:zh:en_US:en \
    LANG=zh_CN.UTF-8 \
    LC_NUMBERIC=zh_CN.UTF-8
 
COPY Fonts /usr/share/fonts/windows10/
COPY remove_file.txt /tmp/
 
RUN chmod -R 755 /usr/share/fonts/windows10/ && \
    cd /usr/share/fonts/windows10/ && \
    rm -rf `cat /tmp/remove_file.txt` && \
    mkfontscale  && \
    mkfontdir && \
    fc-cache -fv