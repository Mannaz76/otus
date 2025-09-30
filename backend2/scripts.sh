#!/bin/bash

apt update

apt install apache2 -y

cp ./backend2/ndex.html /var/www/html/
