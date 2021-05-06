#!/usr/bin/env python3

from datetime import datetime

meminfo = {}
with open('/proc/meminfo') as file:
    for line in file:
        key, value = line.split(':')
        meminfo[key] = value.strip()

loadavg = []
with open('/proc/loadavg') as file:
    loadavg = file.read().split()

uptime = []
with open('/proc/uptime') as file:
    uptime = file.read().split()

current_date = datetime.now().strftime('%Y-%m-%d')
current_time = datetime.now().strftime('%H:%M:%S')
log = str({"timestamp": current_time, "meminfo": meminfo, "loadavg": loadavg, "uptime": uptime})
with open('/var/log/' + current_date + '-awesome-monitoring.log', "a+") as file:
    file.seek(0)
    if len(file.read(100)) > 0:
        file.write("\n")
    file.write(log)
