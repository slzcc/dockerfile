#!/bin/bash

WORK_HOME="/etc/supervisor"
SYSLOG_WORKER_THREADS=${SYSLOG_WORKER_THREADS:-10}

echo "${AWS_KEY}:${AWS_SECRET_KEY}" > /etc/passwd-s3fs && \
chmod 0400 /etc/passwd-s3fs
mkdir -p $MNT_POINT
ln -sf /dev/stdout /var/log/syslog

cat > ${WORK_HOME}/supervisord.conf <<EOF
[unix_http_server]
file=/var/run/supervisord.sock   ; (the path to the socket file)

[supervisord]
logfile=/var/log/supervisord.log ; (main log file;default supervisord.log)
logfile_maxbytes=50MB            ; (max main logfile bytes b4 rotation;default 50MB)
logfile_backups=10               ; (num of main logfile rotation backups;default 10)
loglevel=info                    ; (log level;default info; others: debug,warn,trace)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
nodaemon=false                   ; (start in foreground if true;default false)
minfds=1024                      ; (min. avail startup file descriptors;default 1024)
minprocs=200                     ; (min. avail process descriptors;default 200)

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisord.sock ; use a unix:// URL  for a unix socket

[supervisord]
nodaemon=true

[program:syslog]
startsecs=20
command=/usr/sbin/syslog-ng --worker-threads=${SYSLOG_WORKER_THREADS} -F 
autorestart=true
startsecs=0
startretries=30
priority=999
redirect_stderr=true
EOF

exec supervisord -c ${WORK_HOME}/supervisord.conf