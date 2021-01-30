# Shadowsocks-libev

服务完全基于 (Shadowsocks)[https://github.com/shadowsocks/shadowsocks-libev].

## 使用

Server Run:

```
$ docker run -d --restart always --name shadowsocks-libev -e METHOD=aes-256-cfb -e PASSWORD=hotstone.io -p 8388:8388/tcp -p 8388:8388/udp  slzcc/shadowsocks-libev:v3.3.5
```

Client Run:

```
$ docker run -d --restart always --name shadowsocks-client -p 1080:1080 slzcc/shadowsocks-libev:v3.3.5 ss-local -s <server_ip> -p 8388 -m aes-256-cfb -k hotstone.io -b 0.0.0.0 -l 1080 -t 60 --fast-open
```

测试:

```
$ curl -x socks5h://127.0.0.1:1080 https://www.youtube.com/
```