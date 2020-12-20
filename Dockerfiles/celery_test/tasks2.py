from celery import Celery
import time

from celery.schedules import crontab

HOST_IP = "127.0.0.1"
app = Celery('tasks',backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP),\
            result_backend='redis://{}:6379/0'.format(HOST_IP))

@app.on_after_configure.connect
def setup_periodic_tasks(sender, **kwargs):
    sender.add_periodic_task(10.0, add.s(1,3), name='1+3=') # 每10秒执行add
    sender.add_periodic_task(
        crontab(hour=16, minute=56, day_of_week=1),      #每周一下午四点五十六执行sayhai
        sayhi.s('wd'),name='say_hi'
    )



@app.task
def add(x,y):
    print(x+y)
    return x+y


@app.task
def sayhi(name):
    return 'hello %s' % name


# 默认存储结果是在amqp协议中的mq中:
# app = Celery('tasks',backend='amqp', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP))




"""
# 先启动mq,redis服务,并安装celery,redis的python包
# 再cd(celery_test)到本py文件的目录下,运行work
celery -A tasks2 worker -B -l info  # --loglevel=info
# 确保只启动一个worker(我在docker-compose启动了一个worker,这里从启动了一个则会有错,大概是Some Celery tasks work, others are NotRegistered)
# -B 是 celery 的 beat 服务，可以理解为一个周期任务。
# 会生成: celerybeat-schedule.db文件
"""

