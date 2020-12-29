#!/usr/bin/env bash

while ((1==1)); do
  curl https://localhost:47572 >/dev/null 2>&1
  if (($? != 0)); then
    date >> curl.log
    sleep 1s
  else
    break
  fi
done