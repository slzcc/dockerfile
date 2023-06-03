cat >/etc/danted.conf<<EOF
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# The listening network interface or address.
internal: 0.0.0.0 port=1080

# The proxying network interface or address.
external: eth0

# socks-rules determine what is proxied through the external interface.
socksmethod: username none

# client-rules determine who can connect to the internal interface.
clientmethod: none

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}
EOF

exec /usr/sbin/danted

#curl -v -x socks5://ubuntu:ubuntu@127.0.0.1:1080 http://www.baidu.com/
#curl -v -x socks5://127.0.0.1:1080 http://www.baidu.com/
#useradd -r -s /bin/false username
#passwd username