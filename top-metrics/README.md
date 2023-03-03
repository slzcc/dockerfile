# top metrics

收集系统当前指标状态并录入文件, 当系统发生问题是进行回源

Build

```
docker build -t slzcc/top-metrics:1.0.1 .
```

USE

```
time docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.1

real	1m51.738s
user	0m0.022s
sys	0m0.018s
```

环境变量 `IFTOP_WaitingTime` 控制 `iftop` 获取流量时长, 默认 100 秒.

环境变量 `DSTAT_WaitingTime` 控制 `dstat` 获取指标时长, 默认 100 秒.

环境变量 `IOTOP_WaitingTime` 控制 `iotop` 获取指标时长, 默认 100 秒.

默认 `gz` 文件保留 3 天, 如需修改请传递环境变量 `HISTORY_RESERVE` 解决.

日志默认存放 `/data/logs/top` 中, 使用变量 `LOG_DIR` 环境变量控制.

输出 `DEBUG` 日志, 默认为 `false`.

放置定时任务中:

```
*/3 * * * * docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.1
```