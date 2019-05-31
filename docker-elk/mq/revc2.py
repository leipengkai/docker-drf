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
    time.sleep(2)


channel.basic_consume(queue='hello', on_message_callback=callback, auto_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()

# 一对多:生产者 消费者,同一个队列

# https://www.rabbitmq.com/tutorials/
# http://rabbitmq.mr-ping.com/tutorials_with_python/[1]Hello_World.html # 中文代码已经不能使用
