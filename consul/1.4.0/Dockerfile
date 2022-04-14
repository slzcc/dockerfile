FROM ubuntu:20.04

RUN apt update && apt install -y unzip wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

ENV DUMB_INIT_VER="1.2.2"
 
RUN wget -O /tmp/dumb-init_${DUMB_INIT_VER}_amd64.deb https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64.deb && \
    dpkg -i /tmp/dumb-init_*.deb && \
    rm -rf /tmp/dumb-init_*.deb && \
    wget -qO- https://releases.hashicorp.com/consul/1.4.0/consul_1.4.0_linux_amd64.zip  > /consul_1.4.0_linux_amd64.zip && \
    unzip /consul_1.4.0_linux_amd64.zip && \
    rm -rf /consul_1.4.0_linux_amd64.zip && \
    mv /consul /bin/

ENTRYPOINT ["/usr/bin/dumb-init", "--"]