# 使用

启动是把内部数据拷贝到宿主机:

```
$ mkdir -p /data/webmin
$ docker run -d --name webmin-example slzcc/webmin:1.960 sleep 12345
$ docker cp webmin-example:/. /data/webmin
```

启动服务:

```
$ docker rm -f webmin-example
$ docker run -d --name webmin --net host -v /data/webmin/usr:/usr -v /data/webmin/etc:/etc -v /data/webmin/var:/var -v /data/webmin/data:/data  -e ROOT_PASSWORD=shileizcc.com  slzcc/webmin:1.960
```

访问 http://localhost:10000, 使用 root:shileizcc.com 登入.