#!/usr/bin/env python3

from logging import exception
from time import sleep
from random import randrange
import sentry_sdk

sentry_sdk.init(
    "https://3317d836119c452dbbe6fd634a3c8be3@o684473.ingest.sentry.io/5771567",
    traces_sample_rate=1.0
)

class BadThing(Exception):
    pass

def try_number(number):
    if number == 3:
        raise BadThing

while True:
    number = randrange(0, 10)
    try:
        try_number(number)
    except BadThing:
        exception("This is error")
    sleep(1)
