FROM ubuntu:20.04

LABEL Author=Shileizcc.com Email=383821949@qq.com,shileizcc@126.com,shilei@hotstone.io

RUN apt update && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y git unzip vim python3 python3-pip curl wget lrzsz dnsutils inetutils-ping ethtool telnet iproute2 iotop jq ctop inetutils-traceroute traceroute tcpdump dbus net-tools openssh-server iptables ipset netcat-traditional fonts-baekmuk fonts-nanum language-pack-zh-hans dstat sudo bind9-utils nginx maven && \
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