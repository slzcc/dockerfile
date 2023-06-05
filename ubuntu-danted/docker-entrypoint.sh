#!/bin/bash

IS_USERNAME=${IS_USERNAME:-none}
ROOT_PASSWORD=${ROOT_PASSWORD:-}
DANTED_PROD=${DANTED_PROD:-1080}

if [ -n "${ROOT_PASSWORD}" ]; then
    ROOT_PASSWORD=`openssl rand -base64 16`
fi

echo root:${ROOT_PASSWORD} | chpasswd

if [ -n "${IS_USERNAME}" ]; then
cat >/etc/danted.conf<<EOF
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# The listening network interface or address.
internal: 0.0.0.0 port=${DANTED_PROD}

# The proxying network interface or address.
external: eth0

# socks-rules determine what is proxied through the external interface.
socksmethod: username

# client-rules determine who can connect to the internal interface.
clientmethod: none

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}
EOF
printf The socket user authentication mode has been enabled!

printf Username: root, Password: ${ROOT_PASSWORD}

printf Example: curl -v -x socks5://root:${ROOT_PASSWORD}@127.0.0.1:${DANTED_PROD} http://www.google.com/

else
cat >/etc/danted.conf<<EOF
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# The listening network interface or address.
internal: 0.0.0.0 port=${DANTED_PROD}

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

printf socket user authentication mode is not used

printf Example: curl -v -x socks5://127.0.0.1:${DANTED_PROD} http://www.google.com/

fi

exec /usr/sbin/danted
