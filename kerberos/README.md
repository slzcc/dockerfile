# Kerberos

使用:

```
$ mkdir -p /data/kerberos
$ docker run --name kerberos -e DEFAULT_REALM=KERBEROS.COM -e REALM=kerberos.com -e INITIALIZE_DB_PASSWOD=kerberos.com -v /data/kerberos:/var/kerberos -p 88:88 -p 749:749 -p 464:464 slzcc/kerberos:5
```