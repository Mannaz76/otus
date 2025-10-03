#!/bin/bash

password=$1

#обновляем репо и уcтанавливаем mysql
apt update && apt install default-jdk nginx -y


dpkg -i ./otus/elk/*.deb

# Задаем лимиты памяти вля виртуальной машины Java
cp ./otus/elk/jvm.options /etc/elasticsearch/jvm.options.d/

#
cp ./otus/elk/elasticsearch.yml /etc/elasticsearch/

#запускаем
systemctl daemon-reload
systemctl enable --now elasticsearch.service



/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i << EOF
Y
$password
$password
EOF

cp ./otus/elk/kibana.yml /etc/kibana/

# Проверка конфигурации
/usr/share/kibana/bin/kibana test config

systemctl restart kibana

# Настройка Logstash
systemctl enable --now logstash.service

# Копируем корневой сертификат от elasticsearch
mkdir /etc/logstash/certs/
cp /etc/elasticsearch/certs/http_ca.crt /etc/logstash/certs/
chown -R logstash:logstash /etc/logstash/certs/

cp ./otus/elk/logstash.yml /etc/logstash/


cat > /etc/logstash/conf.d/logstash-nginx-es.conf << EOF

input {
    beats {
        port => 5400
    }
}

filter {
 grok {
   match => [ "message" , "%{COMBINEDAPACHELOG}+%{GREEDYDATA:extra_fields}"]
   overwrite => [ "message" ]
 }
 mutate {
   convert => ["response", "integer"]
   convert => ["bytes", "integer"]
   convert => ["responsetime", "float"]
 }
 date {
   match => [ "timestamp" , "dd/MMM/YYYY:HH:mm:ss Z" ]
   remove_field => [ "timestamp" ]
 }
}

output {
 elasticsearch {
   hosts => ["https://localhost:9200"]
   user => "elastic"
   password => "$password"
   index => "weblogs-%{+YYYY.MM.dd}"
   document_type => "nginx_logs"
   cacert => "/etc/logstash/certs/http_ca.crt"
 }
 stdout { codec => rubydebug }
}
EOF


systemctl restart logstash.service

# Генеририруем токен
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana > elasticsearch-token

sleep 10

# Код верификации
/usr/share/kibana/bin/kibana-verification-code > kibana-verification-code







