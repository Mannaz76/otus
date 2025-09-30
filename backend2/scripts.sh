#!/bin/bash

apt update

apt install apache2 -y

cp ~/otus/backend2/ndex.html /var/www/html/
