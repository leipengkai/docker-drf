#!/usr/bin/env python
# -*- coding:utf-8 -*-


import json
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.request import CommonRequest
from config import *
from db import *


def sms_pubilc_param(mobile, routing_key, action):
    # client = AcsClient('<accessKeyId>', '<accessSecret>', 'default')
    client = AcsClient(ACCESSKEYID, ACCESSSECRET, 'cn-hangzhou')

    request = CommonRequest()
    # 固定参数
    request.set_accept_format('json')  # 格式
    request.set_domain('dysmsapi.aliyuncs.com')  # 短信域名
    request.set_method('POST')
    request.set_protocol_type('https')  # https | http
    request.set_version('2017-05-25')  # 版本
    request.set_action_name('SendSms')  # 发送信息
    request.add_query_param('RegionId', "cn-hangzhou")  # 短信API的值
    request.add_query_param('SignName', SIGNNAME)  # 短信签名名称

    # 业务参数
    request.add_query_param('PhoneNumbers', mobile)

    # 短信模板
    template_code = ""
    if action == "register":
        template_code = TEMPLATECODEREG
    elif action == "login":
        template_code = "SMS_xxx"
    return request, template_code, client


def sms(mobile, routing_key, action, target_type, code=None):
    """
    发送短信
    :param mobile: 邮件
    :param routing_key: 路由关键字 eg: sms_register
    :param action: 类型动作 eg: register login
    :param target_type: 消息类型 eg: sms
    :param code: 随机码
    :return:
    """
    request, template_code, client = sms_pubilc_param(mobile, routing_key, action)
    request.add_query_param('TemplateCode', template_code)  # 短信模板ID
    if code:
        request.add_query_param('TemplateParam', json.dumps({'code': code}))  # 自定义code

    # 发送短信
    response = client.do_action_with_exception(request)
    # 打印回调信息
    print(str(response, encoding='utf-8'))

    # 记录日志
    MysqlClient().add(target=mobile, type=target_type, code=code, routing_key=routing_key,
                      template_code=template_code, )
    print('短信已经发送,并加入日志')
