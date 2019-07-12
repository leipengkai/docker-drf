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

# 交换机(或者定义队列二选一) 要有队列名(随机队列名:不支持手动回执和队列持久化),定义交换机就必须要绑定
# emit_log.py 只声明交换机(不声明队列名二选一)
# routing_key 如果要设置,两端都要设置.如果不设置,则消息会发送到所有队列中

# 开启两个
# python receive_logs.py >> logs_from_rabbit.log
# python receive_logs.py

# 没有自定义交换机时,只会定义一个队列,可持久化,轮询分配给消费者.生产者定义队列名,发布信息(指定routing_key).消费者:定义队列名(不需要指定routing_key)
# 有交换机时(还不知道怎么持久化),可以有多个队列(随机队列名).生产者定义交换机,消费者定义交换机和绑定操作(交换机,队列名,路由关键字)
