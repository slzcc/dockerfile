#!/bin/bash
set -e
 
sleep 2
 
source /etc/sysconfig/kadmin
source /etc/sysconfig/krb5kdc
 
DEFAULT_REALM=${DEFAULT_REALM:-KERBEROS.COM}
REALM=${REALM:-kerberos.com}
 
DEFAULT_ENCTYPES=${DEFAULT_ENCTYPES:-rc4-hmac}
 
DNS_LOOKUP_REALM=${DNS_LOOKUP_REALM:-false}
DNS_LOOKUP_KDC=${DNS_LOOKUP_KDC:-false}
TICKET_LIFETIME=${TICKET_LIFETIME:-24h}
RENEW_LIFETIME=${RENEW_LIFETIME:-7d}
FORWARDABLE=${FORWARDABLE:-false}
CLOCKSKEW=${CLOCKSKEW:-120}
UDP_PREFERENCE_LIMIT=${UDP_PREFERENCE_LIMIT:-1}
 
INITIALIZE_DB_PASSWORD=${INITIALIZE_DB_PASSWORD:-kerberos.com}
 
if [ ! -d /var/kerberos/krb5kdc ];then
    cp -a /opt/kerberos /var/
    mkdir -p /var/kerberos/log
fi
 
if [ ! -f /var/kerberos/krb5kdc/krb5.conf  ];then
cat > /var/kerberos/krb5kdc/krb5.conf << EOF
[logging]
 default = FILE:/var/kerberos/log/krb5libs.log
 kdc = FILE:/var/kerberos/log/krb5kdc.log
 admin_server = FILE:/var/kerberos/log/kadmind.log
[libdefaults]
 default_realm = ${DEFAULT_REALM}
 dns_lookup_realm = ${DNS_LOOKUP_REALM}
 dns_lookup_kdc = ${DNS_LOOKUP_KDC}
 ticket_lifetime = ${TICKET_LIFETIME}
 renew_lifetime = ${RENEW_LIFETIME}
 forwardable = ${FORWARDABLE}
 default_tgs_enctypes = ${DEFAULT_ENCTYPES}
 default_tkt_enctypes = ${DEFAULT_ENCTYPES}
 permitted_enctypes = ${DEFAULT_ENCTYPES}
 clockskew = ${CLOCKSKEW}
 udp_preference_limit = ${UDP_PREFERENCE_LIMIT}
[realms]
 ${DEFAULT_REALM} = {
  kdc = ${REALM}
  admin_server = ${REALM}
  default_domain = ${REALM}
  key_stash_file = /var/kerberos/krb5kdc/.k5.${DEFAULT_REALM}
  dict_file = /usr/share/dict/words
 }
[domain_realm]
 .${REALM} = ${DEFAULT_REALM}
 ${REALM} = ${DEFAULT_REALM}
EOF
fi
 
ln -sf /var/kerberos/krb5kdc/krb5.conf /etc/krb5.conf
 
KDC_PORTS=${KDC_PORTS:-88}
KADMIND_PORT=${KADMIND_PORT:-749}
 
MASTER_KEY_TYPE=${MASTER_KEY_TYPE:-aes256-cts-hmac-sha1-96}
 
SUPPORTED_ENCTYPES=${SUPPORTED_ENCTYPES:-rc4-hmac:normal des3-cbc-sha1:normal aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal}
MAX_LIFE=${MAX_LIFE:-24h 0m 0s}
MAX_RENEWABLE_LIFE=${MAX_RENEWABLE_LIFE:-7d 0h 0m 0s}
 
cat > /var/kerberos/krb5kdc/kdc.conf << EOF
[kdcdefaults]
 kdc_ports = ${KDC_PORTS}
 kdc_tcp_ports = ${KDC_PORTS}
[realms]
 ${DEFAULT_REALM} = {
  #master_key_type = ${MASTER_KEY_TYPE}
  acl_file = /var/kerberos/krb5kdc/kadm5.acl
  dict_file = /usr/share/dict/words
  supported_enctypes = ${SUPPORTED_ENCTYPES}
  max_life = ${MAX_LIFE}
  max_renewable_life = ${MAX_RENEWABLE_LIFE}
  dict_file = /usr/share/dict/words
  key_stash_file = /var/kerberos/krb5kdc/.k5.${DEFAULT_REALM}
  database_name = /var/kerberos/krb5kdc/principal
  default_principal_flags = +renewable, +forwardable
 }
EOF
 
if [ "$(cat /var/kerberos/krb5kdc/kadm5.acl | grep ${DEFAULT_REALM})" == "" ]; then
 
cat > /var/kerberos/krb5kdc/kadm5.acl <<EOF
*/admin@${DEFAULT_REALM}   *
EOF
 
fi
 
cat > /supervisord.conf <<EOF
[supervisord]
pidfile = /var/run/supervisord.pid
nodaemon = true
 
[unix_http_server]
file = /var/run/supervisor.sock
chmod = 0777
 
[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface
 
[supervisorctl]
serverurl = unix:///var/run/supervisor.sock
;serverurl=http://127.0.0.1:9001
 
[program:database]
user = root
command = /check_database.sh
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
startretries=1
 
[program:krb5kdc]
user = root
command = /usr/sbin/krb5kdc -n -P /var/run/krb5kdc.pid $KRB5KDC_ARGS
autostart=true
startsecs=3
startretries=3
autorestart=true
priority=600
 
[program:kadmind]
user = root
command = /usr/sbin/_kadmind -nofork -P /var/run/kadmind.pid $KADMIND_ARGS
autostart=true
startsecs=3
startretries=3
autorestart=true
priority=700
EOF
 
sleep 2
 
exec /usr/bin/supervisord -c /supervisord.conf