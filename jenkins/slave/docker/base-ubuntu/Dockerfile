FROM slzcc/java:java-jdk-1.8.0.201 AS JDK

FROM ubuntu:20.04

LABEL AuthorEmail 383821949@qq.com \
      Domain Shileizcc.com \
      CreateTime 2021年 01月 31日 星期日

ARG AGENT_VERSION=4.6

RUN apt update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install openjdk-8-jdk -y && \
    apt install -y gcc make jq telnet curl wget git lrzsz unzip vim maven npm nodejs dnsutils vim git-lfs \
    fonts-dejavu fonts-dejavu-extra fonts-noto-cjk-extra fonts-noto-cjk fonts-baekmuk \
    fonts-nanum language-pack-zh-hans vim fontconfig supervisor libcurl4-openssl-dev \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache --force && \
    apt autoremove --purge -y python3 python3-pip && \
    locale-gen en_US.UTF-8 && \
    apt clean

# install Maven
RUN wget -qO- http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar zx -C /opt && \
    ln -sf /opt/apache-maven-3.6.3/bin/mvn /usr/local/bin/

RUN wget -qO- https://download.docker.com/linux/static/stable/x86_64/docker-20.10.0.tgz | tar zx -C /tmp && \
    mv /tmp/docker/bin/docker /bin/docker && \
    rm -rf /tmp/docker

RUN wget -qO- https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz | tar zx -C /tmp && \
    cd /tmp/Python-3.8.7 && \
    ./configure --prefix=/usr/local/python3 && \
    make -j8 && make install && \
    rm -rf /tmp/*

RUN wget -qO- https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 > /sbin/tini && \
    chmod +x /sbin/tini

# https://github.com/jenkinsci/remoting/releases
RUN curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${AGENT_VERSION}/remoting-${AGENT_VERSION}.jar && \
    chmod 755 /usr/share/jenkins && \
    chmod 644 /usr/share/jenkins/agent.jar && \
    ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN npm install n -g && n stable

ENV ENV TZ="Asia/Shanghai" \
    M2_HOME=/opt/apache-maven-3.6.3 \
    LC_ALL="en_US.UTF-8" \
    LANG=en_US.UTF-8 \
    MAVEN_VERSION=3.3.9 \
    MAVEN_HOME=/usr/share/maven \
    JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/python3/bin/

ENTRYPOINT ["/sbin/tini" "--" "/usr/local/bin/jenkins-slave"]