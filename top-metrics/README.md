# top metrics

收集系统当前指标状态并录入文件, 当系统发生问题是进行回源

## 效果图

默认会生成 9 种日志:

```
$ ls -l /data/logs/top/
total 72
drwxrwxrwx 2 root root  4096 Mar  3 17:47 ./
drwxr-xr-x 3 root root  4096 Mar  3 10:48 ../
-rw-r--r-- 1 root root   922 Mar  3 17:47 cron.202303031745.tar.gz # 备份 cron
-rw-r--r-- 1 root root  1936 Mar  3 17:46 dstat.out202303031745.gz
-rw-r--r-- 1 root root  1437 Mar  3 17:46 iftop.out202303031745.gz
-rw-r--r-- 1 root root  2467 Mar  3 17:47 iotop.out202303031745.gz
-rw-r--r-- 1 root root  3143 Mar  3 17:45 ps_mem.out202303031745.gz
-rw-r--r-- 1 root root  7420 Mar  3 17:45 psaux.out202303031745.gz
-rw-r--r-- 1 root root  5187 Mar  3 17:45 pstree.out202303031745.gz
-rw-r--r-- 1 root root  2927 Mar  3 17:45 sysstat.out202303031745.gz
-rw-r--r-- 1 root root 21469 Mar  3 17:45 top.out202303031745.gz
```

`dstat.out202303031745.gz` 类文件收集 `dstat` 命令指标:

```
$ zcat dstat.out202303031745.gz
You did not select any stats, using -cdngy by default.
----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
  6   4  90   0   0   0|4311B  168k|   0     0 |   0     0 |1317  8824
 36  20  43   0   0   1|   0  8192B|6932B 7496B|   0     0 |2982  7950
 39  16  45   0   0   1|   0     0 |  21k   21k|   0     0 |3126  8116
 43  17  39   0   0   0|   0   156k|  19k   19k|   0     0 |3669  9745
 36  19  45   0   0   1|   0     0 |  10k   11k|   0     0 |3395  8679
 38  22  40   0   0   0|   0   136k|8774B 9477B|   0     0 |3470  9483
 38  17  45   0   0   0|   0     0 |6378B 7073B|   0     0 |2976  8007
 38  17  44   0   0   0|   0     0 |3499B 4188B|   0     0 |2725  7664
 39  29  32   0   0   0|  64k    0 |4289B 4617B|   0     0 |3245  8450
  4   2  94   0   0   1|   0     0 |5414B 5694B|   0     0 |3751  8558
```

`iftop.out202303031745.gz` 类文件收集 `iftop` 命令指标

```
zcat iftop.out202303031745.gz
interface: ens4
IP address is: 10.170.0.2
MAC address is: 42:01:0a:aa:00:02
Listening on ens4
   # Host name (port/service if enabled)            last 2s   last 10s   last 40s cumulative
--------------------------------------------------------------------------------------------
   1 instance-1:28941                         =>     31.6Kb     28.6Kb     25.4Kb      297KB
     111.198.66.3:55072                       <=     1.83Kb     1.83Kb     1.64Kb     19.5KB
   2 instance-1:54426                         =>     1.42Kb     1.47Kb     1.31Kb     15.7KB
     server-13-225-103-14.hkg60.r.cloudfr:443 <=     30.1Kb     27.5Kb     24.4Kb      282KB
   3 instance-1:41372                         =>     1.59Kb     2.47Kb     1.46Kb     20.0KB
     91.108.56.152:8888                       <=     3.03Kb     6.62Kb     3.92Kb     77.1KB
...
  49 instance-1:40644                         =>         0b         0b        89b       444B
     149.154.165.250:8888                     <=         0b         0b        68b       340B
  50 instance-1:36448                         =>       208b       109b        61b     1.06KB
     149.154.175.100:8888                     <=       208b       150b        92b     1.31KB
--------------------------------------------------------------------------------------------
Total send rate:                                     45.0Kb     49.4Kb     41.7Kb
Total receive rate:                                  46.4Kb     50.4Kb     43.6Kb
Total send and receive rate:                         91.5Kb     99.8Kb     85.3Kb
--------------------------------------------------------------------------------------------
Peak rate (sent/received/total):                     64.7Kb     83.7Kb      147Kb
Cumulative (sent/received/total):                     528KB      548KB     1.05MB
============================================================================================
```

> iftop 只会收集 `ens` or `eth` 名称其中一块网卡数据, 如果有多个网卡请修改脚本解决


`iotop.out202303031745.gz` 类文件收集 `iotop` 命令指标

```
$ zcat iotop.out202303031745.gz
17:45:21 Total DISK READ :       0.00 B/s | Total DISK WRITE :     365.81 K/s
17:45:21 Actual DISK READ:       0.00 B/s | Actual DISK WRITE:       0.00 B/s
    TIME    PID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
17:45:21 4076345 be/4 root        0.00 B/s  365.81 K/s  ?unavailable?  top -b -n2 -d5 -c -H
17:45:22 Total DISK READ :       0.00 B/s | Total DISK WRITE :       3.82 K/s
17:45:22 Actual DISK READ:       0.00 B/s | Actual DISK WRITE:       0.00 B/s
    TIME    PID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
17:45:22 4076355 be/4 root        0.00 B/s    3.82 K/s  ?unavailable?  python /usr/sbin/iotop -t -oP --iter=100
17:45:23 Total DISK READ :       0.00 B/s | Total DISK WRITE :      11.48 K/s
```

