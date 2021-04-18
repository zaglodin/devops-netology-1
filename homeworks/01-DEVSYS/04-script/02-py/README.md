# Homework 4.2

1.
   1. Никакое, так как складывается число и строка. Будет ошибка.
   2. `c = str(a) + b`
   3. `c = a + int(b)`

2. [Скрипт](gitstatus-v0.py)

   ```commandline
   michael@michael-pc:~/devops-netology$ /usr/bin/python3 /home/michael/devops-netology/homeworks/homework-4.2/gitstatus-v0.py
   Changed files:
   /home/michael/devops-netology/homeworks/homework-3.9/README.md
   /home/michael/devops-netology/homeworks/homework-4.1/README.md
   ```

3. [Скрипт](gitstatus-v1.py)

   На вход подается путь к директории с репозиторием, на выходе список измененных файлов. Так как на вход можно подать путь со слэшем на конце ('/') или без, то использовать этот путь при формировании конечного вывода нельзя - слэш может задвоиться. Поэтому при формировании строк вывода запрашивается текущая директория - она всегда будет одинаковая.

   Думал записывать данные полученные на ввод в переменную, проверять наличие слэша на конце и убирать его (ну или проверку двойных слэшей в самом конце), но так получилось бы более громоздко. А так хоть и выполняется запрос текущей директории при формировании каждой строки, но зато проще и нагляднее. Подскажите, если есть более красивое решение. А то я вообще никакого опыта в программировании не имею, так что сидел и думал над этими двумя простыми задачками довольно долго =)

   Вывод получается такой:

   ```commandline
   michael@michael-pc:~/devops-netology$ /usr/bin/python3 /home/michael/devops-netology/homeworks/homework-4.2/gitstatus.py
   Please enter project path: 
   /home/michael/devops-netology
   Changed files:
   /home/michael/devops-netology/homeworks/homework-3.9/README.md
   /home/michael/devops-netology/homeworks/homework-4.1/README.md
   ```

4. [Скрипт](servercheck.py).
   При запуске проверяет доступность сервисов и записывает адреса в файл. При каждом следующем запуске сравнивает полученное значение с предыдущим.

   ```commandline
   michael@michael-pc:~/devops-netology$ /usr/bin/python3 /home/michael/devops-netology/homeworks/homework-4.2/servercheck.py
   drive.google.com  -  64.233.161.194
   mail.google.com  -  64.233.162.83  (Address changed. Old address -  64.233.162.18 )
   google.com  -  64.233.165.138
   ```
