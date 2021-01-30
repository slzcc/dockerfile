# Ubuntu Desktop

(具体参照)[https://github.com/fcwu/docker-ubuntu-vnc-desktop]

```
$ docker run -it --rm -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword dorowu/ubuntu-desktop-lxde-vnc
# or
$ docker run -it --rm -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword registry.aliyuncs.com/slzcc/ubuntu-desktop-lxde-vnc:password
```