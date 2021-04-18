# Homework 6.2

1. [Compose файл](docker-compose.yml)

2. Список таблиц:

    ```txt
        test_db=# \d orders
                                    Table "public.orders"
    Column |         Type          | Collation | Nullable |              Default
    --------+-----------------------+-----------+----------+------------------------------------
    id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
    name   | character varying(20) |           |          |
    price  | integer               |           |          |
    Indexes:
        "orders_pkey" PRIMARY KEY, btree (id)
    Referenced by:
        TABLE "clients" CONSTRAINT "clients_order_fkey" FOREIGN KEY ("order") REFERENCES orders(id)

    test_db=# \d clients
                                        Table "public.clients"
    Column  |         Type          | Collation | Nullable |               Default
    ---------+-----------------------+-----------+----------+-------------------------------------
    id      | integer               |           | not null | nextval('clients_id_seq'::regclass)
    name    | character varying(20) |           |          |
    country | character varying(20) |           |          |
    order   | integer               |           |          |
    Indexes:
        "clients_pkey" PRIMARY KEY, btree (id)
        "country_idx" btree (country)
    Foreign-key constraints:
        "clients_order_fkey" FOREIGN KEY ("order") REFERENCES orders(id)
    ```

    Запрос прав таблицы:

    ```sql
    SELECT grantee, privilege_type
    FROM information_schema.role_table_grants
    WHERE table_name = 'orders'
    AND grantee != 'postgres'
    ```

   Ответ:

    ```txt
    grantee         |privilege_type|
    ----------------|--------------|
    test-admin-user |INSERT        |
    test-admin-user |SELECT        |
    test-admin-user |UPDATE        |
    test-admin-user |DELETE        |
    test-admin-user |TRUNCATE      |
    test-admin-user |REFERENCES    |
    test-admin-user |TRIGGER       |
    test-simple-user|INSERT        |
    test-simple-user|SELECT        |
    test-simple-user|UPDATE        |
    test-simple-user|DELETE        |
    ```

3. Заполняем orders:

    ```sql
    INSERT INTO public.orders (name, price)
    VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);
    ```

   Заполняем clients:

    ```sql
    INSERT INTO public.clients (name, country)
    VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');
    ```

   Считаем:

    ```sql
    SELECT count(*)
    FROM public.orders
    ```

   Ответ:

    ```txt
    count|
    -----|
        5|
    ```

4. Заполняем покупки:

    ```sql
    UPDATE clients AS c SET
    "order" = t."order"
    FROM (
    VALUES ('Иванов Иван Иванович', 3), ('Петров Петр Петрович', 4), ('Иоганн Себастьян Бах', 5)) AS t(name, "order")
    WHERE t.name = c.name
    ```

   Ищем всех с покупками:

    ```sql
    SELECT "name" AS ФИО
    FROM public.clients
    WHERE "order" NOTNULL
    ```

   Ответ:

    ```txt
    ФИО                 |
    --------------------|
    Петров Петр Петрович|
    Иванов Иван Иванович|
    Иоганн Себастьян Бах|
    ```

5. Время запуска - 0. Затраты на получение первой строки. Грубо говоря время, через которое начнется вывод.  
   Общие затраты - 15.30. Общие затраты на получение всех строк.  
   Ожидаемое количество строк - 527.  
   Средний размер строки в байтах - 58.  

    ```txt
    QUERY PLAN                                               |
    ---------------------------------------------------------|
    Seq Scan on clients  (cost=0.00..15.30 rows=527 width=58)|
    Filter: ("order" IS NOT NULL)                            |
    ```

6. Дамп:

    ```txt
    pg_dumpall -U postgres > /var/lib/postgresql/data/db-backup/test_db
    ```

   Восстановление:

    ```txt
    psql -U postgres -f /var/lib/postgresql/data/db-backup/test_db postgres
    ```
