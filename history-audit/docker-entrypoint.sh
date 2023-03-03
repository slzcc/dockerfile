#!/bin/bash

HISTORY_SIZE=${HISTORY_SIZE:-204800}
LOG_DIR=${LOG_DIR:-/var/log/shell_audit}
LOG_NAME=${LOG_NAME:-audit.log}
PROFILE_NAME=${PROFILE_NAME:-shell_audit.sh}

mkdir ${LOG_DIR}
touch ${LOG_DIR}/${LOG_NAME}
chmod 002 ${LOG_DIR}/${LOG_NAME}
chattr +a ${LOG_DIR}/${LOG_NAME}

> /etc/profile.d/shell_audit.sh
sudo tee -a /etc/profile.d/shell_audit.sh <<< "HISTSIZE=${HISTORY_SIZE}"
sudo tee -a /etc/profile.d/shell_audit.sh <<< 'HISTTIMEFORMAT="%Y/%m/%d %T ---- ";export HISTTIMEFORMAT'
sudo tee -a /etc/profile.d/shell_audit.sh <<< "export HISTORY_FILE=${LOG_DIR}/${LOG_NAME}"
sudo tee -a /etc/profile.d/shell_audit.sh <<< 'export PROMPT_COMMAND={@}{ code=$?;thisHistID=`history 1|awk "{print \\$1}"`;lastCommand=`history 1| awk "{\\$1=\"\" ;print}" |awk -F ---- "{print \\$2}" |sed -e "s@^[ \t]*@@g"`;lastCommandTime=`history 1| awk "{\\$1=\"\" ;print}" |awk -F ---- "{print \\$1}"|sed -e "s/^[ \t]*//g" -e "s/[ \t]*$//g"`;user=`id -un`;whoStr=(`who -u am i`);realUser=${whoStr[0]};logDay=${whoStr[2]};logTime=${whoStr[3]};pid=${whoStr[5]};ip=`echo ${whoStr[6]}| sed -e "s/[(|)]*//g"`;if [ ${thisHistID}x != ${lastHistID}x ];then echo -E \{ \"@timestamp\": \"`date "+%Y/%m/%d %H:%M:%S"`\", \"CurrentUser\": \"$user\", \"LoginUser\": \"$realUser\", \"LoginAddress\": \"$ip\", \"PID\": \"$pid\", \"LoginTime\": \"$logDay $logTime\",  \"ExecutionDirectory\": \"$PWD\", \"ShellCommand\": \"$lastCommand\", \"ShellCommandTime\": \"$lastCommandTime\", \"ExitCode\": \"$code\" \};lastHistID=$thisHistID;fi; } >> $HISTORY_FILE{@}'
sed -i "s#{@}#'#g" /etc/profile.d/${PROFILE_NAME}