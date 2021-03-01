# Homework 6.5

1. [Dockerfile](dockerfile). Нельзя запускать под рутом, поэтому столько лишних действий... Насколько я понял, раньше был вариант отключить эту защиту, но сейчас он не работает.

   [Образ](https://hub.docker.com/repository/docker/myamshchikov/elasticsearch). Для обновления образа при выходе новой версии, достаточно просто скачать новый архив и переименовать его в elasticsearch.tar.gz.

   Ответ:

   ```json
    {
      "name" : "netology_test",
      "cluster_name" : "elasticsearch",
      "cluster_uuid" : "prwx03jiQO-CG29KZcE5nA",
      "version" : {
        "number" : "7.11.1",
        "build_flavor" : "default",
        "build_type" : "tar",
        "build_hash" : "ff17057114c2199c9c1bbecc727003a907c0db7a",
        "build_date" : "2021-02-15T13:44:09.394032Z",
        "build_snapshot" : false,
        "lucene_version" : "8.7.0",
        "minimum_wire_compatibility_version" : "6.8.0",
        "minimum_index_compatibility_version" : "6.0.0-beta1"
      },
      "tagline" : "You Know, for Search"
    }
    ```

2. Статус индексов:

    ```txt
    michael@michael-pc:~/devops-netology$ curl -X GET "localhost:9200/_cat/indices"
    green  open ind-1 pBvg4LHvQ_id_v1UqqhMJw 1 0 0 0 208b 208b
    yellow open ind-3 ZeUOCA3kTjee4ir1ZoEeDw 4 2 0 0 832b 832b
    yellow open ind-2 R8gwKToPQU2-Iqj9yXmSuQ 2 1 0 0 416b 416b
    ```

   Статус кластера:

    ```json
    michael@michael-pc:~/devops-netology$ curl -X GET "localhost:9200/_cluster/health?pretty"
    {
      "cluster_name" : "elasticsearch",
      "status" : "yellow",
      "timed_out" : false,
      "number_of_nodes" : 1,
      "number_of_data_nodes" : 1,
      "active_primary_shards" : 7,
      "active_shards" : 7,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 10,
      "delayed_unassigned_shards" : 0,
      "number_of_pending_tasks" : 0,
      "number_of_in_flight_fetch" : 0,
      "task_max_waiting_in_queue_millis" : 0,
      "active_shards_percent_as_number" : 41.17647058823529
    }
    ```

   Желтые - индексы с ненулевым количеством реплик. Их некуда назначить, поэтому статус желтый.

3. Создание репозитория:

    ```json
    michael@michael-pc:~/devops-netology$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
    {
      "type": "fs",
      "settings": {
        "location": "snapshots"
      }
    }
    '
    {
      "acknowledged" : true
    }
    ```

   Снапшоты:

    ```txt
    sh-4.2$ ls -l 
    total 48
    -rw-r--r-- 1 elasticsearch elasticsearch   434 Mar  1 07:52 index-0
    -rw-r--r-- 1 elasticsearch elasticsearch     8 Mar  1 07:52 index.latest
    drwxr-xr-x 3 elasticsearch elasticsearch  4096 Mar  1 07:52 indices
    -rw-r--r-- 1 elasticsearch elasticsearch 30878 Mar  1 07:52 meta-SW6S2_2FSeC5Wvq0XA8R7A.dat
    -rw-r--r-- 1 elasticsearch elasticsearch   266 Mar  1 07:52 snap-SW6S2_2FSeC5Wvq0XA8R7A.dat
    ```

   Удалил, создал. Запрос списка индексов:

    ```txt
    michael@michael-pc:~/devops-netology$ curl localhost:9200/_cat/indices?pretty
    green open test-2 dkjnfqe1ToKgZ_Z8YGKx-w 1 0 0 0 208b 208b
    ```

   Восстановление и список индексов:

    ```json
    michael@michael-pc:~/devops-netology$ curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty"
    {
      "accepted" : true
    }
    michael@michael-pc:~/devops-netology$ curl localhost:9200/_cat/indices?pretty
    green open test-2 dkjnfqe1ToKgZ_Z8YGKx-w 1 0 0 0 208b 208b
    green open test   Q9kMe6LzTn2w6yQVioXHWg 1 0 0 0 208b 208b
    ```

curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "include_global_state": true
}
'

