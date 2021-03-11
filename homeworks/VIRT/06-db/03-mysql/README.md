# Homework 6.3

1. Версия сервера:

    ```txt
    Server version:         8.0.23 MySQL Community Server - GPL
    ```

   Запрос к таблице и ответ:

    ```txt
    mysql> SELECT count(*)
        -> FROM mysql.orders
        -> WHERE price >= 300;
    +----------+
    | count(*) |
    +----------+
    |        3 |
    +----------+
    ```

2. Создаем пользователя:

    ```sql
    CREATE USER 'test' @'localhost'
    ATTRIBUTE '{"fname": "James", "lname": "Pretty"}' 
    IDENTIFIED WITH mysql_native_password BY 'test' 
    WITH MAX_CONNECTIONS_PER_HOUR 100 
    PASSWORD EXPIRE INTERVAL 180 DAY
    FAILED_LOGIN_ATTEMPTS 3
    ```

   Предоставляем права:

    ```sql
    GRANT SELECT ON mysql.* TO 'test'@'localhost'
    ```

    Атрибуты:

    ```txt
    USER|HOST     |ATTRIBUTE                            |
    ----|---------|-------------------------------------|
    test|localhost|{"fname": "James", "lname": "Pretty"}|
    ```

3. Движок:

    ```txt
    TABLE_NAME|ENGINE|
    ----------|------|
    orders    |InnoDB|
    ```

   Изменение движка:

    ```txt
    mysql> show profiles;
    +----------+------------+------------------------------------------+
    | Query_ID | Duration   | Query                                    |
    +----------+------------+------------------------------------------+
    |        1 | 2.16039375 | ALTER TABLE mysql.orders ENGINE = MyISAM |
    |        2 | 2.57552375 | ALTER TABLE mysql.orders ENGINE = InnoDB |
    +----------+------------+------------------------------------------+
    2 rows in set, 1 warning (0.00 sec)
    ```

4. Добавить в файл следующие строки:

    ```txt
    [mysqld]
    innodb-flush-method = O_DSYNC
    innodb-file-per-table = 1
    innodb-log-buffer-size = 1M
    # Для системы с 32 ГБ оперативы
    innodb_buffer_pool_size = 9600M
    innodb_log_file_size = 100M
    ```
