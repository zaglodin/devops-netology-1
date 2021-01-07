#!/usr/bin/env python3

import subprocess

services_domains = ['drive.google.com', 'mail.google.com', 'google.com']
services_ips = []
services_ips_past = []

for service in services_domains:
    ping = subprocess.run(['ping', service, '-c 1'], capture_output=True)
    if ping.returncode == 0:
        services_ips.append(str(ping.stdout).split('(')[1].split(')')[0])
    else:
        services_ips.append('Unavailable')

try:
    file = open('list-ip')
    services_ips_past = file.read().split('\n')
except FileNotFoundError:
    print('First check. The current IP value is recorded.')
    services_ips_past = services_ips 
else:
    file.close

for i in range(0,3):
    if services_ips[i] == services_ips_past[i]:
        print(services_domains[i], ' - ', services_ips[i])
    else:
        print(services_domains[i], ' - ', services_ips[i], ' (Address changed. Old address - ', services_ips_past[i], ')')

file = open('list-ip', 'w')
for ip in services_ips:
    file.write(ip + '\n')
file.close
