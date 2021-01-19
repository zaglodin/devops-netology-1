#!/usr/bin/env bash

error=0

while (($error != 1)); do
  for i in "192.168.0.1" "173.194.222.113" "87.250.250.242"; do
    curl "http://"$i":80" -m 1 >/dev/null 2>&1
    if (($? !=0 )); then
      echo `date` $i "- недоступен" >> error.log
      error=1
      break
    fi
    echo `date` $i "- доступен" >> curl.log
  done
  sleep 1s
done