#!/usr/bin/env python
# -*- coding:utf-8 -*-


import json

from config import *
from smsserver import sms
from emailserver import email
from util import get_mq_channel_no_exchange


class Custom():
    def __init__(self):
        self.connection, self.channel = get_mq_channel_no_exchange()

    def handle(self, callback_func):
        """
        消费消息
        :param callback_func: 处理业务的函数
        :return:
        """
        self.channel.queue_declare(queue=QUEUENAME, durable=True)

        def callback(ch, method, properties, body):
            callback_func(method, body)
            r = self.channel.basic_ack(delivery_tag=method.delivery_tag)

        print(' [*] Waiting for logs. To exit press CTRL+C')
        self.channel.basic_consume(queue=QUEUENAME, on_message_callback=callback, auto_ack=False)
        self.channel.start_consuming()


def callback_func(method, body):
    """
    处理不同的业务逻辑(预处理后)
    :param method:
    :param body: 接受到的消息(分析消息后,从而进行不同的处理)
    :return:
    """

    d = json.loads(body, encoding="utf-8")
    target = d['target']  # 手机号 邮件号
    routing_key = d['routing_key']  # eg:sms_register email_info
    key_list = routing_key.split("_")
    target_type = key_list[0]  # sms:短信发送 email:邮件发送
    action = key_list[1]  # register info
    code = d['code'] if d['code'] else None  # 验证码
    print(" [x] %r:%r" % (routing_key, body))
    # 真正的处理业务
    eval("{}('{}','{}','{}','{}','{}')".format(target_type, target, routing_key, action, target_type, code))
    print(" [x] Done")


if __name__ == "__main__":
    c1 = Custom()
    c1.handle(callback_func)

# 模拟启动消费者服务:
# python custom.py
# nohup python -u custom.py 2> output                 # 错误输出
# nohup python -u custom.py > output 2>&1 &            # 错误输出和标准输出 后台运行进程
