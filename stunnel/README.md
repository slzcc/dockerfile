# Stunnel

Stunnel 旨在为使用不安全连接协议的程序增加 SSL 加密, 可与 OpenVPN 搭配使用.

## 使用

Service Run:

```
$ docker run -d --restart always --net host --name stunnel -e CLIENT=no -e SERVICE=sproxy -e ACCEPT=0.0.0.0:8788 -e CONNECT=10.140.0.2:8787 slzcc/stunnel:alpine
```

Client Run:

```
$ docker run -d --restart always --net host --name stunnel -e CLIENT=yes -e SERVICE=sproxy -e ACCEPT=0.0.0.0:8788 -e CONNECT=server:8788 slzcc/stunnel:alpine
```