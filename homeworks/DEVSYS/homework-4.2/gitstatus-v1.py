#!/usr/bin/env python3

import os

os.chdir(str(input('Please enter project path: \n')))
result_os = os.popen('git status').read()
prepare_result = []

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result.append(result.replace('\tmodified:   ', str(os.getcwd()) + '/'))

print('Changed files:')
if len(prepare_result) != 0:
    print('\n'.join(prepare_result))
else:
    print('None')
