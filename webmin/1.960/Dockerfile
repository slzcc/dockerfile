FROM ubuntu:18.04
 
WORKDIR /
 
RUN apt-get update && apt-get upgrade -y && \
    apt-get install apt-transport-https wget samba samba-common -y && \
    mkdir /media/storage /data /data/samba /data/webmin
 
VOLUME /data
 
RUN chmod -R 0777 /media/storage /data
 
RUN echo "deb https://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list && \
    cd /root && \
    wget http://www.webmin.com/jcameron-key.asc && \
    apt-key add jcameron-key.asc
 
RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes && \
    apt-get purge apt-show-versions -y && \
    rm /var/lib/apt/lists/*lz4 && \
    apt-get -o Acquire::GzipIndexes=false update -y
 
RUN apt-get update && apt-get install webmin bind9 net-tools apt-utils openssh-server -y && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean
 
RUN update-rc.d webmin defaults 100 && \
    update-rc.d bind9 defaults 99 && \
    update-rc.d ssh defaults 98
 
RUN sed -i 's/10000/80/g' /etc/webmin/miniserv.conf && \
    sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
 
RUN echo root:webmin | chpasswd
 
COPY docker-entrypoint.sh /docker-entrypoint.sh
 
EXPOSE 22 80 139 445 10000
 
CMD ["/docker-entrypoint.sh"]