from __future__ import absolute_import, unicode_literals
import os
from celery import Celery

# http://docs.celeryproject.org/en/latest/django/first-steps-with-django.html#using-celery-with-d
# set the default Django settings module for the 'celery' program.
# celery+django 的mq和redis的连接居然多坑
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mxshop.settings')


# HOST_IP = "0.0.0.0" # 不能再是127.0.0.1之类的ip
HOST_IP = "192.168.50.242"
# HOST_IP = "192.168.43.173"
app = Celery('mxshop' , backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}:5672//'.format(HOST_IP)) # , result_backend='redis://redis:6379/0') # docker-compose up一

# app = Celery('mxshop' , backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}:5672//'.format(HOST_IP), result_backend='redis://redis:6379/0') # docker-compose up二


# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')
# app.conf.update(
#     CELERY_BROKER_URL = 'amqp://localhost',
#     BROKER_URL = 'amqp://rabbitmq:rabbitmq@localhost:5672/',  # connect RabbitMQ
#     CELERY_TASK_SERIALIZER = 'json',
#     CELERY_ACCEPT_CONTENT = ['json'],
#     CELERY_RESULT_SERIALIZER = 'json',
#     CELERY_TIMEZONE = 'Asia/Shanghai',
#     CELERY_ENABLE_UTC = True
# )

# Load task modules from all registered Django app configs.
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
