# otus
В данном Readme описанна инструкция по реализации плана аварийного восстановления web проекта с двумя backend, 
одним frontend с балансировкой Round-robin, централизованного мониторинга и сбора логов.


## frontend
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)
   
2. Назначить ей статический ip адресс **192.168.11.20** через netplan
   Пример:
   ```
   network:
     version: 2
      ethernets:
        ens18:
          dhcp4: false
          addresses:
            - 192.168.11.20/24
          routes:
            - to: default
              via: 192.168.11.1
          nameservers:
            addresses: [8.8.8.8,8.8.4.4]

3. Назначить hostname **frontend**
   ```bash
   sudo hostnamectl set-hostname frontend
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/frontend/script.sh

## backend1
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)
2. Назначить ей статический ip адресс **192.168.11.21** через netplan

3. Назначить hostname **backend1**
   ```bash
   sudo hostnamectl set-hostname backend1
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/backend1/script.sh


## backend2
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.22** через netplan

3. Назначить hostname **backend2**
   ```bash
   sudo hostnamectl set-hostname backend2
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/backend2/script.sh

## dbmaster
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.23** через netplan

3. Назначить hostname **dbmaster**
   ```bash
   sudo hostnamectl set-hostname db_master
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/db_master/script.sh

## db_slave
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.24** через netplan

3. Назначить hostname **dbslave**
   ```bash
   sudo hostnamectl set-hostname dbslave
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/db_slave/script.sh

## Monitoring prometheus+grafana

1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.25** через netplan

3. Назначить hostname **monitiring**
   ```bash
   sudo hostnamectl set-hostname monitiring
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт
   ```bash
   sudo bash ./otus/monitoring/script.sh

6. Переходим в web интерфейс grafana в браузере по ip:
   ```
   http://192.168.11.25:3000
   ```
   пароль и логин по дефолту **admin** 

7. Добавляем источник данных
   - переходим в раздел **Connections** -> **Data Sourse**
   - нажимаем кнопку **Add data source**
   - выбираем из списка **Prometheus**
   - в разделе **Connection поле** **Prometheus server URL**  указываем **http://localhost:9090**
   - нажимаем кнопку **Save & test**

8. Добавляем Dashbord
   - переходим в раздел **Dashboards**
   - нажимаем кнопку **NEW** в выпадающем списке выбираем **Import**
   - в поле **Find and import dashboards for common applications at** указываем id **1860** и нажимаем **Load**
   - в следующем окне нажимаем кнопку **Import**

9. Проверяем работоспасобность

## Logging elk

1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, **10240** MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.26** через netplan

3. Назначить hostname **elk**
   ```bash
   sudo hostnamectl set-hostname monitiring
   sudo reboot

4. Клонируем репозиторий
   ```bash
   git clone https://github.com/Mannaz76/otus.git

5. Запускаем скрипт с указанием пароля для входа в elastic (заменить 1234567 на свой)
   ```bash
   sudo bash ./otus/elk/script.sh 1234567

6. Переходим в web интерфейс elastic в браузере по ip:
   
   http://192.168.11.26:5601

7. В браузере в поле **Enrollment token** копируем и вводим токен из файла **elasticsearch-token**
   ```bash
   cat elasticsearch-token

8. В браузере в поле **Verification required** копирум и вводим код из файла **kibana-verification-code** и нажимаем кнопку **Verify**
    ```bash
   cat kibana-verification-code
  
9.  Входим в систему, логин **elastic** пароль тот что задавали при старте скрипта в п.5

10. Проверяем наличие индексов
   -раздел Managment -> stack Managment -> раздел Data -> Index Managment
  
11. Добавляем Discover
   - переходим в раздел **Analytics** -> **Discover**
   - нажимаем кнопку **Create data view**
   - в поле **Nginx** указываем произвольное имя, в нашем случае **Nginx-front**
   - в поле **Index pattern** указываем **weblogs***
   - нажимаем кнопку **Save data view to Kibana**
   - в следующем окне нажимаем кнопку **Import**

12. Добавляем Dashboards
   - нажимаем кнопку **Create dashboards**
   - нажимаем кнопку **Create visualization**
   - в левой части добавляем поля графика
   - в правой части выбираем тип визуалиции , добавляем данные на оси
   - сохраняем нажатием кнопки **Save and return**

13. Проверяем работоспасобность
