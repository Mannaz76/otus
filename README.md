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

4. Назначить hostname **frontend**
   ```bash
   hostnamectl set-hostname frontend
   reboot

5. Клонируем репазиторий и запускаем скрипт
```bash
git clone https://github.com/Mannaz76/otus.git
sudo bash ./otus/frontend/script.sh

## backend1

```bash
git clone https://github.com/Mannaz76/otus.git
sudo bash ./otus/backend1/script.sh

## backend2

```bash
git clone https://github.com/Mannaz76/otus.git
sudo bash ./otus/backend2/script.sh
