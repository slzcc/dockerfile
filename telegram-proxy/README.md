Dockerfile for MTProxy
===


### Building

    docker build -t slzcc/telegram-proxy:latest .


### Running

    docker run -d --restart=always \
        -p 10000:443 \
        -v proxy-config:/data \
        -e SECRET=00000000000000000000000000000000 \
        --name=telegram-proxy \
        slzcc/telegram-proxy:latest


### Links

* https://github.com/TelegramMessenger/MTProxy
* https://hub.docker.com/r/telegrammessenger/proxy
