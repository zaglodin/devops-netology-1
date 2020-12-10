# Homework 3.5

1.  done
   

2.  Нет, так как ссылки хранятся в данных директории. В них самих нет информации о разрешениях этого файла.
   

3.  ```commandline
    vagrant@vagrant:~$ lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    sdc                    8:32   0  2.5G  0 disk
    ```
   
4.  ```commandline
    vagrant@vagrant:~$ sudo fdisk -l
    
    <...>
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux
    ```


5.  ```commandline
    vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc
    Checking that no-one is using this disk right now ... OK
    
    <...>
    
    New situation:
    Disklabel type: dos
    Disk identifier: 0xe3e27fba
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdc1          2048 4196351 4194304    2G 83 Linux
    /dev/sdc2       4196352 5242879 1046528  511M 83 Linux
    ```
    
6.  ```commandline
    vagrant@vagrant:~$ sudo mdadm --create  --verbose /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
    mdadm: Note: this array has metadata at the start and
        may not be suitable as a boot device.  If you plan to
        store '/boot' on this device please ensure that
        your boot-loader understands md/v1.x metadata, or use
        --metadata=0.90
    mdadm: size set to 2094080K
    Continue creating array? y
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md1 started.
    ```
    
7.  ```commandline
    vagrant@vagrant:~$ sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
    mdadm: chunk size defaults to 512K
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md0 started.
    ```
    
8.  ```commandline
    vagrant@vagrant:~$ sudo pvcreate /dev/md0
      Physical volume "/dev/md0" successfully created.
    vagrant@vagrant:~$ sudo pvcreate /dev/md1
      Physical volume "/dev/md1" successfully created.
    ```
    
9.  ```commandline
    vagrant@vagrant:~$ sudo vgcreate vg1 /dev/md0 /dev/md1
      Volume group "vg1" successfully created
    ```
    
10. ```commandline
    vagrant@vagrant:~$ sudo lvcreate --size 100M /dev/vg1 /dev/md0
      Logical volume "lvol0" created.
    ```
    
11. ```commandline
    vagrant@vagrant:~$ sudo mkfs.ext4 /dev/vg1/lvol0
    mke2fs 1.45.5 (07-Jan-2020)
    Creating filesystem with 25600 4k blocks and 25600 inodes
    
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (1024 blocks): done
    Writing superblocks and filesystem accounting information: done
    ```
    
12. ```commandline
    vagrant@vagrant:~$ sudo mount /dev/vg1/lvol0 /tmp/new
    ```
    
13. ```commandline
    vagrant@vagrant:/tmp/new$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
    .--2020-12-10 11:51:47--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
    Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
    Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 20994997 (20M) [application/octet-stream]
    Saving to: ‘/tmp/new/test.gz’
    
    /tmp/new/test.gz                                            100%[========================================================================================================================================>]  20.02M  8.67MB/s    in 2.3s
    
    2020-12-10 11:51:55 (8.67 MB/s) - ‘/tmp/new/test.gz’ saved [20994997/20994997]
    ```
    
14. ```commandline
    vagrant@vagrant:/tmp/new$ lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part  /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    ├─sdb1                 8:17   0    2G  0 part
    │ └─md1                9:1    0    2G  0 raid1
    └─sdb2                 8:18   0  511M  0 part
      └─md0                9:0    0 1018M  0 raid0
        └─vg1-lvol0      253:2    0  100M  0 lvm   /tmp/new
    sdc                    8:32   0  2.5G  0 disk
    ├─sdc1                 8:33   0    2G  0 part
    │ └─md1                9:1    0    2G  0 raid1
    └─sdc2                 8:34   0  511M  0 part
      └─md0                9:0    0 1018M  0 raid0
        └─vg1-lvol0      253:2    0  100M  0 lvm   /tmp/new
    ```
    
15. ```commandline
    vagrant@vagrant:/tmp/new$ gzip -t test.gz
    vagrant@vagrant:/tmp/new$ echo $?
    0
    ```
    
16. ```commandline
    vagrant@vagrant:/tmp/new$ sudo pvmove /dev/md0 /dev/md1
      /dev/md0: Moved: 16.00%
      /dev/md0: Moved: 100.00%
    ```
    
17. ```commandline
    vagrant@vagrant:/tmp/new$ sudo mdadm /dev/md1 --fail /dev/sdb1
    mdadm: set /dev/sdb1 faulty in /dev/md1
    ```
    
18. ```commandline
    [Thu Dec 10 12:09:29 2020] md/raid1:md1: Disk failure on sdb1, disabling device.
                               md/raid1:md1: Operation continuing on 1 devices.
    ```
    
19. ```commandline
    vagrant@vagrant:/tmp/new$ gzip -t test.gz
    vagrant@vagrant:/tmp/new$ echo $?
    0
    ```
    
20. done