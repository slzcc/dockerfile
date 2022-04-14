#!/usr/bin/dumb-init bash

USER=`whoami`
HOST=`hostname -s`
DOMAIN=`hostname -d`
SERVERS=${SERVERS:-3}
DATA_DIR=${DATA_DIR:-/consul/data}
SERVERS_NAME=${HOSTNAME%-*}
RETRY_JOIN_OPTION=""

ulimit -n 65535

function join_servers_options() {
	for (( i=1; i<=$SERVERS; i++ )); do
		if [ ${HOSTNAME%-*}-$((i-1)) != ${HOSTNAME} ]; then
			RETRY_JOIN_OPTION="${RETRY_JOIN_OPTION} -retry-join ${HOSTNAME%-*}-$((i-1)).${SERVERS_NAME}"
		fi
	done
}

join_servers_options

exec consul agent -server -bootstrap-expect ${SERVERS} -data-dir ${DATA_DIR} -node=${HOST} -bind=${POD_IP} -client=0.0.0.0 ${RETRY_JOIN_OPTION} -ui