#!/bin/bash
set -e
# Start Server
/opt/atlassian/confluence/bin/startup.sh
 
ln -sf /dev/stdout /opt/atlassian/confluence/logs/catalina.out
 
exec tail -f /opt/atlassian/confluence/logs/synchrony-proxy-watchdog.log