#!/bin/bash
set -e
 
ROOT_PASSWORD=${ROOT_PASSWORD:-"webmin"}
echo root:${ROOT_PASSWORD} | chpasswd
 
sed -i "s/bind/root/" /etc/default/bind9
 
service webmin start && service smbd start && service nmbd start && service bind9 start && service ssh start
exec tail -f /webmin-setup.out