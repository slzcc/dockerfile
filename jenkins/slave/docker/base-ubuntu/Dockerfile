FROM ubuntu:20.04 as PYTHON

RUN apt update && apt install -y gcc make openssl g++ wget zlib1g-dev libssl-dev

RUN wget -qO- https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz | tar zx -C /tmp && \
    cd /tmp/Python-3.8.7 && \
    ./configure --prefix=/opt/python3 && \
    make -j8 && make install

FROM docker:20.10.2 as DockerCli

# https://github.com/jenkinsci/docker-inbound-agent/releases
FROM jenkins/inbound-agent:4.6-1 as JNLP

FROM slzcc/java:java-jdk-1.8.0.201 AS JDK

FROM ubuntu:20.04

USER root

# install Base Tools
RUN apt update && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y apt-utils jq telnet curl wget git unzip vim bind9-utils git-lfs inetutils-ping fontconfig \
    fonts-dejavu fonts-dejavu-extra fonts-noto-cjk-extra fonts-noto-cjk fonts-baekmuk zlib1g-dev libssl-dev locales && \
    fc-cache --force && \
    locale-gen en_US.UTF-8 && \
    apt autoremove --purge -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# install Kubectl
# RUN wget -qO- https://dl.k8s.io/v1.20.2/kubernetes-client-linux-amd64.tar.gz | tar zx -C /tmp/ && \
#     mv /tmp/kubernetes/client/bin/kubectl /usr/local/bin/

# install Sonar Scanner Cli
# RUN wget -qO- https://mirror.shileizcc.com/SonarQube/sonar-scanner-cli-3.0.3.778.zip > /tmp/sonar-scanner-cli-3.0.3.778.zip && \
#     unzip -d /tmp/ /tmp/sonar-scanner-cli-3.0.3.778.zip && \
#     mv /tmp/sonar-scanner-3.0.3.778/bin/* /usr/local/bin/ 

# install Maven
RUN wget -qO- http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar zx -C /opt/ && \
    ln -sf /opt/apache-maven-3.6.3/bin/mvn /usr/local/bin/

# install nodejs
RUN wget -qO- https://nodejs.org/dist/v15.6.0/node-v15.6.0-linux-x64.tar.gz | tar zx -C /opt/ && \
    ln -sf /opt/node-v15.6.0-linux-x64/bin/node /usr/bin/node && \
    ln -sf /opt/node-v15.6.0-linux-x64/bin/npm /usr/bin/npm

# install Jenkins slave Plugin
COPY --from=JNLP /usr/local/bin/jenkins-slave /usr/local/bin/
COPY --from=JNLP /usr/share/jenkins/slave.jar /usr/share/jenkins/slave.jar
# install Docker Cli
COPY --from=DockerCli /usr/local/bin/docker /usr/local/bin
# install Java JDK
COPY --from=JDK /jdk1.8.0_201 /usr/local/jdk
# install Python3
COPY --from=PYTHON /opt/python3 /opt/python3

ENV TZ="Asia/Shanghai" \
    LC_ALL="en_US.UTF-8" \
    LANG=en_US.UTF-8 \
    MAVEN_VERSION=3.6.3 \
    MAVEN_HOME=/opt/apache-maven-3.6.3 \
    JAVA_HOME=/usr/local/jdk \
    JAVA_BIN=/usr/local/jdk/bin \
    JRE_HOME=/usr/local/jdk/jre \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/python3/bin

# Custom
RUN curl -sSLf https://bootstrap.pypa.io/get-pip.py | /opt/python3/bin/python3 && \
    ln -sf /usr/local/jdk/bin/* /usr/bin/ && \
    ln -sf /opt/python3/bin/python3 /usr/bin/python3 && \
    rm -rf /tmp/*

ENTRYPOINT ["/sbin/tini" "--" "/usr/local/bin/jenkins-slave"]