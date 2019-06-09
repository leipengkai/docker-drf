#!/usr/bin/env python
import pika
import sys

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)
# 消息持久化(durable=True):RabbitMQ服务器已经接收到生产者的消息,并将此持久化


message = ' '.join(sys.argv[1:]) or "Hello World!"
channel.basic_publish(
    exchange='',
    routing_key='task_queue',
    body=message,
    properties=pika.BasicProperties(
        delivery_mode=2,  # make message persistent
    )
)
print(" [x] Sent %r" % message)
connection.close()


# python new_task.py heloo........ # 有几个点,就睡眠几秒
