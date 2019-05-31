#!/usr/bin/env python
import pika
import sys

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare(exchange='direct_logs', exchange_type='direct')
# direct:精确路由匹配

result = channel.queue_declare('', exclusive=True)
queue_name = result.method.queue

severities = sys.argv[1:]
if not severities:
    sys.stderr.write("Usage: %s [info] [warning] [error]\n" % sys.argv[0])
    sys.exit(1)

for severity in severities:
    channel.queue_bind(
        exchange='direct_logs', queue=queue_name, routing_key=severity)

print(' [*] Waiting for logs. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))


channel.basic_consume(
    queue=queue_name, on_message_callback=callback, auto_ack=True)

channel.start_consuming()

# 分发一个消息给多个消费者,订阅,发布多个队列(多运行几个消费者) 一个生产者 多个随机队列对应多个消费者
# 当来一个消息时,按路由规则分配到不同的队列中

# 接收 info 
# 
# 接收 error

