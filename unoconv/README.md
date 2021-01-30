# Unoconv

本地文件转码 PDF:

使用:

```
$ docker run --rm -it -v `pwd`:/data slzcc/unoconv:windows-fonts bash
$ unoconv -f pdf /data/resume.html
# 即可获得 resume.pdf 文件
```