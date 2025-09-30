#!/bin/bash

apt update

apt install apache2 -y

cp ./index.html /var/www/html/
