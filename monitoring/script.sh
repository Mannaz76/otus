#!/bin/bash

#обновляем репо и уcтанавливаем mysql
apt update && apt install -y prometheus adduser libfontconfig1 musl

dpkg -i ./otus/monitoring/grafana_11.2.2_amd64-224190-264c1b.deb

#запускаем
systemctl daemon-reload
systemctl enable --now grafana-server

cp ./otus/monitoring/prometheus.yml /etc/prometheus/

systemctl restart prometheus
