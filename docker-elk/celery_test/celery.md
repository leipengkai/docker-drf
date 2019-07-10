### 为什么使用Celery
- 在程序运行过程中,要执行一个很久的任务,但是我们又不想主程序被阻塞,常见的方法是多线程.
- 可是当并发量过大时,多线程也会扛不住,必须要用线程池来限制并发个数,而且多线程对共享资源的使用也是很麻烦的事情.
- 协程毕竟还是在同一线程内执行的,如果一个任务本身就要执行很长时间,而不是因为等待IO被挂起,那其他协程照样无法得到运行
- 强大的分布式任务队列Celery,它可以让任务的执行同主程序完全脱离,甚至不在同一台主机内.
- 它通过队列来调度任务,不用担心并发量高时系统负载过大.它可以用来处理复杂系统性能问题,却又相当灵活易用
- celery是一个基于python开发的简单,灵活且可靠的分布式任务队列框架,支持使用任务队列的方式在分布式的机器/进程/线程上执行任务调度.采用典型的生产者-消费者模型



### celery的组成:
![celery的组成](https://i.loli.net/2019/06/15/5d044a527883132186.png)

- 消息中间件(message broker)
    - 消息队列broker：broker实际上就是一个MQ队列服务，可以使用redis、rabbitmq等作为broker
    - Celery本身不提供消息服务,但是可以方便的和第三方提供的消息中间件集成(Redis,RabbitMQ)
    - 任务队列中保存(Redis,RabbitMQ)的是task,将需要执行的任务加入到队列中,以供工人来按顺序执行
    - 消息队列(MQ):一种在线程或机器间分发任务的机制.可以理解成两个应用程序间(生产者消费者间)的通信
- 任务执行单元(Worker:职程)
    - 处理任务的消费者workers：broker通知worker队列中有任务，worker去队列中取出任务执行，每一个worker就是一个进程
    - 执行任务的程序,可以有多个并发.它实时监控消息队列,获取队列中调度的任务,并执行它
    - 在一个新进程中,负责执行队列中的任务
- 执行结果存储(Backend)
    - 存储结果的backend：执行结果存储在backend，默认也会存储在broker使用的MQ队列服务中，也可以单独配置用何种服务做backend
    - 由于任务的执行同主程序分开,如果主程序想获取任务执行的结果,就必须通过中间件存储
    - 另外,并非所有的任务执行都需要保存结果,这个模块可以不配置.

### 应用场景举例:
- web应用:当用户在网站进行某个操作需要很长时间完成时,我们可以将这种操作交给Celery执行,直接返回给用户,等到Celery执行完成以后通知用户,大大提好网站的并发以及用户的体验感

- 任务场景:比如在运维场景下需要批量在几百台机器执行某些命令或者任务,此时Celery可以轻松搞定

- 定时任务:向定时导数据报表,定时发送通知类似场景,虽然Linux的计划任务可以帮我实现,但是非常不利于管理,而Celery可以提供管理接口和丰富的API

### 实例演示
```bash
# 先安装和启动mq,redis服务,并安装celery,redis的python包
pip install celery redis
# redis作为结果存储时,必须要安装redis
```
> 说明:
- 任务task:就是一个Python函数,会将耗时程序封装成函数,再包装成任务
- [celery的一些参数设置](https://docs.celeryproject.org/en/latest/userguide/configuration.html)

#### [简单例子](http://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html)
vim celery_test/tasks1.py
```python
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

# 然后在另一个终端运行 python (也是在celery_test目录下),模拟添加任务
from tasks1 import add1
add1.delay(4, 4)
result = add1.delay(4, 4)
result.ready() # 检查存储是否生效
# redis存储时,result_backen指明后,必须还要写指明backend
"""

```

#### [django+celery](http://docs.celeryproject.org/en/latest/django/first-steps-with-django.html#using-celery-with-django)

> 项目/项目设置目录/创建celery.py,提供主要配置:

vim mxshop/mxshop/celery.py
```python
from __future__ import absolute_import, unicode_literals
import os
from celery import Celery

# http://docs.celeryproject.org/en/latest/django/first-steps-with-django.html#using-celery-with-d
# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mxshop.settings')

HOST_IP = "127.0.0.1"
app = Celery('mxshop' , backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}:5672//'.format(HOST_IP),\
             result_backend='redis://{}:6379/0'.format(HOST_IP))

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))


```

> 项目/项目设置目录/配置初始化设置:

vim mxshop/mxshop/__init__.py

```python
from __future__ import absolute_import, unicode_literals

# This will make sure the app is always imported when
# Django starts so that shared_task will use this app.
from .celery import app as celery_app

__all__ = ['celery_app']

```

> 项目/app_name/创建tasks.py,必须以tasks.py命名:

vim mxshop/app/goods/tasks.py
```python

# -*- coding: utf-8 -*-

import time
from celery import task,shared_task


@shared_task
def add(x,y):
    print("\n开始发送msg")
    time.sleep(5)
    print("\n[Done]")
    return x+y
# 注意tasks.py必须建在各app的根目录下，且只能叫tasks.py，不能随意命名
```

> 用API的形式去调用任务:

vim mxshop/app/goods/views.py
```python

from .tasks import add

    .....
    def retrieve(self, request, *args, **kwargs):
        result = add.delay(1,2)
        print(result.ready())


```

> 生成任务以及启动work:

```bash
# 生成任务:
http://0.0.0.0/api/v1/goods/1/

# 如果之前的work(简单示例的那个work)没有关闭,则会使用之前的work,导致执行失败,必须先关闭之前的work
# 谁先启动work就使用谁的work
# 启动work
# cd mxshop目录下运行work(同manage.py的目录下)

celery -A mxshop  worker -l info
```

### django+celery+docker-compose

> 修改mq以及redis的连接方法

vim mxshop/mxshop/celery.py
```

from __future__ import absolute_import, unicode_literals
import os
from celery import Celery


HOST_IP = "192.168.43.173"  # 不能再是127.0.0.1之类的ip
app = Celery('mxshop' , backend='redis',\ 
             broker='pyamqp://rabbitmq:rabbitmq@{}:5672//'.format(HOST_IP),\
             result_backend='redis://redis:6379/0') 
# mq连接成功 redis失败 和docker-compose.yml启动有关
        # command: celery worker -A mxshop -l info -Q default -n default@%h

# 成功 #  command: celery worker -A mxshop -l info


# app = Celery('mxshop') # 使用settings.py中的设置失败

# app = Celery('mxshop' , backend='redis', broker='pyamqp://rabbitmq:rabbitmq@mq:5672//',\
                 result_backend='redis://redis:6379/0') 
# mq连接失败 redis失败 # command: celery worker -A mxshop -l info -Q default -n default@%h


app = Celery('mxshop' , backend='redis', broker='pyamqp://rabbitmq:rabbitmq@mq:5672//'.format(HOST_IP),\
             result_backend='redis://redis:6379/0') 
# mq连接失败 command: celery worker -A mxshop -l info


app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))

```

> 配置修改worker的启动方式

vim docker-compose.yml
```python
    worker:
        build: ../mxshop
        restart: always
        networks:
          - front-tier
          - back-tier
        # command: celery worker -A mxshop -l info -Q default -n default@%h
        command: celery worker -A mxshop -l info

        volumes:
          - '../mxshop:/code'
        links:
            - web
            - mq

        # 没有启动docker worker服务时,手动启动worker的方式
        # docker exec -it dockerfiles_web_1 bash
        # celery worker -A mxshop -l info -b amqp://rabbitmq:rabbitmq@192.168.43.173:5672  \
            --result-backend redis://192.168.43.173:6379/0
```


### 不使用django-celery包的说明
下面是较前django版本中,以及使用django-celery,不再适用
- django和celery能同步更新,而django-celery更新很慢,导致有很多的bug
- django-celery也会多出,很多步骤
- 只是当做记录,可以不用往下看了
- [简单实例](https://github.com/leipengkai/test1/commit/bdb76c011034d5f05f2bb9adbc2cfe6d5ad04321)
- 需要安装的包以及表:

```bash
pip install celery django-celery django-kombu

ERROR: django-celery 3.3.0 has requirement celery<4.0,>=3.1.15, but you'll have celery 4.0.1 which is incompatible.
Successfully built billiard anyjson
docker commit -m "celery django-celery package depend question" 10f4e7a05ab4 dockerfiles_web:latest
docker exec 
celery worker -A mxshop -l info -b amqp://rabbitmq:rabbitmq@192.168.50.133:5672

不需要django-celery django-kombu这两个包
这样就可以防止,django-celery包不能跟上celery的更新速度的问题,而且它们的结合也没有一个官方的使用说明(依赖关系,使用教程)

https://github.com/celery/celery/issues/3107
INSTALLED_APPS = (
    '....'
    'djcelery',
    'djkombu',
 )

# 生成djcelery,djkombu需要的表
python manage.py migrate
```

### 完成过程(简单实例已经成功实现,与下面过程的代码有出入)
- [最初步骤以及邮件相关设置](https://www.cnblogs.com/yiwi515/p/7580612.html)
    - 当启动celery的任务时:python manage.py  celery worker --loglevel=info,出现参数解析错误
    - 所以下一步是换一种启动celery方法
- [单独启动celery的配置](https://www.jianshu.com/p/6f8576a37a3e)
    - celery worker -A test1 -l info ,启动成功
    - celery worker -A mxshop -l info ,启动成功
    - 但默认BROKER\_URL是去连接RabbitMQ,由于没有启动 RabbitMQ,所以会报下面的错误:
    - ERROR/MainProcess] consumer: Cannot connect to amqp://guest:\*\*@127.0.0.1:5672//: [Errno 10061] .

- [改变BROKER\_URL值](https://stackoverflow.com/questions/18133249/django-celery-cannot-connect-to-amqp-guest127-0-0-80005672)
    - 改成使用Django数据库的开发版Message Queue,需要额外表的支持,所以会报如下错
    - ProgrammingError: (1146, "Table 'test.djkombu\_queue' doesn't exist")
    - 当然了可以用redis:BROKER\_URL = 'redis://localhost:6379/1' 
- [安装django-kombu,并生成对应的表](https://stackoverflow.com/questions/26243706/django-celery-djkombu-queue-table-no-created)
    - pip install django-kombu
    - python manage.py migrate
- 然后运行项目就可以了


参考资料:
- [分布式任务队列Celery的介绍](http://www.bjhee.com/celery.html)
- [分布式任务队列Celery使用说明](https://www.hongweipeng.com/index.php/archives/1676/)
