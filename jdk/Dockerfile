FROM ubuntu:16.04
 
ADD https://mirror.shileizcc.com/JDK/jdk-8u201-linux-x64.tar.gz /tmp
RUN tar zxf /tmp/jdk-8u201-linux-x64.tar.gz -C /
 
ENV JAVA_HOME=/usr/local/jdk \
    JAVA_BIN=/usr/local/jdk/bin \
    JRE_HOME=/usr/local/jdk/jre
 
RUN ln -sf /jdk1.8.0_201 /usr/local/jdk &&  \
    ln -sf /jdk1.8.0_201/bin/java /usr/bin/