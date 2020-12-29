#!/usr/bin/env bash

for ((i=1; i<6; i++)); do

  curl http://192.168.0.1:80 -m 1 >/dev/null 2>&1
  if (($? == 0)); then
    echo `date` "192.168.0.1 - доступен" >> curl.log
  else
    echo `date` "192.168.0.1 - недоступен" >> curl.log
  fi

  curl http://173.194.222.113:80 -m 1 >/dev/null 2>&1
  if (($? == 0)); then
    echo `date` "73.194.222.113 - доступен" >> curl.log
  else
    echo `date` "73.194.222.113 - недоступен" >> curl.log
  fi

  curl http://87.250.250.242:80 -m 1 >/dev/null 2>&1
  if (($? == 0)); then
    echo `date` "87.250.250.242 - доступен" >> curl.log
  else
    echo `date` "87.250.250.242 - недоступен" >> curl.log
  fi

  sleep 1s

done

