# shadowsocks-python

创建配置文件 `/data/shadowsocks-python/config.json` :

```
{
    "server":"0.0.0.0",
    "server_port":10820,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"password0",
    "timeout":120,
    "method":"aes-256-cfb",
    "fast_open":true
}
```

启动:

```
$ docker run -d -p 10820:10820 -p 10820:10820/udp --name ss-python --restart always -v /data/shadowsocks-python:/etc/shadowsocks-python slzcc/shadowsocks-python
```