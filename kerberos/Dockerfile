FROM centos:7.6.1810

RUN yum install -y epel-release && \
    yum install -y krb5-server krb5-libs krb5-auth-dialog supervisor expect && \
    rm -rf /var/cache/yum/*

RUN mv  /var/kerberos /opt/kerberos

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 88 749 464

CMD ["/docker-entrypoint.sh"]