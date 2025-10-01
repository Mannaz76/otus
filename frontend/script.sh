#!/bin/bash

apt update && apt install nginx prometheus-node-exporter -y

cp ./otus/frontend/default /etc/nginx/sites-available/

nginx -t && systemctl reload nginx


