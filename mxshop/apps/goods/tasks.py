# -*- coding: utf-8 -*-

import time
from celery import task,shared_task
from django.conf import settings
import logging

logger = logging.getLogger(__name__)


@shared_task
def add(x,y):
    try:
        print("\n开始发送msg")
        time.sleep(5)
        print("\n[Done]")
        return x+y
    except Exception as e:
        logger.error("sleep: {}".format(e))
