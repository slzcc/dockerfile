#!/bin/bash
set -e

if [[ ! -z ${UCP_SERVERS} ]]
    then
        AUTHTOKEN=$(curl -sk -d '{"username":"'"${UCP_USER}"'","password":"'"${UCP_PASSWORD}"'"}' https://${UCP_SERVERS}/auth/login | awk -F "\"" '{print $4}');
        curl -k -H "Authorization: Bearer $AUTHTOKEN" --retry 3 --retry-delay 5  https://${UCP_SERVERS}/api/clientbundle -o bundle.zip;
        unzip -o bundle.zip;
        chmod +x env.sh;
        eval $(<env.sh);
fi
