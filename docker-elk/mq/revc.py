#!/usr/bin/env python

import time
import pika

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))
channel = connection.channel()

channel.queue_declare(queue='hello')

def callback(ch, method, properties, body):
    # 收到消息后,执行此回调
    print(" [x] Received %r" % body)
    time.sleep(1)

channel.basic_consume(queue='hello', on_message_callback=callback, auto_ack=True)
#  auto_ack=False,队列的消息不会删除,要手动回执

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
# mq不允许重新定义(不同参数)一个已经存在的队列
# http://0.0.0.0:15672/#/queues
# https://www.rabbitmq.com/getstarted.html
# https://rabbitmq.mr-ping.com/tutorials_with_python/[1]Hello_World.html  # 中文已经不可用
