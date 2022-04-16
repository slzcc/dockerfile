FROM nginx

RUN mkdir -p /etc/nginx/root && \
    rm -rf /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/root/nginx.conf

RUN ln -sf /etc/nginx/root/nginx.conf /etc/nginx/nginx.conf