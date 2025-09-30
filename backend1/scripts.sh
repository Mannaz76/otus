#!/bin/bash

apt update

apt install apache2 -y

cp ./backend1/index.html /var/www/html/
