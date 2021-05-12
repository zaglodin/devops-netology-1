# Homework 10.3

1. Скриншот:

   ![Data sources](https://i.imgur.com/uYgmXt5.png)

2. Скриншот:

   ![Dashboard](https://i.imgur.com/5d5TGXQ.png)

   - `100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)`
   - `node_load1` `node_load5` `node_load15`
   - `((node_memory_MemFree_bytes + node_memory_Buffers_bytes + node_memory_Cached_bytes) / node_memory_MemTotal_bytes) * 100`
   - `node_filesystem_avail_bytes{device="/dev/sdc"} * 100 / node_filesystem_size_bytes{device="/dev/sdc"}`

3. Не сделал алерты для двух панелей, так как они там не поддержаны. Странно, конечно. Но для разнообразия панелей оставил. В реальном же решении, конечно, лучше алерты, чем красивый дашборд.

   ![Dashboard](https://i.imgur.com/zXM1hpP.png)

4. [JSON файл тут](dashboard.json)
