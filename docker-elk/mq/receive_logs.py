#!/usr/bin/env python
import pika

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare(exchange='logs', exchange_type='fanout')
# 交换机名,交换机类型

result = channel.queue_declare('', exclusive=True)
# '':先将消息队列频道为空
# 当与消费者(consumer)断开连接的时候,这个队列应当被立即删除.exclusive标识符即可达到此目的
queue_name = result.method.queue
# 获得已经生成的随机队列

channel.queue_bind(exchange='logs', queue=queue_name)

print(' [*] Waiting for logs. To exit press CTRL+C')

def callback(ch, method, properties, body):
    print(" [x] %r" % body)

channel.basic_consume(
    queue=queue_name, on_message_callback=callback, auto_ack=True)

channel.start_consuming()
# 订阅模式:一个生产者 多个消费者 每个消费者都有自己的队列
# 分发一个消息给多个消费者,订阅,发布多个队列(多运行几个消费者,每个队列可以有多个频道) 一个生产者 多个随机队列对应多个消费者
# 一个消息 分配给每个队列


# python receive_logs.py >> logs_from_rabbit.log
# python receive_logs.py 

