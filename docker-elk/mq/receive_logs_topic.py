#!/usr/bin/env python
import pika
import sys

credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare(exchange='topic_logs', exchange_type='topic')
# topic:路由模糊匹配

result = channel.queue_declare('', exclusive=True)
queue_name = result.method.queue

binding_keys = sys.argv[1:]
if not binding_keys:
    sys.stderr.write("Usage: %s [binding_key]...\n" % sys.argv[0])
    sys.exit(1)

for binding_key in binding_keys:
    channel.queue_bind(
        exchange='topic_logs', queue=queue_name, routing_key=binding_key)

print(' [*] Waiting for logs. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))


channel.basic_consume(
    queue=queue_name, on_message_callback=callback, auto_ack=True)

channel.start_consuming()

# *(星号)用来表示一个单词.
# #(井号)用来表示任意数量(零个或多个)单词

# 执行下边命令 接收所有日志：
# python receive_logs_topic.py "#"

# 执行下边命令 接收来自”kern“设备的日志：
# python receive_logs_topic.py "kern.*"

# 执行下边命令 只接收严重程度为”critical“的日志：
# python receive_logs_topic.py "*.critical"

# 执行下边命令 建立多个绑定：
# python receive_logs_topic.py "kern.*" "*.critical"

