#!/bin/bash
 
if [ ! -f "/var/kerberos/krb5kdc/principal" ];then
 
  if [ -f "/var/kerberos/krb5kdc/krb5.ldap" ]; then
    exit 0
  fi
 
cat > /database.f <<EOF
#!/bin/expect
set timeout 3
spawn kdb5_util create -s -r ${DEFAULT_REALM}
expect "*"
send "${INITIALIZE_DB_PASSWORD}\r"
expect "*"
send "${INITIALIZE_DB_PASSWORD}\r"
interact
EOF
 
bash -c "expect /database.f"
fi