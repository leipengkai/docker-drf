# -*- coding: utf-8 -*-
"""
安装: https://docs.celeryproject.org/en/latest/userguide/monitoring.html#flower-real-time-celery-web-monitor
说明: https://flower.readthedocs.io/en/latest/man.html
flower:  Real-time monitor and web admin for Celery distributed task queue . monitoring tool

https://github.com/mher/flower

flower启动命令使用的配置文件
"""

# RabbitMQ management api
broker_api = 'pyamqp://rabbitmq:rabbitmq@192.168.50.130:5672//'

# Enable debug logging
logging = 'DEBUG'


address = '0.0.0.0' # 保证外网可以访问
port = 5555

basic_auth = ['rabbitmq:rabbitmq'] # 用户名：密码

persistent = True # 持久化celery tasks（如果为False的话，重启flower后，监控的tasks全部消失了！）
db = './flowerdb' # 持久化tasks存储的地方

""" --broker=
celery flower --broker=pyamqp://rabbitmq:rabbitmq@192.168.50.130:5672// 
celery flower --conf=flowerconfig.py 
celery flower --broker=pyamqp://rabbitmq:rabbitmq@192.168.50.130:5672// --conf=./flowerconfig.py  >> ./celery.log 2>&1 &
celery flower --broker=pyamqp://rabbitmq:rabbitmq@127.0.0.1:5672// --conf=./flowerconfig.py >/dev/null 2>&1 &

"""
