#!/bin/bash

apt update && apt install nginx prometheus-node-exporter -y

cp ./otus/frontend/default /etc/nginx/sites-available/

nginx -t && systemctl reload nginx

dpkg -i ./nas/elk/filebeat_8.17.1_amd64.deb

cp ./otus/frontend/filebeat.yml /etc/filebeat/

systemctl restart filebeat
