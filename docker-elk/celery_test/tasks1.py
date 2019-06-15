# http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html
# import os
# import sys
# import django

# sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
# sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),"mxshop"))
# print(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))  # message
# print(sys.path)  # 查看加载的包
# # 在pycharm编辑器运行时,会将当前工程的所有文件夹路径都作为包的搜索路径:而在命令行中运行时,只是搜索当前路径
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mxshop.mxshop.settings')
# django.setup() # 加载项目的配置,这里主要为了连接数据库

from celery import Celery
import time

HOST_IP = "127.0.0.1"
app = Celery('tasks',backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP),\
            result_backend='redis://{}:6379/0'.format(HOST_IP))

# 默认存储结果是在amqp协议中的mq中:
# app = Celery('tasks',backend='amqp', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP))



@app.task
def add1(x, y):
    time.sleep(5)
    return x + y


"""
# 先启动mq,redis服务,并安装celery,redis的python包
# 再cd(celery_test)到本py文件的目录下,运行work
celery -A tasks1 worker -l info  # --loglevel=info
# 然后在另一个终端运行 python (也是在celery_test目录下)
from tasks1 import add1
add1.delay(4, 4)
result = add1.delay(4, 4)
result.ready() # 检查存储是否生效

docker exec -it dockerfiles_web_1 bash
cd /opt/project/docker-elk/celery  # pycharm启动

# redis存储时,result_backen指明后,必须还要写指明backend
"""

