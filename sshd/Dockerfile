FROM ubuntu:20.04

LABEL Author=Shileizcc.com Email=383821949@qq.com,shileizcc@126.com

RUN apt update && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y openssh-server && \
    rm -rf /var/cache/apt/archives/* && \
    apt clean

RUN service ssh start && \
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys && \
    chmod 600 -R ~/.ssh/authorized_keys && \
    ssh-keyscan -t rsa 127.0.0.1 -p 22 > ~/.ssh/known_hosts && \
    ssh-keygen -H -f ~/.ssh/known_hosts

RUN update-rc.d ssh defaults 98 && \
    echo 'root:root' |chpasswd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd" "-D"]