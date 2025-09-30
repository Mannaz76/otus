#!/bin/bash

apt update && apt install nginx -y

cp ./frontend/default /etc/nginx/sites-available/

nginx -t && systemctl reload nginx


