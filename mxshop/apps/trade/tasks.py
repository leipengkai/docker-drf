# -*- coding: utf-8 -*-

import time
from celery import task,shared_task
from django.conf import settings
import logging

logger = logging.getLogger(__name__)


@shared_task
def test_msg(msg):
    try:
        logger.info("\n开始发送msg")
        logger.info(msg)
    except Exception as e:
        logger.error("sleep: {}".format(e))
