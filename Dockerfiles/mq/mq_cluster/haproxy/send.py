#!/usr/bin/env python

import pika 

credentials = pika.PlainCredentials('admin', 'admin')
connection = pika.BlockingConnection(pika.ConnectionParameters('0.0.0.0',5677,'/',credentials))

channel = connection.channel()

# 指定定义队列
channel.queue_declare(queue='jj')

for i in range(21):
    # 向队列发送消息
    channel.basic_publish(
            routing_key='jj', # 使用默认的交换机,在生产者中必须指定 routing_key,对应的消费者不需要,而且不能为空与channel.basic_consume(queue='hello')一致
        exchange='', 
        body=str(i),
    )
    print(" [x] Sent {}".format(str(i)))

connection.close()

# 生成产生产很快,消费者需要处理耗时任务(eg:业务逻辑处理)
# 一对一的模式,消费者可能会来不及处理,而且当channel变时,双方都得改成一致的

# 以 python send.py 来模拟业务逻辑的调用(简单产生的字符串消息)  实际中使用API,应该怎么操作?
