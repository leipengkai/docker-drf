#!/usr/bin/env python
import pika
import uuid

# product生产者 client
class FibonacciRpcClient(object):

    def __init__(self):
        credentials = pika.PlainCredentials('rabbitmq', 'rabbitmq')
        self.connection = pika.BlockingConnection(pika.ConnectionParameters('localhost',5672,'/',credentials))

        self.channel = self.connection.channel()

        result = self.channel.queue_declare(queue='', exclusive=True)
        # 客户端需要在发送请求的时候同时发送一个回调队列（callback queue）的地址
        # 这样可以为每个客户端只建立一个独立的回调队列
        self.callback_queue = result.method.queue

        # 订阅这个回调队列
        self.channel.basic_consume(
            queue=self.callback_queue,
            on_message_callback=self.on_response,
            auto_ack=True)

    def on_response(self, ch, method, props, body):
        if self.corr_id == props.correlation_id:
            self.response = body

    def call(self, n):
        self.response = None
        # correlation_id:关联标识(关联是哪一个client)
        # client队列接收到一个响应的时候它无法辨别出这个响应是属于哪个请求的(client)
        self.corr_id = str(uuid.uuid4())
        self.channel.basic_publish(
            exchange='',
            routing_key='rpc_queue',
            properties=pika.BasicProperties(
                reply_to=self.callback_queue,
                correlation_id=self.corr_id,
            ),
            body=str(n))
        while self.response is None:
            self.connection.process_data_events()
        return int(self.response)


fibonacci_rpc = FibonacciRpcClient()

print(" [x] Requesting fib(30)")
response = fibonacci_rpc.call(30)
print(" [.] Got %r" % response)


# 1.当客户端启动的时候,它创建一个匿名独享的回调队列(一个请求完成后自动删除)
# 2.在RPC请求中,客户端发送带有两个属性的消息:一个是设置回调队列的 reply_to 属性,另一个是设置唯一值的 correlation_id 属性
# 3.将请求发送到一个 rpc_queue 队列中
# 4.RPC工作者(又名:服务器)等待请求发送到这个队列中来.当请求出现的时候,它执行他的工作并且将带有执行结果的消息发送给reply_to字段指定的队列
# 5.客户端等待回调队列里的数据.当有消息出现的时候,它会检查correlation_id属性.如果此属性的值与请求匹配,将它返回给应用
