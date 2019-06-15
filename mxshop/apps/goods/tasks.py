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


# docker exec -it dockerfiles_web_1 bash
# celery worker -A mxshop -l info -b amqp://rabbitmq:rabbitmq@192.168.50.178:5672  --result-backend redis://192.168.50.178:6379/0
# celery worker -A mxshop -l info -b amqp://rabbitmq:rabbitmq@192.168.43.173:5672  --result-backend redis://192.168.43.173:6379/0
# celery worker -A mxshop -l info -b amqp://rabbitmq:rabbitmq@192.168.50.178:5672

# 调用任务: http://0.0.0.0:8080/api/v1/goods/1/
