#!/usr/bin/env python
#-*- coding:utf-8 -*-

import sys
import json
import time

from config import *
from smsserver import sms
from emailserver import email
from util import get_mq_channel

class Custom():
    def __init__(self,routing_key):
        self.routing_key = routing_key
        self.connection, self.channel = get_mq_channel()


    def handle(self, callback_func):
        result = self.channel.queue_declare('', exclusive=False) # , durable=True) 
        # queue_name = self.routing_key
        queue_name = result.method.queue

        self.channel.queue_bind(
            exchange=MQ_EXCHANGE, queue=queue_name, routing_key=self.routing_key)

        def callback(ch, method, properties, body):

            time.sleep(5)
            callback_func(method,body)
            # self.channel.basic_ack(delivery_tag=method.delivery_tag)
        print(' [*] Waiting for logs. To exit press CTRL+C')
        self.channel.basic_consume( queue=queue_name, on_message_callback=callback)
        self.channel.start_consuming()


def callback_func(method,body):
    """
    预处理
    """
    routing_key = method.routing_key # eg:sms_register email_info
    key_list = routing_key.split("_")
    target_type = key_list[0] # sms:短信发送 email:邮件发送
    action =  key_list[1] # register info
    print(" [x] %r:%r" % (routing_key, body))
    d = json.loads(body,encoding="utf-8")
    target = d['target'] # 手机号 邮件号
    code= d['code'] # 验证码
    # 真正的处理业务
    eval("{}('{}','{}','{}','{}','{}')".format(target_type, target, code,routing_key,action,target_type))
    print(" [x] Done")



if __name__ == "__main__":
    if len(sys.argv) == 1 or sys.argv[1] == "email_info" :
        c1 = Custom("email_info")
        c1.handle(callback_func)
    elif sys.argv[1] == "sms_register":
        c1 = Custom("sms_register")
        c1.handle(callback_func)
    elif sys.argv[1] == "sms_login":
        c1 = Custom("sms_login")
        c1.handle(callback_func)



# python direct_custom.py "email_info"
# python direct_custom.py "sms_register"
# python direct_custom.py "sms_login"
# 交换机模式 精确匹配 一个routing_key对就一个队列(多个队列)
# 缺点:
# 不能持久化(不能回执自动确认),还不知道在使用交换机的模式下进行持久化
# 消费者需要指定 routing_key,才能消费 想要去掉指定值,只管消费(才有的simple_custom.py,simple_product.py)
