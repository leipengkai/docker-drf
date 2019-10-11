```
.
├── README.md
├── __init__.py
├── celery.log  # celery日志文件, 启动flower时,将日志重定向到此文件
├── celery_revokes_state.db # celery存储revokes状态(Persistent revokes)
├── celery_setting.py # celery,mq的设置文件
├── flowerconfig # flower配置
├── flowerdb.db # celery 存储task, 启动flower生成此文件
└── tasks3.py # 模拟任务


cd ../../Dockerfile
docker-compose up # mxshop项目中启动了一个mq服务

# 创建mq队列以及celery task
celery worker -A tasks3 --loglevel=info --queues=celery,queue_add_reduce

# 启动flower 实时监控celery任务, 命令行配置覆盖配置文件内容
celery flower --broker=pyamqp://rabbitmq:rabbitmq@127.0.0.1:5672// --conf=flowerconfig
# celery flower --broker=pyamqp://rabbitmq:rabbitmq@127.0.0.1:5672// --conf=flowerconfig  >> ./celery.log 2>&1 &

# flower ui-web 地址
http://0.0.0.0:5555/

# 分配任务
ipyhton
from tasks3 import add, add1, add2
# 一个一个执行下面任务
add.delay(4, 4)
add1.delay(3, 3)
add2.delay(2, 2) # 由于此任务绑定的队列没有启动(--queues=queue_sum), 此任务将执行失败


```

[简单了解Flower: Real-time Celery web-monitor](https://docs.celeryproject.org/en/latest/userguide/monitoring.html#flower-real-time-celery-web-monitor)
- flower: Real-time monitor and web admin for Celery distributed task queue . monitoring tool
- [官方文档说明](https://flower.readthedocs.io/en/latest/man.html), [github地址](https://github.com/mher/flower)
- [flower命令请求参数](https://github.com/mher/flower/blob/master/docs/config.rst)
