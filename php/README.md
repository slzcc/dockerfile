# Nginx php

使用:

```
$ docker run -d -p 9000:9000 -v slzcc/php:7.1.22-fpm
$ docker run -d -p 80:80 -v /data/html:/data/html -v ~/default.conf:/etc/nginx/conf.d/default.conf --add-host php:10.140.0.2 nginx

```