# top metrics


Build

```
docker build -t slzcc/top-metrics:0.0.1 .
```

USE

```
docker run --pull --pid=host --net=host --privileged=true --rm -t -v /data/logs/top:/data/logs/top slzcc/top-metrics:0.0.1
```