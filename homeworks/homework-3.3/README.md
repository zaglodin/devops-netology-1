1.  ```
    michael@michael-pc:~$ strace bash -c 'cd /tmp' 2>&1 | grep tmp
    execve("/usr/bin/bash", ["bash", "-c", "cd /tmp"], 0x7ffd66613d40 /* 58 vars */) = 0
    stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
    chdir("/tmp")    
    ```
    chdir - системный вызов, отвечающий за смену рабочей директории. 
    

2.  База данных находится в /usr/share/misc/magic.mgc. Если бинарного файла .mgc нет в системе, то она использует 
    файлы из /usr/share/misc/magic, чтобы его создать.  
   
    ```
    michael@michael-pc:~$ strace file /bin/bash 2>&1 | grep magic
    openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
    stat("/home/michael/.magic.mgc", 0x7ffead22ac40) = -1 ENOENT (No such file or directory)
    stat("/home/michael/.magic", 0x7ffead22ac40) = -1 ENOENT (No such file or directory)
    openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
    stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
    openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
    openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3     
    ```
    Из вывода strace видно, что вначале программа ищет скомпилированный файл в домашней директории пользователя, а не 
    найдя его, пытается найти там же файлы, из которых можно было бы его создать. Потом цикл повторяется для 
    /etc/magic.mgc и директории /etc/magic. После этого обращается к /usr/share/misc/magic.mgc и находит файл.
    Дальнейшие поиски не требуются.

    
3.  С помощью lsof ищем номер декскриптора куда идут логи. Потом перенаправляем туда пустоту:
    ```
    cat /dev/null > /proc/<PID>/fd/<fd>
    ```
4.  Зомби-процесс не занимает никаких ресурсов. Это просто информация об отработавшем процессе и его код завершения. 
    Сам по себе зомби-процесс не является серьезной проблемой, но может быть симптомом чего-то более опасного.
5.  ```
    vagrant@vagrant:~$ sudo opensnoop-bpfcc
    PID    COMM               FD ERR PATH
    763    vminfo              5   0 /var/run/utmp
    596    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
    596    dbus-daemon        17   0 /usr/share/dbus-1/system-services
    596    dbus-daemon        -1   2 /lib/dbus-1/system-services
    596    dbus-daemon        17   0 /var/lib/snapd/dbus-1/system-services/
    384    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
    384    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
    ```    
    Вот список вызовов. Дальше он периодически повторяется, кроме последних двух. Не уверен, нужно ли что-то ещё
    здесь делать.
    

6.  uname
    >Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
7.  Символ ; просто разграничивает команды, а && выполняет следующую команду только если предыдущая завершилась
    с кодом 0.
    Опция -e в команде set делает то же самое - прерывает выполнение, если команда завершиласть с ненулевым кодом.
    

8.  Команда устанавливает следующие опции:
    - прервать моментально, если статус выхода ненулевой
    - при подстановке переменных, если переменная не задана - считать это ошибкой
    - выводить команды и их аргументы в процессе выполнения
    - пайп завершается ошибкой, если хотя бы одна команда завершилась ошибкой
    
    Такой набор опций позволяет отслеживать выполнение скрипта и видеть где возникают ошибки.    
    

9.  Больше всего обычных спящих процессов:
    ```
    michael@michael-pc:~/devops-netology/virtual-ubuntu-20.04$ ps axo stat | grep -c S
    255
    ```
    Дополнительные символы:
    ><    high-priority (not nice to other users)  
    N    low-priority (nice to other users)  
    L    has pages locked into memory (for real-time and custom IO)  
    s    is a session leader  
    l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)  
    \+    is in the foreground process group  
