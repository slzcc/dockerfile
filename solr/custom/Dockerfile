FROM solr:7.3
USER root
COPY data/solr /opt/solr
COPY docker-entrypoint.sh /opt/docker-solr/scripts/docker-entrypoint.sh
RUN chown solr:solr -R  /opt/solr
USER solr
 
ENV MYSQL_HOST=127.0.0.1 \
    MYSQL_PORT=3306 \
    MYSQL_USERNAME=resume \
    MYSQL_PASSWORD=resume \
    MYSQL_DATABASE=resume
 
VOLUME /opt/solr/server/solr/gettingstarted/data