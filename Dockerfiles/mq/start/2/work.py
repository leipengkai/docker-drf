#!/usr/bin/env python
import pika
import time

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)
print(' [*] Waiting for messages. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)
    # time.sleep(body.count(b'.'))
    time.sleep(5)
    print(" [x] Done")
    ch.basic_ack(delivery_tag=method.delivery_tag)
    # 我们发现即使使用CTRL+C杀掉了一个工作者（worker）进程，消息也不会丢失。当工作者（worker）挂掉这后，所有没有响应的消息都会重新发送
    # 如果忘记basic_ack,队列则会越来越大


channel.basic_qos(prefetch_count=1) # 每个消费者一个一个的分配消息
# Work queues:默认使用轮询分配

channel.basic_consume(queue='task_queue', on_message_callback=callback,auto_ack=False)
# auto_ack=True:消息确认,默认为True
# 我们不想丢失任何任务消息。如果一个工作者（worker）挂掉了，我们希望任务会重新发送给其他的工作者（worker）
# 消费者会通过一个ack（响应），告诉RabbitMQ已经收到并处理了某条消息，然后RabbitMQ就会释放并删除这条消息

channel.start_consuming()

# 一对多:生产者 消费者,同一个队列(保证一个消费者挂掉之后,其它消费者能继续执行)

# 手动回执的前提是定义队列时必须持久化,必须明确指定队列名字,必须要有回执函数

# 启动 python work.py (不分先后new_task.py),在睡眠在ctrl+c,取消掉 
# 再启动 python work.py 还是会消费没有执行成功的消息
# 启动多个 python work.py ,按prefetch_count=1的设置去消费
