# Homework 6.4

1. Вывод списка БД - `\l`  
   Подключение к БД - `\c postgres`  
   Вывод списка таблиц - `\d`  
   Вывод описания содержимого таблиц - `\d pg_user`  
   Выход - `\q`

2. Запрос:

    ```sql
    SELECT attname 
    FROM pg_stats
    WHERE tablename = 'orders'
    ORDER BY avg_width DESC
    LIMIT 1
    ```

   Ответ:

    ```txt
    attname
    -----------
    title
    (1 row)
    ```

3. Транзакция:

    ```sql
    BEGIN;

    ALTER TABLE orders RENAME TO orders_old;

    CREATE TABLE orders (LIKE orders_old) PARTITION BY RANGE (price);

    ALTER TABLE orders ADD CONSTRAINT unique_id PRIMARY KEY (id, price);

    CREATE TABLE orders_1 PARTITION OF orders DEFAULT;

    CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM (0) TO (500);

    INSERT INTO orders SELECT * FROM orders_old;

    DROP TABLE orders_old;

    COMMIT;
    ```

   Таблицу нужно было изначально создавать с разбивкой:

    ```sql
    BEGIN;

    CREATE TABLE orders (id integer NOT NULL, title varchar NOT NULL, price integer DEFAULT 0, CONSTRAINT unique_id PRIMARY KEY (id, price)) PARTITION BY RANGE(price);

    CREATE TABLE orders_1 PARTITION OF orders DEFAULT;

    CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM (0) TO (500);

    COMMIT;
    ```

4. Просто добавить в конец дампа базы:

    ```sql
    ALTER TABLE orders ADD CONSTRAINT unique_title UNIQUE (title, price);
    ```
