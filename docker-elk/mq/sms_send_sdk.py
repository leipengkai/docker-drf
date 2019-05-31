#!/usr/bin/env python
#coding=utf-8

# pip install aliyun-python-sdk-core

from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.request import CommonRequest
client = AcsClient('<accessKeyId>', '<accessSecret>', 'default')

request = CommonRequest()
request.set_accept_format('json')
request.set_domain('dysmsapi.aliyuncs.com')
request.set_method('POST')
request.set_protocol_type('https') # https | http
request.set_version('2017-05-25')
request.set_action_name('SendSms')

request.add_query_param('RegionId', "cn-hangzhou")
request.add_query_param('PhoneNumbers', "13925848599")
request.add_query_param('SignName', "快乐生活")
request.add_query_param('TemplateCode', "SMS_166777256")
request.add_query_param('TemplateParam', "{\"code\":\"1111\"}")

response = client.do_action(request)
# python2:  print(response)
print(str(response, encoding = 'utf-8'))



