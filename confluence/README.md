# Conflunece


使用:

```
$ docker pull slzcc/confluence:7.10.2
 
$ export MySQL_PASSWORD=shileizcc.com
$ docker run --restart always -d --name mysql -v ~/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=${MySQL_PASSWORD} -p 3306:3306 slzcc/mysql:5.6-custom --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
$ docker exec -i mysql sh -c "mysql -uroot -p${MySQL_PASSWORD} -e 'CREATE DATABASE confluence CHARACTER SET 'UTF8' COLLATE 'utf8_bin';'"
$ docker run -d --name confluence-sql slzcc/confluence:7.10.2 sleep 123
$ docker cp confluence-sql:/*.sql ~/mysql/
$ docker cp confluence-sql:/var/atlassian/application-data/confluence ~/
 
$ until docker exec -i mysql sh -c "mysql -uroot -p${MySQL_PASSWORD} -e 'show databases;'"; do >&2 echo "Starting..." && sleep 1 ; done
$ docker exec -it mysql sh -c "mysql -uroot -p${MySQL_PASSWORD} -e 'use confluence; source /var/lib/mysql/confluence.sql;'"
$ sed -i "s/shileizcc.com/${MySQL_PASSWORD}/g" ~/confluence/confluence.cfg.xml
# MacOS Command sed
# sed -i "" "s/shileizcc.com/${MySQL_PASSWORD}/g" ~/confluence/confluence.cfg.xml
$ docker run --restart always -d --name confluence --link mysql -p 8090:8090 -v ~/confluence:/var/atlassian/application-data/confluence slzcc/confluence:7.10.2
$ docker rm -f confluence-sql
$ echo "UserName: admin"
$ echo "Password: D2#20cPUCaLe"
```