# Danted


Build:

```
$ docker build -t slzcc/danted:20.04 .
```


Run

```
$ docker run -d --name danted --restart always -p 1080:1080 slzcc/danted:20.04
```

通过 docker log danted 查看密码.

当传入变量 `ROOT_PASSWORD` 则使用固定密码, 不传入则自生成密码, 默认 `''`,

当传入变量 `IS_USERNAME` 值不为 `true` 则不开启用户认证，默认等于 `true`