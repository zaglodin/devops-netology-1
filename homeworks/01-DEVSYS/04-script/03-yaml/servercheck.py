#!/usr/bin/env python3

import socket, json, yaml

host_addr = {}
history = {}

for hostname in ['drive.google.com', 'mail.google.com', 'google.com']:
    host_addr[hostname] = socket.gethostbyname(hostname)

try: 
    file = open('hosts.json', 'r')
except FileNotFoundError:
    try:
        file = open('hosts.yaml', 'r')
    except FileNotFoundError:
        print('First check. The current IP value is recorded.')
        history = host_addr
    else:
       history = yaml.safe_load(file.read()) 
else:
    history = json.loads(file.read())
    file.close()

for hostname in host_addr.keys():
    if host_addr[hostname] == history[hostname]:
        print(hostname, ' - ', host_addr[hostname])
    else:
        print(hostname, ' - ', host_addr[hostname], ' (WARNING!!! Address changed!)')

with open('hosts.json', 'w') as file:
    file.write(json.dumps(host_addr))

with open('hosts.yaml', 'w') as file:
    file.write(yaml.dump(host_addr))
