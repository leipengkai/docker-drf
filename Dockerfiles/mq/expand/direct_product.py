#!/usr/bin/env python
#-*- coding:utf-8 -*-

import re
import sys
import json
import pika
from config import *
from util import get_mq_channel


class Product():
    """
    消息队列的生产者:主要是通过短信和邮件获得验证码
    """
    def __init__(self, target, code, template, ip=None, **kwargs):
        """
        :param target: mobile email 平台的发送目标 e.g: mobile:139xx99 email:16xx3@qq.com
        :param code: 自定义发送内容  e.g: mobile:8888
        :param template: 指定平台的发送信息的模板样式,同时也是队列的路由关键字 e.g: mobile:sms_register email:email_info
        :param ip:
        :param kwargs:
        """
        self.target = target
        self.code = code
        self.routing_key = template

    def verification_target(self):
        """
          鉴别target是否有效
        :return:
        """
        # 所有邮箱
        email_com = re.compile(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
        emailmatch = email_com.match(self.target)
        if emailmatch:
            return True
        # 支持短信功能的中国大陆手机号码
        mobile_com = re.compile(r'^(?:\+?86)?1(?:3\d{3}|5[^4\D]\d{2}|8\d{3}|7(?:[01356789]\d{2}|4(?:0\d|1[0-2]|9\d))|9[189]\d{2}|6[567]\d{2}|4[579]\d{2})\d{6}$')
        mobilematch = mobile_com.match(self.target)
        if mobilematch:
            return True
        return False

    def send(self):
        """
        生产者产生消息
        """
        body = {"target":self.target,"code":self.code,"routing_key":self.routing_key}
        body_json = json.dumps(body).encode('utf8')
        connection, channel = get_mq_channel()


        channel.exchange_declare(exchange=MQEXCHANGE, exchange_type=MQEXCHANGETYPE)
        channel.basic_publish(
            exchange=MQEXCHANGE, routing_key=self.routing_key, body=body_json,
        )

        # channel.queue_declare(queue=self.routing_key, durable=True)  
        # channel.basic_publish(
            # exchange=MQ_EXCHANGE, routing_key=self.routing_key, body=body_json,
                # properties=pika.BasicProperties( delivery_mode=2,)  # make message persistent)
            # )
        print(" [x] Sent %r:%r" % (self.routing_key, self.code))
        connection.close()



if __name__ == '__main__':
    if len(sys.argv) == 1 or sys.argv[1] == "email_info" :
        p1 = Product(TESTEMAIL,"8899","email_info")
        if p1.verification_target():
            p1.send()

    elif sys.argv[1] == "sms_register":
        p1 = Product(TESTMOBILE,"52088","sms_register")
        if p1.verification_target():
            p1.send()
    elif sys.argv[1] == "sms_login":
        p1 = Product(TESTMOBILE,"52099","sms_login")
        if p1.verification_target():
            p1.send()


# python direct_product.py 
# python direct_product.py "sms_register"
# python direct_product.py "sms_login"
