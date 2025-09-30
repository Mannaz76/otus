#!/bin/bash

apt update

apt install apache2 -y

cp ./otus/backend1/index.html /var/www/html/
