#!/bin/bash
set -e
# Start Server
/opt/atlassian/jira/bin/startup.sh
  
exec tail -f /opt/atlassian/jira/logs/catalina.out