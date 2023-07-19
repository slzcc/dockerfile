# v2ray

创建配置文件 `/data/v2ray/config.json`:

```
{
  "inbounds": [{
    "port": 29588,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "23ad6b10-8d1a-40f7-8ad0-e3e35cd38297",
          "level": 1,
          "alterId": 64
        }
      ]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": ["geoip:private"],
        "outboundTag": "blocked"
      }
    ]
  }
}
```

> 可参照配置文件: https://github.com/dreamrover/v2ray-deb/blob/master/v2ray-linux-amd64/etc/v2ray/server.json

启动:

```
$ docker run -d -p 29588:29588 -p 29588:29588/udp --name v2ray --restart always -v /data/v2ray:/etc/v2ray slzcc/v2ray
```