> 由于一秒执行一次, 数据会重叠在一起

`ps_mem.out202303031745.gz` 类文件收集 [ps_mem](https://github.com/pixelb/ps_mem/blob/master/ps_mem.py) 命令指标

```
$ zcat ps_mem.out202303031745.gz
 Private  +   Shared  =  RAM used	Program

104.0 KiB +  17.5 KiB = 121.5 KiB	runsvdir
 96.0 KiB +  37.5 KiB = 133.5 KiB	bpfilter_umh
...
 34.8 MiB +   7.7 MiB =  42.5 MiB	containerd-shim-runc-v2 (12)
 58.0 MiB +   0.5 KiB =  58.0 MiB	dockerd
 45.3 MiB +  26.1 MiB =  71.4 MiB	uwsgi (7)
 70.6 MiB +   5.4 MiB =  76.0 MiB	python3.9 (2)
109.2 MiB +   0.5 KiB = 109.2 MiB	mariadbd
170.6 MiB + 111.5 KiB = 170.7 MiB	squid
---------------------------------
                        908.2 MiB
=================================
```

`psaux.out202303031745.gz` 类文件收集 `ps` 命令指标

```
$ zcat psaux.out202303031745.gz
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.5  0.1 172640 11556 ?        Ss    2022 579:03 /sbin/init
root           2  0.0  0.0      0     0 ?        S     2022   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<    2022   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<    2022   0:00 [rcu_par_gp]
root           5  0.0  0.0      0     0 ?        I<    2022   0:00 [netns]
root           7  0.0  0.0      0     0 ?        I<    2022   0:00 [kworker/0:0H-ev]
root           9  0.0  0.0      0     0 ?        I<    2022   5:33 [kworker/0:1H-ev]
root          10  0.0  0.0      0     0 ?        I<    2022   0:00 [mm_percpu_wq]
root          11  0.0  0.0      0     0 ?        S     2022   0:00 [rcu_tasks_rude_]
root          12  0.0  0.0      0     0 ?        S     2022   0:00 [rcu_tasks_trace]
root          13  0.0  0.0      0     0 ?        S     2022  33:17 [ksoftirqd/0]
...
```

`pstree.out202303031745.gz` 类文件收集 `pstree` 命令指标

```
$ zcat pstree.out202303031745.gz
systemd,1,1
  |-systemd-journal,169,169
  |-systemd-udevd,204,204
  |-multipathd,325,325 -d -s
  |   |-{multipathd},327,325
  |   |-{multipathd},328,325
  |   |-{multipathd},329,325
  |   |-{multipathd},330,325
  |   |-{multipathd},331,325
  |   `-{multipathd},332,325
  |-systemd-network,462,462,100
  |-accounts-daemon,579,579
  |   |-{accounts-daemon},580,579
  |   `-{accounts-daemon},597,579
```

`sysstat.out202303031745.gz` 类文件会收集 `ifconfig`、`route`、`df`、`free`、`fdisk`、`lsblk` 等命令指标

`netstat.out202303031745.gz` 类日志会被收集到 `netstat-anlp` 和 `netstat-lnput` 中, 当需要记录访问的连接数量:

```
$ zcat netstat-anlp.out202303031745.gz |grep ":8500"|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c
```

`top.out202303031745.gz` 类文件收集 `top` 命令指标

```
$ zcat top.out202303031745.gz
top - 17:45:21 up 74 days,  7:50,  0 users,  load average: 0.54, 0.41, 0.35
Threads: 776 total,   2 running, 724 sleeping,   0 stopped,   2 zombie
%Cpu(s): 41.9 us, 53.2 sy,  0.0 ni,  3.2 id,  0.0 wa,  0.0 hi,  0.0 si,  1.6 st
KiB Mem :  8137468 total,  5152356 free,  1083864 used,  1901248 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  6705792 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
4076355 root      20   0   92528  14364   6376 R 42.9  0.2   0:00.14 /usr/bin/python /usr/sbin/iotop -t -oP --iter=100
4076345 root      20   0   56860   4396   3200 R 10.7  0.1   0:00.08 top -b -n2 -d5 -c -H
 156854 root      20   0 1264556   7680   1676 S  7.1  0.1   1241:00 /usr/local/bin/mtproto-proxy -p 2398 -H 443 -M 2 -C 60000 --aes-pwd /etc/telegram/hello-explorers-how-are-you-doing -u root /etc/telegram/backend.conf --allow-skip-dh --nat-info 172.17.0.3 35.241.74.31+
 156853 root      20   0 1264568   7708   1668 S  3.6  0.1   1239:08 /usr/local/bin/mtproto-proxy -p 2398 -H 443 -M 2 -C 60000 --aes-pwd /etc/telegram/hello-explorers-how-are-you-doing -u root /etc/telegram/backend.conf --allow-skip-dh --nat-info 172.17.0.3 35.241.74.31+
      1 root      20   0  172640  11556   5684 S  0.0  0.1 579:03.91 /sbin/init
```

## Build

```
$ docker build -t slzcc/top-metrics:1.0.4 .
```

## USE

```
$ time docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.4

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
*/3 * * * * docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.4
```

或重定向追加:

```
$ sudo tee -a /var/spool/cron/centos <<< "*/3 * * * * sudo docker run --name top-metrics --pid=host --net=host --privileged=true --rm -t -v /var/spool/cron:/var/spool/cron -v /etc/localtime:/etc/localtime -v /data/logs/top:/data/logs/top slzcc/top-metrics:1.0.4"
```
