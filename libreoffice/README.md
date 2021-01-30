# Libreoffice

```
$ docker run --rm -it -v /root/:/root slzcc/liboffice:latest bash
$ libreoffice --headless --convert-to odt *.docx
# soffice --headless --invisible --convert-to pdf path/to/officefile --outdir path/to/outdir
```