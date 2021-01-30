FROM ubuntu:16.04
 
RUN apt update && \
    apt-get install -y language-pack-en-base
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
 
RUN apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update
 
RUN apt-get install -y apache2
RUN apt-get install -y php7.2 \
             php7.2-memcached \
             php7.2-mbstring \
             php7.2-zip \
             php7.2-dom \
             php7.2-fpm \
             php7.2-mysql \
             php7.2-xml \
             libapache2-mod-php7.2 \
             php7.2-mbstring \
             php7.2-gd && \
             php-curl && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean
 
RUN a2enmod rewrite
 
EXPOSE 80
 
RUN ln -sf /dev/stdout /var/log/apache2/access.log
  
RUN ln -sf /dev/stderr /var/log/apache2/error.log
 
WORKDIR /var/www/html/
 
CMD . /etc/apache2/envvars && /usr/sbin/apache2 -DFOREGROUND