# otus
В данном Readme описанна инструкция по реализации плана аварийного восстановления web проекта с двумя backend, 
одним frontend с балансировкой Round-robin и централизованого моиторинга и сбора логов.

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

4. Клонируем репозиторий и запускаем скрипт
   ```bash
   git clone https://github.com/Mannaz76/otus.git
   sudo bash ./otus/frontend/script.sh

## backend1
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)
2. Назначить ей статический ip адресс **192.168.11.21** через netplan

3. Назначить hostname **backend1**
   ```bash
   sudo hostnamectl set-hostname backend1
   sudo reboot

4. Клонируем репозиторий и запускаем скрипт
   ```bash
   git clone https://github.com/Mannaz76/otus.git
   sudo bash ./otus/backend1/script.sh


## backend2
1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.22** через netplan

3. Назначить hostname **backend2**
   ```bash
   sudo hostnamectl set-hostname backend2
   sudo reboot

4. Клонируем репозиторий и запускаем скрипт
   ```bash
   git clone https://github.com/Mannaz76/otus.git
   sudo bash ./otus/backend2/script.sh

## Monitoring prometheus+grafana

1. Развернуть VM  на базе образа **ubuntu-24.04.3-live-server-amd64.iso** (20 GB Disk size, 2 Cores CPU, 2048 MiB Memory, vmbr0 Bridge Network)

2. Назначить ей статический ip адресс **192.168.11.25** через netplan

3. Назначить hostname **monitiring**
   ```bash
   sudo hostnamectl set-hostname monitiring
   sudo reboot

4. Клонируем репозиторий и запускаем скрипт
   ```bash
   git clone https://github.com/Mannaz76/otus.git
   sudo bash ./otus/monitoring/script.sh

5. Переходим в web интерфейс grafana в браузере по ip:
   ```
   192.168.11.25:3000
   ```
   пароль и логин по дефолту **admin** 

6. Добавляем источник данны
   - переходим в раздел **Connections** -> **Data Sourse**
   - нажимаем кнопку **Add data source**
   - выбираем из списка **Prometheus**
   - в разделе **Connection поле** **Prometheus server URL**  указываем **http://localhost:9090**
   - нажимаем кнопку **Save & test**

7. Добавляем Dashbord
   - переходим в раздел **Dashboards**
   - нажимаем кнопку **NEW** в выпадающем списке выбираем **Import**
   - в поле **Find and import dashboards for common applications at** указываем id **1860** и нажимаем **Load**
   - в следующем окне нажимаем кнопку **Import**

8. Проверяем работоспасобность
