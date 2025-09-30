#!/bin/bash

apt update && apt install nginx -y

cp ./default /etc/nginx/sites-available/

nginx -t && systemctl reload nginx


