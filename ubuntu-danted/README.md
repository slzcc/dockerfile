# Danted


Build:

```
$ docker build -t slzcc/danted:20.04 .
```


Run

```
$ docker run -d --name danted --restart always -p 1080:1080 slzcc/danted:20.04
```