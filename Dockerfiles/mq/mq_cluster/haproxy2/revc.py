#!/usr/bin/env python

import time
import pika

# 用户认证
credentials = pika.PlainCredentials('admin', 'admin')

# 以阻塞的方式连接到"/"下这个Vhost
connection = pika.BlockingConnection(pika.ConnectionParameters('0.0.0.0',5676,'/',credentials))
channel = connection.channel()

# 定义一个队列
channel.queue_declare(queue='jj')

def callback(ch, method, properties, body):
    # 消费者收到消息后,执行此回调
    print(" [x] Received %r" % body)
    time.sleep(1)

# 从队列中拿取消息,指定回执函数并只要拿到队列的消息,就从队列中将此消息删除,不管业务有没有执行成功
channel.basic_consume(queue='jj', on_message_callback=callback, auto_ack=True)
#  auto_ack=False,队列的消息不会删除,要手动回执

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
# mq不允许重新定义(不同参数)一个已经存在的队列

# 以python revc.py  来模拟启动消费者消费,从而处理真正的业务流程

# 先多运行几个revc.py ,再启动python send.py(没有持久化消息和手动回执,所以要先监听任务). 生产者的消息会以轮询的方式来分配给消费者
