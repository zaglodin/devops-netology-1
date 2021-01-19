# Homework 3.9

1.  ```
    vagrant@vagrant:~$ sudo apt install vault
    Reading package lists... Done
    <...>
    Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
    vagrant@vagrant:~$
    
    ```
    
2.  Установлен:

    ![](https://i.imgur.com/1VrhJim.png)

3.  Ссылка на сгенерированный промежуточный сертификат:
    https://drive.google.com/file/d/1AL-khA6cuz7zwGL2V98cru3JWRFQ0SM2/view?usp=sharing
    
4.  Ссылка на сгенерированный сертификат:
    https://drive.google.com/file/d/1wP_XDMeaAUrY3ik2ahp6ua7uzWFjNwk6/view?usp=sharing
    
5.  Добавил сертификат в конфиг. Сейчас не открывается:
    
    ```
    vagrant@vagrant:~$ curl -I https://netology.example.com/
    curl: (60) SSL certificate problem: unable to get local issuer certificate
    More details here: https://curl.haxx.se/docs/sslcerts.html
    
    curl failed to verify the legitimacy of the server and therefore could not
    establish a secure connection to it. To learn more about this situation and
    how to fix it, please visit the web page mentioned above.
    
    ```

6.  Добавил промежуточный сертификат в доверенные. Теперь ок:
    
    ```
    vagrant@vagrant:~$ curl -I https://netology.example.com/
    HTTP/1.1 200 OK
    Server: nginx/1.18.0 (Ubuntu)
    Date: Mon, 28 Dec 2020 09:35:48 GMT
    Content-Type: text/html
    Content-Length: 612
    Last-Modified: Tue, 21 Apr 2020 14:09:01 GMT
    Connection: keep-alive
    ETag: "5e9efe7d-264"
    Accept-Ranges: bytes
    ```
    
7.  Ознакомился. К сожалению, домена у меня нет. Но Letsencrypt часто используется в компании, где я работаю - для
    защиты доменов SaaS клиентов. Сертификаты автоматически обновляются каждые три месяца - видимо, как раз с помощью
    ондого из ACME клиентов. Так что в общих чертах я представляю как это работает, но подробностей не знаю, так как 
    этим занимаются сисадмины =) Но, судя по описанию Certbot, это совсем не сложно.
    
