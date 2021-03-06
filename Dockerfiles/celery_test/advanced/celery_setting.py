# -*- coding: utf-8 -*-
import datetime
from celery.schedules import crontab
from kombu import Exchange, Queue


####################################
# Broker settings #
####################################

HOST_IP = "127.0.0.1"
BROKER_URL = 'pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP)
# BROKER_URL = 'amqp://artcm:111@192.168.1.193:5672//'
# BROKER_URL = 'redis://localhost:6379/1'
BROKER_POOL_LIMIT = 10 # 默认celery与borker的连接池连接数

# List of modules to import when celery starts.
CELERY_IMPORTS = ('tasks3', )

# 存储revokes状态(Persistent revokes)
CELERYD_STATE_DB = './celery_revokes_state'



####################################
# 默认task结果存储配置 #
# 建议：存储结果会浪费很多资源，业务上非必须的话，不存储结果
####################################
CELERY_RESULT_BACKEND = 'redis://{}:6379/0'.format(HOST_IP)
# CELERY_IGNORE_RESULT = True # celery结果忽略
## Using the database to store task state and results.
# CELERY_RESULT_BACKEND = 'mongodb://192.168.1.121:27017/'
# CELERY_MONGODB_BACKEND_SETTINGS = {
#   'database': 'celery_backend',
#   'taskmeta_collection': 'task_result',
#   'max_pool_size':10,
# }




####################################
# 默认频次限制配置 #
# 建议：频次内部实现灰常复杂，最好不要使用
####################################
CELERY_DISABLE_RATE_LIMITS = True # 不使用频次限制
# '1/s'每秒,'1/m'每分钟, '1/h'每小时 (每个task每秒最多执行频次,多出的任务为received状态，等待一段时间后执行，特别注意：这样就有可能导致有的任务会延迟执行)
# CELERY_DEFAULT_RATE_LIMIT = '10000/m' 


####################################
# 一般配置 #
####################################
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'
CELERY_ACCEPT_CONTENT=['json']
CELERY_TIMEZONE = 'Asia/Shanghai'
CELERY_ENABLE_UTC = True
# CELERY_MESSAGE_COMPRESSION = 'gzip' # 如果发送的tasks参数信息量较大，则使用压缩传输


####################################
# 默认log配置 #
####################################
CELERYD_LOG_FILE="./celery.log"


####################################
# 默认邮件配置 #
# 注意：如果是task中retry了，最后failure，不会发出邮件(待研究)　#
####################################

# CELERY_SEND_TASK_ERROR_EMAILS = True #celery接收错误邮件  
# ADMINS = (  
    # ("minkedong", "190926234@qq.com"), # celery接收错误邮件地址  
# )
# SERVER_EMAIL = "minkedong89@126.com" # 从哪里发送的错误地址  
# EMAIL_HOST = "smtp.126.com"
# EMAIL_HOST_USER = SERVER_EMAIL
# EMAIL_HOST_PASSWORD = 'xxxxxxxx'
# EMAIL_PORT = 25
# EMAIL_USE_SSL = False
# EMAIL_USE_TLS = False
# EMAIL_TIMEOUT = 2 # 2秒

####################################
# 其它配置 #
####################################
# celery worker的并发数，默认是服务器的内核数目,也是命令行-c参数指定的数目
CELERYD_CONCURRENCY = 4 


####################################
# routing #
####################################
##### 队列属性定义 ####
# 相当于定义RabbitMQ中的"队列、交换机、绑定"机制（跟celery无关）（可以使用同一个交换机绑定多个队列）
# 没有在CELERY_ROUTES中的task，默认发送到"celery"队列中
CELERY_QUEUES = (
    Queue('queue_add_reduce', exchange=Exchange('calculate_exchange', type='direct'), routing_key='key1'),
    Queue('queue_sum', exchange=Exchange('calculate_exchange', type='direct'), routing_key='key2'),
    Queue('celery', Exchange('celery'), routing_key='celery'), # 里面使用的都是默认参数值
)
CELERY_DEFAULT_QUEUE = 'celery'
CELERY_DEFAULT_EXCHANGE_TYPE = 'direct'
CELERY_DEFAULT_ROUTING_KEY = 'celery'

###### 路由：taks对应发送的队列及使用的routing_key #####
# delivery_mode参数(决定tasks发送到RabbitMQ后，是否存储到磁盘中)（celery默认使用２：持久化方式）：
# １表示rabbitmq不存储celery发送的tasks到磁盘,RabbitMQ重启后，任务丢失（建议使用这种方式）
# ２表示rabbitmq可以存储celery发送的tasks到磁盘，RabbitMQ重启后，任务不会丢失（磁盘IO资源消耗极大，影响性能）
CELERY_ROUTES = {
    'tasks3.add': {'queue': 'celery', 'routing_key': 'key1', 'delivery_mode': 1},
    'tasks3.add1': {'queue': 'queue_add_reduce', 'routing_key': 'key1', 'delivery_mode': 1},
    'tasks3.add2': {'queue': 'queue_sum', 'routing_key': 'key2', 'delivery_mode': 1},
}


# 每分钟内允许执行的10个任务 
# celery -A tasks control rate_limit tasks.add 10/m
task_annotations = {
            'tasks3.add': {'rate_limit': '10/m'}
        }

"""
注意设置celery的worker预取值“ CELERYD_PREFETCH_MULTIPLIER “，如果你的task是很耗时的任务，最好设置为1，避免造成队列拥堵。如果你的task是非耗时的任务，则可根据实际情况调大此值，提高吞吐量

最好设置task的软超时时间” CELERYD_TASK_SOFT_TIME_LIMIT “，如果任务超过此时间没有执行完成，则会报错celery.exceptions.SoftTimeLimitExceeded（可在代码中捕获做相应业务处理），避免造成队列拥堵

一定要设置“ CELERYD_MAX_TASKS_PER_CHILD ”，此值表示每个worker工作进程在执行了多少task之后便重新建立worker进程，解决celery的内存泄漏问题

"""
