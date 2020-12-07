# Homework 3.4

1.  ```commandline
    vagrant@vagrant:~$ systemctl cat node_exporter
    # /etc/systemd/system/node_exporter.service
    [Unit]
    Description=Service for node exporter
    
    [Service]
    EnvironmentFile=/vagrant/node_exporter-1.0.1.linux-amd64/config
    ExecStart=/vagrant/node_exporter-1.0.1.linux-amd64/node_exporter $OPTS
    
    [Install]
    WantedBy=multi-user.target
    vagrant@vagrant:~$ systemctl status node_exporter
    ● node_exporter.service - Service for node exporter
         Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
         Active: active (running) since Sat 2020-12-05 11:15:20 UTC; 10min ago
       Main PID: 596 (node_exporter)
          Tasks: 4 (limit: 1074)
         Memory: 9.0M
         CGroup: /system.slice/node_exporter.service
                 └─596 /vagrant/node_exporter-1.0.1.linux-amd64/node_exporter
    ```
    Сервис запускается, работает, метрики отдает. После перезапуска системы тоже работает корректно.
    

2.  Отключил лишние коллекторы с помощью опиции --no-collector. Перечислил их, задав переменную в файле, который
    указал в юнит-файле сервиса:
    >EnvironmentFile=/vagrant/node_exporter-1.0.1.linux-amd64/config
    
    >OPTS='--no-collector.arp --no-collector.bcache <...>'

    Оставил только коллекторы cpu, filesystems, meminfo, netstat. И то в них вместе набралось около сотни метрик.
    

3.  Установил, настроил, потыкал - https://i.imgur.com/xxlF8rD.png
    Отличная вещь и не понятно, зачем теперь нужны другие утилиты) Осталось только разобраться, как можно хранить
    данные на отдельной машине, чтобы они не пропали в случае недоступности хоста. Ну или запускать на одной
    машине, а мониторить другую.
    

4.  Да, это прекрасно видно по логам. Например:
    
    ```commandline
    vagrant@vagrant:~$ dmesg -T | grep virtual
    [Mon Dec  7 09:46:37 2020] CPU MTRRs all blank - virtualized system.
    [Mon Dec  7 09:46:37 2020] Booting paravirtualized kernel on KVM
    [Mon Dec  7 09:46:37 2020] Performance Events: PMU not available due to virtualization, using software events only.
    [Mon Dec  7 09:46:41 2020] systemd[1]: Detected virtualization oracle.
    ```
    
5.  Этот параметр — системное ограничение максимального количества одновременно открытых файлов. Этого количества не
    достичь, так как есть ещё "мягкое" ограничение на 1024 открытых файла в сессии bash. Его как раз можно изменить
    командой ulimit вплоть до системного ограничения. Но это распространяется только на текущую сессию bash и
    сбросится при перезагрузке или просто при открытии нового окна псевдо-терминала.
    
    Постоянные ограничения можно задать в `/etc/security/limits.conf` и каталоге `/etc/security/limits.d/`


6.  ```commandline
    vagrant@vagrant:~$ sudo -i
    root@vagrant:~# unshare -f --pid --mount-proc sleep 1h &
    [1] 2225
    root@vagrant:~# ps aux | grep sleep
    root        2225  0.0  0.0   8080   592 pts/0    S    11:37   0:00 unshare -f --pid --mount-proc sleep 1h
    root        2226  0.0  0.0   8076   592 pts/0    S    11:37   0:00 sleep 1h
    root        2228  0.0  0.0   9032   724 pts/0    S+   11:37   0:00 grep --color=auto sleep
    root@vagrant:~# nsenter --target 2226 --pid --mount
    root@vagrant:/# ps aux
    USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    root           1  0.0  0.0   8076   592 pts/0    S    11:37   0:00 sleep 1h
    root           2  0.0  0.4   9836  4052 pts/0    S    11:37   0:00 -bash
    root          11  0.0  0.3  11484  3496 pts/0    R+   11:37   0:00 ps aux  
    ```
    

7.  Команда описывает функцию, которая создает две копии себя в фоне и после запускает её. Процессы плодятся, пока не
    уткнутся в лимит процессов на одного пользователя. Лимит можно посмотреть и изменить с помощью `ulimit -u`. Но
    задать не выше, чем значение "hard". А "hard" можно изменить в `/etc/security/limits.conf`. 