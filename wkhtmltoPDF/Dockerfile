FROM slzcc/liboffice:latest
 
RUN apt update && \
    apt install -f xfonts-75dpi xfonts-base libfontenc1 libxfont1 xfonts-encodings xfonts-utils && \
    apt-get autoremove --purge --yes && \
    rm --force --recursive \
        /tmp/* \
        /var/lib/apt/lists/*
 
RUN cd / && \
    wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.xenial_amd64.deb && \
    dpkg -i wkhtmltox_0.12.5-1.xenial_amd64.deb