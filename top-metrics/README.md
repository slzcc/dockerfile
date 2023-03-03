# top metrics

收集系统当前指标状态并录入文件, 当系统发生问题是进行回源

Build

```
docker build -t slzcc/top-metrics:1.0.3 .
```

USE

```
time docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.3

real	1m51.738s
user	0m0.022s
sys	0m0.018s
```

|ENV|说明|默认值|
|-|-|-|
|IFTOP_WaitingTime|iftop 执行时长|100|
|DSTAT_WaitingTime|dstat 执行时长|100|
|IOTOP_WaitingTime|iotop 执行时长|100|
|HISTORY_RESERVE|保留压缩文件时长(天)|3|
|LOG_DIR|默认日志存放路径|/data/logs/top|
|DEBUG|输出 Shell debug 日志|false|

放置定时任务中:

```
*/3 * * * * docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.3
```

或重定向追加:

```
sudo tee -a /var/spool/cron/centos <<< "*/3 * * * * sudo docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.3"
```