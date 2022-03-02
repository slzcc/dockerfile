FROM docker:20.10.8 as DockerCli

FROM slzcc/sshd:ubuntu-20.04

RUN wget -qO- https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz | tar zx -C /

COPY slave.jar /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

COPY --from=DockerCli /usr/local/bin/docker /usr/local/bin

COPY settings.xml /apache-maven-3.8.4/conf/settings.xml

WORKDIR /home/jenkins

RUN wget -qO- https://mirror.shileizcc.com/JDK/jdk-8u201-linux-x64.tar.gz | tar zx -C /

RUN ln -sf /jdk1.8.0_201 /usr/local/jdk &&  \
    ln -sf /jdk1.8.0_201/bin/java /usr/bin/ && \
    ln -sf /apache-maven-3.8.4/bin/mvn /usr/bin/

RUN apt-get update && \
    apt-get install -y git unzip curl wget jq make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV MAVEN_VERSION=3.8.4 \
    MAVEN_HOME=/apache-maven-3.8.4 \
    LANGUAGE=en_US:en \
    LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    JAVA_HOME=/usr/local/jdk \
    JAVA_BIN=/usr/local/jdk/bin \
    JRE_HOME=/usr/local/jdk/jre

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]