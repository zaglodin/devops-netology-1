# Homework 5.3

1.
   - Высоконагруженное монолитное java веб-приложение. **НЕТ**. Если оно монолитное, то особой необходимости в использовании докера нет, так как мы не сможем быстро обновлять его составные части. Проще использовать обычную виртуалку. Но и особых противопоказаний нет, кроме (возможно) большого веса образа. Разве что масштабировать проще контейнеры.
   - Go-микросервис для генерации отчетов. **ДА**. Небольшой легковесный сервис проще держать в контейнере. Легко обновить, восстановить, перенести.
   - Nodejs веб-приложение. **ДА**. Если часто обновляется, то лучше в контейнер, чтобы не было проблем с зависимостями. Но можно и на виртуалке.
   - Мобильное приложение c версиями для Android и iOS. **НЕТ**. Виртуалка или железо. Я полагаю, что здесь имеется в виду для тестов. Эмуляция будет лучше работать при установке непосредственно на железо.
   - База данных postgresql используемая, как кэш. **НЕТ**. Базы данных нельзя хранить в контейнерах, во избежание потери данных. Можно использовать виртуалку.
   - Шина данных на базе Apache Kafka. **ДА**. Не очень представляю как это работает, но исходя из того, что я нагуглил - почему бы и нет. Не вижу ни плюсов, ни минусов.
   - Очередь для Logstash на базе Redis. **НЕТ**. Опять база данных, причем, скорее всего, высоконагруженная и важна скорость. На железо.
   - Elastic stack для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana. **ДА**. Мне кажется, что logstash и кибану вполне можно отправить в контейнеры и никаких проблем с этим не будет. А вот elasticsearh это хранилище, поэтому лучше развернуть на железе или виртуалке.
   - Мониторинг-стек на базе prometheus и grafana. **ДА**. Не вижу никаких проблем для запуска обоих приложений в контейнере, так что почему бы и нет.
   - Mongodb, как основное хранилище данных для java-приложения. **НЕТ**. База данных, поэтому железо, или, в крайнем случае, виртуалка.
   - Jenkins-сервер. **ДА**. Опять же, раз нет никаких останавливающих факторов, то почему бы не запустить в контейнере - так проще.

2. [Ссылка на образ](https://hub.docker.com/repository/docker/ventshahta/homework-5.3)

   ```commandline
   vagrant@vagrant:~/apache_homework$ sudo docker build -t ventshahta/homework-5.3 .
   Sending build context to Docker daemon  3.584kB
   Step 1/2 : FROM httpd:latest
   ---> 683a7aad17d3
   Step 2/2 : COPY ./public-html/devops.html /usr/local/apache2/htdocs/index.html
   ---> 54ed195601af
   Successfully built 54ed195601af
   Successfully tagged ventshahta/homework-5.3:latest
   vagrant@vagrant:~/apache_homework$ sudo docker run -dit --name homework -p 8080:80 ventshahta/homework-5.3
   44db249cf4865888effcf82d35c7502ffce28fde07ae9d1ac5ba6535fd15130f
   vagrant@vagrant:~/apache_homework$ curl http://localhost:8080
   <html>
   <head>
   Hey, Netology
   </head>
   <body>
   <h1>Im kinda DevOps now</h1>
   </body>
   </html>
   vagrant@vagrant:~/apache_homework$ sudo docker push ventshahta/homework-5.3
   Using default tag: latest
   The push refers to repository [docker.io/ventshahta/homework-5.3]
   cea5f7ab2805: Pushed
   32b1cc17aaca: Mounted from library/httpd
   7692ddbf3d7c: Mounted from library/httpd
   1fc0cf4346af: Mounted from library/httpd
   501a1739002e: Mounted from library/httpd
   cb42413394c4: Mounted from library/httpd
   latest: digest: sha256:64db95be4c76a813f965edc7e2ec0d2072e01a47c8f1a0194f80f98bad94517c size: 1573
   ```

3. ```commandline
   vagrant@vagrant:~/homework$ sudo docker run -td --name centos -v $PWD/info:/share/info centos /bin/bash
   d9ef769029b316b33a8a88b48a2a9b5855508d0354a8b14724765287d74c4f03
   vagrant@vagrant:~/homework$ sudo docker run -td --name debian -v $PWD/info:/share/info debian /bin/bash
   340d0c8dccc9cdf775444eb77087483ccc587f2a7bf200ac40298e1b6a2d98b7
   vagrant@vagrant:~/homework$ sudo docker exec -it centos bash -c "touch /share/info/test"
   vagrant@vagrant:~/homework$ touch info/test2
   vagrant@vagrant:~/homework$ sudo docker exec -it debian bash -c "ls /share/info"
   test  test2
   ```
