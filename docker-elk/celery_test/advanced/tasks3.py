#!/usr/bin/env python
# -*- coding:utf-8 -*-

from celery import Celery, Task
from celery.utils.log import get_task_logger
import time

import celery_setting

logger = get_task_logger(__name__)

HOST_IP = "127.0.0.1"

app = Celery()
app.config_from_object(celery_setting)

# 默认存储结果是在amqp协议中的mq中:
# app = Celery('tasks',backend='amqp', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP))


class demotask(Task):

    def on_success(self, retval, task_id, args, kwargs):   # 任务成功执行
        logger.info('task id:{} , arg:{} , successful !'.format(task_id,args))



    def on_failure(self, exc, task_id, args, kwargs, einfo):  #任务失败执行
        logger.info('task id:{} , arg:{} , failed ! erros : {}' .format(task_id,args,exc))


    def on_retry(self, exc, task_id, args, kwargs, einfo):    #任务重试执行
        logger.info('task id:{} , arg:{} , retry !  einfo: {}'.format(task_id, args, exc))

@app.task(base=demotask,bind=True)
def add(self,x, y):
    time.sleep(5)
    return x + y

@app.task
def add1(x, y):
    time.sleep(5)
    return x + y

@app.task
def add2(x, y):
    time.sleep(5)
    return x + y

"""
# 先启动mq,redis服务,并安装celery,redis的python包
# 再cd(celery_test)到本py文件的目录下,运行work
celery worker -A tasks3 --loglevel=info --queues=celery,queue_add_reduce
celery worker -A tasks3 --loglevel=info --queues=queue_sum


from tasks3 import add, add1, add2
add.delay(4, 4)
add1.delay(3, 3)
add2.delay(2, 2)

result = add.delay(4, 4)
result1 = add1.delay(4, 4)
result2 = add2.delay(4, 4)
result.ready() 
result1.ready()
result2.ready() 

"""

