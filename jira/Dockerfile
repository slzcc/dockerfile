FROM ubuntu:18.04
 
LABEL AuthorEmail 383821949@qq.com \
      Domain Shileizcc.com \
      CreateTime 2020年 07月 30日 星期四
 
RUN apt update && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y net-tools openssh-server fonts-baekmuk fonts-nanum language-pack-zh-hans && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean
 
COPY atlassian /opt/atlassian
COPY application-data /var/atlassian/application-data
COPY *.sql /
COPY docker-entrypoint.sh /docker-entrypoint.sh
 
ENV TZ="Asia/Shanghai"
  
EXPOSE 8090 8000
  
CMD ["/docker-entrypoint.sh"]