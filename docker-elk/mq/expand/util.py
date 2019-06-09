#!/usr/bin/env python
# -*- coding:utf-8 -*-

import pika
from config import *


def get_mq_channel_no_exchange():
    """
    不指定交换机的通道和连接
    :return: mq connection, channel
    """
    credentials = pika.PlainCredentials(MQUSER, MQPAWD)
    connection = pika.BlockingConnection(pika.ConnectionParameters(MQIP, MQPORT, MQVHOST, credentials))
    channel = connection.channel()

    return connection, channel


def get_mq_channel():
    """
    指定交换机的通道和连接
    :return: mq connection, channel
    """
    connection, channel = get_mq_channel_no_exchange()
    channel.exchange_declare(exchange=MQEXCHANGE, exchange_type=MQEXCHANGETYPE)
    return connection, channel


def get_random_code():
    """
    随机码
    :return:
    """
    import random
    code = ''.join(str(random.randint(0, 9)) for _ in range(5))
    return code
