# Nginx Mirror


使用:

```
$ docker run -d -v ${PWD}/mirror:/mirror -v ${PWD}/default.conf:/etc/nginx/conf.d/default.conf --name mirror -p 80:80 slzcc/nginx:mirror
```