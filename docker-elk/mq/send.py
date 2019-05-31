#!/usr/bin/env python

import pika 

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))

channel = connection.channel()

channel.queue_declare(queue='hello')

for i in range(21):
    channel.basic_publish(
        routing_key='hello', 
        exchange='', 
        body=str(i),
    )
    print(" [x] Sent {}".format(str(i)))

connection.close()

# 生成产生产很快,消费者需要处理耗时任务(eg:业务逻辑处理)
# 一对一的模式,消费者可能会来不及处理,而且当channel变时,双方都得改成一致的
