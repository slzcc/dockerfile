# History Audit

一次性项目, 当通过终端执行命令时会记录 history 到指定日志文件内如:

```
$ tail -f /var/log/shell_audit/audit.log
{ "@timestamp": "2023/03/03 17:25:01", "CurrentUser": "root", "LoginUser": "shilei", "LoginAddress": "47.243.107.84", "PID": "4021953", "LoginTime": "2023-03-03 14:50", "ExecutionDirectory": "/var/log/shell_audit", "ShellCommand": "cd /var/log/shell_audit/", "ShellCommandTime": "2023/03/03 17:25:01", "ExitCode": "0" }
{ "@timestamp": "2023/03/03 17:25:01", "CurrentUser": "root", "LoginUser": "shilei", "LoginAddress": "47.243.107.84", "PID": "4021953", "LoginTime": "2023-03-03 14:50", "ExecutionDirectory": "/var/log/shell_audit", "ShellCommand": "ls", "ShellCommandTime": "2023/03/03 17:25:01", "ExitCode": "0" }
{ "@timestamp": "2023/03/03 17:25:01", "CurrentUser": "root", "LoginUser": "shilei", "LoginAddress": "47.243.107.84", "PID": "4021953", "LoginTime": "2023-03-03 14:50", "ExecutionDirectory": "/var/log/shell_audit", "ShellCommand": "ll", "ShellCommandTime": "2023/03/03 17:25:01", "ExitCode": "0" }
```

> 它是把用户环境变量放置到 `/etc/profile.d/<PROFILE_NAME>` 生效后会输出日志到 `${LOG_DIR}/${LOG_NAME}`.

可修改的环境变量

|ENV|说明|默认值|
|-|-|-|
|HISTORY_SIZE|记录 History 的总数量, 当执行 history 命令时使用此值|204800|
|LOG_DIR|日志文件存放路径|/var/log/shell_audit|
|LOG_NAME|日志名称|audit.log|
|PROFILE_NAME|profile 的名称|shell_audit.sh|

## Build

```
$ docker build -t slzcc/history-audit:1.0.0 .
```

## USE

使用方式:

```
$ docker run --name history-audit --rm -v /etc/profile.d:/etc/profile.d -v /var/log:/var/log slzcc/history-audit:1.0.0
```