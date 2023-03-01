# top metrics


Build

```
docker build -t slzcc/top-metrics:0.0.1 .
```

USE

```
docker run --pull=always --pid=host --net=host --privileged=true --rm -t -v /data/logs/top:/data/logs/top slzcc/top-metrics:0.0.1
```

其中可以添加环境变量 `IFTOP_WaitingTime` 控制获取流量时长, 默认 100 秒.

默认 `gz` 文件保留 3 天, 如需修改请传递环境变量 `HISTORY_RESERVE` 解决.